% Reduces the noise of a signal using weiner filtering. Requires a sample
% of the noise (v)


function z = MAA_WeinerFilter(y,v,forgetFactX,forgetFactV,windowLength, ...
    regParam)

% create hanning window
window = MAA_HannWindows(windowLength,'p');
% Identity matricies
covY = eye(windowLength);
covV = eye(windowLength);
% Empty out vector
z = zeros(length(y),1);

% averaged noise covariance matrix from sample of noise
for j = 1:length(v)-windowLength

    covV = (forgetFactV * covV) + (1-forgetFactV) * ...
        ( v(j:(windowLength-1)+j)*v(j:(windowLength-1)+j)');

end

% Input/observed signal covariance matrix and weiner filter
for i = 1:length(y)-windowLength
    
    % obs cov
    covY = (forgetFactX * covY) + (1-forgetFactX) * ...
        (y(i:(windowLength-1)+i)*y(i:(windowLength-1)+i)');
    covY = covY*(1-regParam)+(regParam)* ...
        trace(covY)/windowLength*eye(windowLength);
    
    % filter
    if mod(i,(windowLength/2)) == 0
        
        Hw = (eye(windowLength) - covV\(covY));
        z(i:i+(windowLength-1)) = z(i:i+(windowLength-1)) + ...
            (window.*(Hw'*y(i:i+(windowLength-1))));
        
    end
end
