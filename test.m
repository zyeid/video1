clc; clear all; close all;%clearvars -except s R
load('s.mat')
load('R.mat')

% s=read_v('carphone.avi');
% for i=1:size(s,2)
%    R(:,:,i)=s(i).RGB(:,:,1);
% end



%% DWT3 transform
depth_1d=3;
n=floor(size(R,3)/depth_1d);
WT_level1=[];WT_level2=[];WT_level3=[];WT_level4=[];
H=[];
parfor kk=1:n
    k=(kk-1)*depth_1d+1;   
    x=R(:,:,k:k+depth_1d-1);
    y=dwt3(x,'db2');
    WT_level1=[WT_level1 y];
    y=dwt3(cell2mat(y.dec(1,1,1)),'db2');
    WT_level2=[WT_level2 y];   
    y=dwt3(cell2mat(y.dec(1,1,1)),'db2');
    WT_level3=[WT_level3 y]; 
    y=dwt3(cell2mat(y.dec(1,1,1)),'db2');
    
    WT_level4=[WT_level4 y];  
    h=cell2mat(y.dec(1,1,1));
    H=[H; reshape(h,[1 numel(h)])];
end
%% Insertion
H1=H+100;

%% IDWT3 transform

for kk=1:n
    k=(kk-1)*depth_1d+1;   
 
    
    h=reshape(H1(kk,:),[11 13 3]);%% add size to parameters of the function
    h=mat2cell(h,[size(h,1)],[size(h,2)],[size(h,3)]);
    WT_level4(kk).dec(1,1,1)=h;
    
    x=idwt3(WT_level4(kk));
    WT_level3(kk).dec(1,1,1)=mat2cell(x,[size(x,1)],[size(x,2)],[size(x,3)]); 

    
    x=idwt3(WT_level3(kk));
    WT_level2(kk).dec(1,1,1)=mat2cell(x,[size(x,1)],[size(x,2)],[size(x,3)]);
    
    x=idwt3(WT_level2(kk));
    WT_level1(kk).dec(1,1,1)=mat2cell(x,[size(x,1)],[size(x,2)],[size(x,3)]);
    
    x=idwt3(WT_level1(kk));       
    R1(:,:,k:k+depth_1d-1)=x;                
end



%%
R1=uint8(R1);
psnr(R1(:,:,142),R(:,:,142))



