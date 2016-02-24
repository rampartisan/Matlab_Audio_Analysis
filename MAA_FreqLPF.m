function Zf = MAA_FreqLPF(Z,cutBin)

Zf = zeros(size(Z));

for idx = 1:size(Z,2);

    magX = abs(Z(:,idx));
    phaseX = angle(Z(:,idx));  
    
    magY = zeros(size(magX));
    magY(1:cutBin) = magY(1:cutBin) + magX(1:cutBin);    
    
    Zf(:,idx) =  magY .* exp(1i*phaseX);
        
end