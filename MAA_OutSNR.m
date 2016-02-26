% Calculate ouput SNR of input y using input x as reference

function y = MAA_OutSNR(x,y)

signalPow = rssq(x(:)).^2;
noisePow  = rssq(y(:)).^2;
y = 10 * log10(signalPow / noisePow);

end