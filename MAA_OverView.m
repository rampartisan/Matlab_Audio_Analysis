%% Matlab Audio Analysis
[x,Fs] = audioread('acousticGtr.wav');
soundsc(x,Fs);

%% SNAC Pitch Detection - inefficent, do not recomend long sounds!
% y(vector of pitches)= (input,sampleRate,window size)
y = MAA_SNAC(x,Fs,2048);

%% Mix Signal and Noise to Ratio
% y(input+Noise)= (Signal,Noise,Ratio (eg 1/1))
[x,Fsi] = audioread('twoMaleTwoFemale20Seconds.wav');
[v,Fsj] = audioread('babble30Seconds.wav');
y = MAA_SNR(x,v,1/1);
