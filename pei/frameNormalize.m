function [normalizedFrame] = frameNormalize(img)

img = squeeze(img);
imgHeight = size(img,1);
imgWidth = size(img,2);
tmp = zeros(imgHeight,imgWidth+200);
tmp(:,100:imgWidth+100-1) = img;
img = tmp;

top = 0;
bottom = imgHeight;

for i=1:imgHeight
    if sum(img(i,:))~=0
        top = i;
        break;
    end
end

for i=imgHeight:-1:1
    if sum(img(i,:))~=0
        bottom = i;
        break;
    end
end

height = bottom-top;
halfWidth = floor(height*44/64/2);
intensity = sum(img,1);
ratio = cumsum(intensity)./sum(intensity);
[~,mid]=min(abs(ratio-0.5));
left = mid-halfWidth;
right = mid+halfWidth;
normalizedFrame = imresize(img(top:bottom,left:right),[64,64]);

end