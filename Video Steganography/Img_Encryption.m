clc;clear all;close all;

vid=VideoReader('TestVideo.mp4');
number_frames=vid.NumberOfFrames;
org_frames=struct;
enc_frames=struct;

for i=1:number_frames
    b=read(vid,i);
    org_frames.(strcat('Frame_',int2str(i)))=b;
end

org_img=org_frames.Frame_1;
red=org_img(:,:,1);
green=org_img(:,:,2);
blue=org_img(:,:,3);
a=[red green blue];
[m,n]=size(red);
x=1;y=n;

img=imread('msd.png');
red1=img(:,:,1);
green1=img(:,:,2);
blue1=img(:,:,3);
a1=[red1 green1 blue1];
[m1,n1]=size(red1);
x1=1;y1=n1;

p=1;
count=1;
for k=1:3
    temp=a(1:m,x:y);
    temp1=a1(1:m1,x1:y1);
    b1=dec2bin(temp1');
    len=size(b1,1);
    exit=0;
    while(size(b1,2)<8)
        b1=strcat('0',b1);
    end
    for i=1:m
        for j=1:n
            if(count<=len)
                b=dec2bin(temp(i,j));
                while(size(b,2)<8)
                b=strcat('0',b);
                end
                if(b(1:4)=='1')
                    if(p+3<=8)
                        b(5:8)=b1(count,p:p+3);
                        p=p+4;
                    else
                        b(5:6)=b1(count,p:p+1);
                        count=count+1;p=1;
                        b(7:8)=b1(count,p:p+1);
                        p=p+2;
                    end
                else
                    b(7:8)=b1(count,p:p+1);
                    p=p+2;
                end
                if(p>8)
                    count=count+1;
                    p=1;
                end
                temp(i,j)=bin2dec(b);
            else
                exit=1;
                break;
            end
        end
        if(exit==1)
            break;
        end
    end
    a(1:m,x:y)=temp;
    count=1;
    x=x+n;
    y=y+n;
    x1=x1+n1;
    y1=y1+n1;
end
    

enc_img=cat(3,a(1:m,1:n),a(1:m,n+1:2*n),a(1:m,2*n+1:3*n));
enc_frames.Frame_1=enc_img;
for i=2:number_frames
    enc_frames.(strcat('Frame_',int2str(i)))=org_frames.(strcat('Frame_',int2str(i)));
end

video_object = VideoWriter('enc video','Uncompressed AVI'); 
video_object.FrameRate=24;
open(video_object); 
for w=1:number_frames 
      I=enc_frames.(strcat('Frame_',int2str(w)));
      writeVideo(video_object,I); 
end
close(video_object); 

