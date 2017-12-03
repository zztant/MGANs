function keyFrame = getKeyFrame(period)
% Period detection, find the key frames to separate the gait period
%		Input : 
%			startFrame : 	indicate the index of the first frame
%					which belongs to a complete gait sequence
%			period : 	estimated gait period
%		Output : 
%			keyFrame : 	indice of the key frames

n = size(period, 2);
keyFrame = [];
delta = 7;
cur = 1;
while (cur <= n)
    % find the local maximum
     for i = cur - delta : cur + delta;
        if ((i < 1) || (i > n) || (i==cur))
            continue;
        end;
        if (period(i) < period(cur))
            continue;
        else
            break;
        end;
    end;
    if i==cur+delta
        keyFrame = [keyFrame; cur];
    end
    cur = cur + 1;
end;
