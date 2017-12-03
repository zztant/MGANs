function [pei] = buildPEI(frameSequence, windowSize, channelNum)
% Compute the PEI of a gait silhouette sequence
%		Input : 
%			frameSequence : 	original gait sequence (T-by-H-by-W)
%			windowSize:         the window size covered in each channel
%           channelNum:         the channel number of PEI
%		Output : 
%			pei : 	            the pei template of the gait silhouette sequence (channelNum-by-64-by-64)

T = size(frameSequence,1);
if T==0
    pei = zeros(channelNum,64,64);
    return;
end
normalizedFrameSequence = zeros(T,64,64);
for i=1:T
    normalizedFrameSequence(i,:,:) = frameNormalize(frameSequence(i,:,:));
end
[period,keyFrame] = getPeriod(normalizedFrameSequence);
ss = keyFrame(1);
ee = keyFrame(end);
normalizedFrameSequence = normalizedFrameSequence(ss:ee,:,:);
period = period(1,ss:ee);
pei = parPeriod(normalizedFrameSequence,windowSize,channelNum,period);
