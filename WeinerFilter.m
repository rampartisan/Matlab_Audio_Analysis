% Read audio
[x,Fsi] = audioread('twoMaleTwoFemale20Seconds.wav');
[v,Fsj] = audioread('babble30Seconds.wav');

% Make sure sample rates match
if Fsi ~= Fsj
    q = questdlg('Sample Rate Mismatch! Use input SR?');
    if q == 'Yes'
        Fs = Fsi;
        clearvars Fsi Fsj
    end
else
    Fs = Fsi;
    clearvars Fsi Fsj
end

% Signal to noise ratio
SNR = 1/1;
%forgetting factor
alphay = 0.985;
alphav = 0.995;
% Reg param
Rp = 1e-10;
% window size 
L = 40;
window = hann(L,'periodic');

% Get observed signal
y = MAA_SNR(x,v,SNR);
% get noise sample
vw = v(length(x):end);

% Identity matrix
Ry = eye(L);
Rv = eye(L);

% Empty Out
z = zeros(length(y),1);

% averaged noise cov from sample of noise 
for j = 1:length(vw)-L
Rv = (alphav * Rv) + (1-alphav) *( vw(j:(L-1)+j)*vw(j:(L-1)+j)');
end

% Observed cov and weiner filter
for i = 1:length(y)-L
% obs cov    
Ry = (alphay * Ry) + (1-alphay) * (y(i:(L-1)+i)*y(i:(L-1)+i)');
Ry = Ry*(1-Rp)+(Rp)*trace(Ry)/L*eye(L);
% filter
if mod(i,(L/2)) == 0
Hw = (eye(L) - Rv\(Ry));
z(i:i+(L-1)) = z(i:i+(L-1))+ (window.*(Hw'*y(i:i+(L-1))));
end
end

figure;
subplot(2,1,1);
plot(y)
subplot(2,1,2);
plot(z);

soundsc(z,Fs);