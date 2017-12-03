function avgWidth = getAvgWidth(frame, alpha, beta)
% Compute the average width of the leg region in each gait silhouette
%		Input : 
%			frame : 	original gait sequence (H-by-W-by-T)
%			alpha, beta : 	two parameters to constrain the
%					computation to the leg region
%		Output : 
%			avgWidth : 	the average width of the leg region (1-by-T)

[height, width, length] = size(frame);
avgWidth = zeros(1, length);
for t = 1 : length;
    cnt = 0;
    % find the most top pixel of the foreground
    minh = -1;
    for i = 1 : height;
        for j = 1 : width;
            if (frame(i, j, t) == 0)
                minh = i;
                break;
            end;
        end;
        if (minh ~= -1)
            break;
        end;
    end;
    % find the most bottom pixel of the foreground
    maxh = -1;
    for i = height : -1 : 1;
        for j = 1 : width;
            if (frame(i, j, t) == 0)
                maxh = i;
                break;
            end;
        end;
        if (maxh ~= -1)
            break;
        end;
    end;
    if ((minh == -1) || (maxh == -1))
        continue;
    end;
    % decide the leg region
    low = round(minh + (maxh - minh) * alpha);
    high = round(minh + (maxh - minh) * beta);
    % compute the average width for this frame
    for i = low : high;
        for j = 1 : width;
            if (frame(i, j, t) ~= 0);
                pre = j;
                break;
            end;
        end;
        for j = width : -1 : 1;
            if (frame(i, j, t) ~= 0);
                avgWidth(t) = avgWidth(t) + j - pre;
                cnt = cnt + 1;
                break;
            end;
        end;
    end;
    if (cnt ~= 0)
        avgWidth(t) = avgWidth(t) / cnt;
    else
        avgWidth(t) = -1;
    end;
end;