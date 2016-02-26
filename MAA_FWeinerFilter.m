% Weiner Filter for noise reduction in the frequency domain. Requires 
% STFT matrix (Z) and returns the filterd matrix (Zf) use MAA_STFT and
% MAA_ISTFT to go into/out of freq domain 

function Zf = MAA_FWeinerFilter(Z,coeffs)

% Attack and Decay Coefficents, Alpha = Noise Estimator, Beta = Speech
% Smoother
alphaA = coeffs(1);
alphaD = coeffs(2);
betaA = coeffs(3);
betaD = coeffs(4);

% Pre-llocate output matrix and intialise noise/smoothing vectors
Zf = zeros(size(Z));
[smoothMag,noiseMag] = deal(zeros(size(Z,1),1));

%Iterate over each frame of the input STFT matrix
for idx = 1:size(Z,2);
    
    % get mag and phase for input frame
    magX = abs(Z(:,idx));
    phaseX = angle(Z(:,idx));
    
    % mangitude smoothing to reduce temporal flux
    smoothMag = (magX >= smoothMag) .* (betaA * smoothMag + (1-betaA) * magX) + ...
            (magX < smoothMag) .* (betaD * smoothMag + (1-betaD) * magX);  
    
    % Estimate the magnitude of the noise signal (assumed somewhat stationary)    
    noiseMag = (magX >= noiseMag) .* (alphaA * noiseMag + (1-alphaA) * magX) + ...
        (magX < noiseMag) .* (alphaD * noiseMag + (1-alphaD) * magX);
    
    % Calculate filter coeff's
    Hw = 1 - abs(noiseMag) ./ abs(magX);                  
       
    % Filter input magnitudes
    magXFilt = Hw .* magX;
    
    % Recombine phase and magnitude into complex number and place in the
    % filtered output matrix
    Zf(:,idx) =  magXFilt .* exp(1i*phaseX);
    
end