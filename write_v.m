function write_v( s,v_name)
%write video file
v = VideoWriter(v_name,'Uncompressed AVI');
open(v)
for i=1:size(s,2)-1
    writeVideo(v,s(i).cdata)
end

close(v)

end

