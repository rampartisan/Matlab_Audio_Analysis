% This function returns the STFT of the input signal as a matrix of FFT
% frames. Windowsize and Overlap can be specified. Using Periodic Hamming
% window

function STFT = MAA_STFT(x,windowSize,overlap)

xLen = length(x);
% make window
window = MAA_HammWindows(windowSize,'p');
hopSize = floor(windowSize * overlap);
% empty out vectors
nRow = ceil((1+windowSize)/2);
nCol = 1+fix((xLen-windowSize)/hopSize);
STFT = zeros(nRow,nCol);
% index
idx = 1;
colIdx = 1;

% Compute STFT
while (idx+(windowSize-1) <= length(x))
    
% segment and window input according to index
windowedSig = x(idx:idx+(windowSize-1)) .* window;
% FFT
Z = fft(windowedSig,windowSize);
% store FFT of this frame in the STFT matrix
STFT(:,colIdx) = Z(1:nRow);
% index updates
idx = idx + hopSize;
colIdx = colIdx + 1;
end

end
