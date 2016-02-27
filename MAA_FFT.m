% Discrete Fourier Transform, returns a complex double (real+imag) vector
% the length of the windowSize specified.

% If the input signal is less than windowsize it is 0 padded, if it is
% longer then it is truncated.

function fft = MAA_FFT(x,windowSize)

fft = zeros(windowSize,1);
temp = zeros(windowSize,1);

% Make sure x is column vector
if(size(x,2) > size(x,1))
    x = x';
end

% if x is shorter than window, 0 pad
if x < 1024
x = [x;zeros(1024-length(x),size(x,2))];    
end

% if x is longer than window, truncate
if x > windowSize   
    x = x(1:windowSize);
end

% for each point in the output fft vector calculate the sum of
% x(n)*exp(...) and store
for k = 1:windowSize
    for n = 1:windowSize
    temp(n) = x(n)*exp(-j*2*pi*(k-1)*(n-1)/windowSize);
    end
     fft(k) = sum(temp);    
end

end