function y = MAA_STFT(x,windowSize,overlap)

% make window
window = MAA_HammWindows(windowSize,'p');
overlapSamps = floor(windowSize * overlap);

% empty out vector
y = [];
i = 1;

% Compute STFT
while (i+windowSize <= length(x))
windowedSig = x(i:i+(windowSize-1));
z = fft(windowedSig .* window, windowSize);
y = [y z(1:round(windowSize/2),1)];
i = i + (windowSize - overlapSamps);
end

% Plot
% F = (0:round(windowSize/2)-1)'/windowSize*Fs;
% T = (round(windowSize/2):(windowSize-overlapSamps):length(x)-1-round(windowSize/2))/Fs;
% y = 20*log10(abs(y));
% figure;
% imagesc(y,F,T);


spectrogram