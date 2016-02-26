% Low Pass filter in the frequency domain, very simple (and aggresive!)
% implimentaiton, shape of the filter is rectangular - a sharp rolloff.

% Requires STFT matrix (MAA_STFT) and then inverse STFT (MAA_ISTFT)

function Zf = MAA_FreqLPF(Z,cutBin)

% pre-allocate output STFT (filtered) matrix
Zf = zeros(size(Z));

% Itterate over each FFT input frame
for idx = 1:size(Z,2);
    
    % get mag and phase for each fft bin
    magX = abs(Z(:,idx));
    phaseX = angle(Z(:,idx));
    % allocate output magnitude vector
    magY = zeros(size(magX));
    % set magnitude of output bins below threshold to input (above
    % threshold stay 0)
    magY(1:cutBin) = magX(1:cutBin);
    % Combine mag and phase back to complex conjugate,
    % place the filted frame into the output matrix
    Zf(:,idx) =  magY .* exp(1i*phaseX);
    
end