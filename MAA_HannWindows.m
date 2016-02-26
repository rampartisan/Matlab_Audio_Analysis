% Hanning windows - Three types - casual, generalised cosine and periodic

function window = MAA_HannWindows(windowSize,type)

switch type
    case 'c'
% Casual - Both zeros out of window
window = 0.5*(1-cos(2*pi*(1:windowSize)'/(windowSize+1)));
    case 'g'
% Gen consine - both zeros (L+R) within window
window = 0.5*(1-cos(2*pi*(0:windowSize-1)'/(windowSize-1)));
    case 'p'
% Periodic -left zero endpoint included, right zero one sample out
window = 0.5*(1-cos(2*pi*(0:windowSize-1)'/(windowSize)));
end