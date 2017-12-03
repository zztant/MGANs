function [period,keyFrame] = getPeriod(frameSequence)

period = getAvgWidth(permute(frameSequence,[2,3,1]), 46.5/64, 58/64);
tmp = period(period>0);
period = (period-min(tmp))/(max(tmp)-min(tmp));
keyFrame = getKeyFrame(period);
end

 
