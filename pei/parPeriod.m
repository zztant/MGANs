function [pei] = parPeriod(frameSequence,windowSize,channelNum,period)
for i=1:channelNum
    left = i/(channelNum+1);
    right = left + windowSize/2;
    left = left - windowSize/2;
    idx = (period>=left)&(period<=right);
    pei(i,:,:) = sum(frameSequence(idx,:,:),1)./sum(idx);
end

end

