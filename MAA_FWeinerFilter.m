function Zf = MAA_FWeinerFilter(Z,coeffs)

alphaA = coeffs(1);
alphaD = coeffs(2);
betaA = coeffs(3);
betaD = coeffs(4);


Zf = zeros(size(Z));
[smoothMag,noiseMag] = deal(zeros(size(Z,1),1));


for idx = 1:size(Z,2);

    magX = abs(Z(:,idx));
    phaseX = angle(Z(:,idx));

    smoothMag = (magX >= smoothMag) .* (betaA * smoothMag + (1-betaA) * magX) + ...
            (magX < smoothMag) .* (betaD * smoothMag + (1-betaD) * magX);  
              
    noiseMag = (magX >= noiseMag) .* (alphaA * noiseMag + (1-alphaA) * magX) + ...
        (magX < noiseMag) .* (alphaD * noiseMag + (1-alphaD) * magX);
    
    Hw = 1 - abs(noiseMag) ./ abs(magX);                  
       
    magXFilt = Hw .* magX;
    
    Zf(:,idx) =  magXFilt .* exp(1i*phaseX);
        
end