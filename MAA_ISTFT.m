% Computed the inverse STFT of an input STFT matrix, make sure the
% windowsize and overlap is the same used to compute the oringal STFT

function ISTFT = MAA_ISTFT(STFT,windowSize,overlap)

% calculate hopsize
hopSize = floor(windowSize * overlap);

% estimate output size
nCol = size(STFT,2);
outLen = windowSize + (nCol-1) * hopSize;
ISTFT = zeros(outLen,1);

% ISTFT for each "hop"
for i = 0:hopSize:(hopSize*(nCol-1))
        % extract FFT points
        X = STFT(:, 1+i/hopSize);
        X = [X; conj(X(end-1:-1:2))];        
        % IFFT
        xprim = real(ifft(X));
        ISTFT((i+1):(i+windowSize)) = ISTFT((i+1):(i+windowSize)) + xprim;
end
    
end