clc;clear all;close all;

vid=VideoReader('TestVideo.mp4');
number_frames=vid.NumberOfFrames;
org_frames=struct;
enc_frames=struct;

for i=1:number_frames
    b=read(vid,i);
    org_frames.(strcat('Frame_',int2str(i)))=b;
end


fid=fopen('novel.txt','r');
t=fscanf(fid,'%c');
fclose(fid);
cbin=dec2bin(t);
[len,chr]=size(cbin);
while size(cbin,2)<8
    cbin=strcat('0',cbin);
end
if chr>8
    cbin=cbin(:,chr-8+1:chr);
end

exit=0;
temp=1;

for f=1:number_frames
    a=[];
    org_img=org_frames.(strcat('Frame_',int2str(f)));
    red=org_img(:,:,1);
    green=org_img(:,:,2);
    blue=org_img(:,:,3);

 
    [m,n]=size(red);
    x=1;
    a=[red, green, blue];
    n1=1;n2=n;
    for k=1:3
        img=a(1:m,n1:n2);
        for i=1:m
            for j=1:n
                if temp<=len
                    imbin=dec2bin(img(i,j));
                    while size(imbin,2)<8
                        imbin=strcat('0',imbin);
                    end
                    imbin(7)=cbin(temp,x);
                    x=x+1;
                    imbin(8)=cbin(temp,x);
                    x=x+1;
                    if(x>8)
                        temp=temp+1;
                        x=1;
                    end
                    img(i,j)=bin2dec(imbin);
                else
                    exit=1;
                    break;
                end
            end
            if (exit==1)
                break;
            end
        end
        a(1:m,n1:n2)=img;
        n1=n1+n;
        n2=n2+n;
        if (exit==1)
            break;
        end
    end
    enc_img=cat(3,a(1:m,1:n),a(1:m,n+1:2*n),a(1:m,2*n+1:3*n));
    enc_frames.(strcat('Frame_',int2str(f)))=enc_img;
end

disp(f)

if(f+1<=number_frames)
    for i=f+1:number_frames
        enc_frames.(strcat('Frame_',int2str(i)))=org_frames.(strcat('Frame_',int2str(i)));
    end
end

video = VideoWriter('enc_video','Uncompressed AVI'); %create the video object
video.FrameRate=24;
open(video); 
for w=1:number_frames 
  I=enc_frames.(strcat('Frame_',int2str(w))); 
  writeVideo(video,I); 
end
close(video); 


