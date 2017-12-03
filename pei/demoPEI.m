
directory = './examples/';
files = dir(fullfile(directory,'*.png'));
lengthFrames = length(files);
frames = zeros(lengthFrames,240,320);
for i = 1:lengthFrames;
    frames(i,:,:) = imread(strcat(directory,files(i).name));
end

pei = buildPEI(frames, 0.4, 5);