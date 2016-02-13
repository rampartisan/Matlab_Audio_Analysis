function z = MAA_SNR(x,v,SNR)

% Cut noise down to length
v = v(1:length(x));

% Mix signal and noise to ratio SNR, need to know relative power first.
powerInput = sum(sum(x.^2));
powerOutput =  sum(sum(v.^2));
K = (powerInput/powerOutput);
z = x + (sqrt(K/SNR) * v);

end
