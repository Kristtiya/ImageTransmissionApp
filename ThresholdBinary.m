%% Calculates Threshold Value Based on Specified Percentage
function y = ThresholdBinary(Percentage,GrayImg)
    maxGray = max(GrayImg(:));
    minGray = min(GrayImg(:));
    y = minGray + (Percentage)*(maxGray - minGray); %Adjust based on image