% Short function to create Hamming windows, can be either Symetric or
% Periodic

function window = MAA_HammWindows(windowSize,type)

switch type
    case 's'
% Symetric
window = 0.54-0.46*cos(2*pi*(0:windowSize-1)'/(windowSize-1));
    case 'p'
% Periodic
window = 0.54-0.46*cos(2*pi*(1:windowSize)'/(windowSize));
end