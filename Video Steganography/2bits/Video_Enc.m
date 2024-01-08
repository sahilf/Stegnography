clc;clear all;close all;

vid=VideoReader('TestVideo.mp4');
number_frames=vid.NumberOfFrames;

for i=1:number_frames
    b=read(vid,i);
    imwrite(b,['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\frames\' strcat('frame',int2str(i),'.png')]);
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
    org_img=imread(['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\frames\' strcat('frame',int2str(f),'.png')]);
    red=org_img(:,:,1);
    green=org_img(:,:,2);
    blue=org_img(:,:,3);

    %Encryption of the image
    %fid=fopen('novel.txt','r');
    %t=fscanf(fid,'%c');
    %fclose(fid);
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
    imwrite(enc_img,['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\enc_frames\' strcat('enc_img',int2str(f),'.png')]);
end

video = VideoWriter('enc_video','Uncompressed AVI'); %create the video object
video.FrameRate=24;
open(video); %open the file for writing
for i=1:number_frames %where N is the number of images
  I = imread(['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\enc_frames\' strcat('enc_img',int2str(i),'.png')]); 
  writeVideo(video,I); %write the image to file
end
close(video); %close the file


