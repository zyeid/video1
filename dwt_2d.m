function [ R_wavelet ] = dwt_2d( R )
%2D wavelet transform of all frames of the video(one color space R)

%% data structure for 4 transformation level for 'sym2' 
T(1,:)=[round(size(R,1)/2)+1 round(size(R,2)/2)+1]; % size subband of each level
T(2,:)=[round(T(1,1)/2)+1 round(T(1,2)/2)+1];
T(3,:)=[round(T(2,1)/2)+1 round(T(2,2)/2)+1];
T(4,:)=[round(T(3,1)/2)+1 round(T(3,2)/2)+1];

R_wavelet = struct( 'level_1',zeros(T(1,1),T(1,2),4,'double'),... % define structure
                    'level_2',zeros(T(2,1),T(2,2),4,'double'),...
                    'level_3',zeros(T(3,1),T(3,2),4,'double'),...
                    'level_4',zeros(T(4,1),T(4,2),4,'double'));
%% wavelet transform                
    for i=1: size(R,3)%for all frames
        [R_wavelet(i).level_1(:,:,1),R_wavelet(i).level_1(:,:,2),R_wavelet(i).level_1(:,:,3),R_wavelet(i).level_1(:,:,4)]=dwt2(R(:,:,i),'sym2');
        [R_wavelet(i).level_2(:,:,1),R_wavelet(i).level_2(:,:,2),R_wavelet(i).level_2(:,:,3),R_wavelet(i).level_2(:,:,4)]=dwt2(R_wavelet(i).level_1(:,:,1),'sym2');
        [R_wavelet(i).level_3(:,:,1),R_wavelet(i).level_3(:,:,2),R_wavelet(i).level_3(:,:,3),R_wavelet(i).level_3(:,:,4)]=dwt2(R_wavelet(i).level_2(:,:,1),'sym2');
        [R_wavelet(i).level_4(:,:,1),R_wavelet(i).level_4(:,:,2),R_wavelet(i).level_4(:,:,3),R_wavelet(i).level_4(:,:,4)]=dwt2(R_wavelet(i).level_3(:,:,1),'sym2');
    end
               
               

end

