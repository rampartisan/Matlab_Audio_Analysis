function z = MAA_WeinerFilter(y,v,forgetFactX,forgetFactV,windowLength, ...
    regParam)

% create hanning window
window = MAA_HannWindows(windowLength,'p');

% Identity matrix
covY = eye(windowLength);
covV = eye(windowLength);

% Empty Out
z = zeros(length(y),1);

% averaged noise cov from sample of noise
for j = 1:length(v)-windowLength

    covV = (forgetFactV * covV) + (1-forgetFactV) * ...
        ( v(j:(windowLength-1)+j)*v(j:(windowLength-1)+j)');

end

% Observed cov and weiner filter
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
