function [ s ] = Untitled( v_name )
%read a video file
vidObj = VideoReader('carphone.avi');
 s = struct('RGB',zeros(vidObj.Height,vidObj.Width,3,'uint8'),'YCbCr',zeros(vidObj.Height,vidObj.Width,3));
 k = 1;
while hasFrame(vidObj)
    s(k).RGB = readFrame(vidObj);
    %s(k).YCbCr = rgb2ycbcr(s(k).RGB);
    k = k+1;
end

end

