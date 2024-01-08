clc;clear all;close all;
v=VideoReader('enc_video.avi');
number_frames=v.NumberOfFrames;

for i=1:number_frames
    b=read(v,i);
    imwrite(b,['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\frames_dec\' strcat('frame',int2str(i),'.png')]);
end
key=2265479;
c='';

exit=0;
temp1=1;
temp2=1;

for f=1:number_frames
    enc_img=imread(['C:\Users\sahil\Desktop\sahil\Stegno_project\Video_enc\2bits\frames_dec\' strcat('frame',int2str(f),'.png')]);
    red_enc=enc_img(:,:,1);
    green_enc=enc_img(:,:,2);
    blue_enc=enc_img(:,:,3);
    [m,n]=size(red_enc);
    a=[red_enc green_enc blue_enc];
    n1=1;n2=n;
    x=1;
    for k=1:3
        img=a(1:m,n1:n2);
        for i=1:m
            for j=1:n
                if (temp2)<=key
                    imbin=dec2bin(img(i,j));
                    while length(imbin)<8
                        imbin=strcat('0',imbin);
                    end
                    cbin(temp1,x)=imbin(7);
                    x=x+1;
                    cbin(temp1,x)=imbin(8);
                    x=x+1;
                    if(x>8)
                        c=strcat(c,char(bin2dec(cbin(temp1,1:8))));
                        temp1=temp1+1;
                        temp2=temp2+1;
                        x=1;
                    end
                else
                    exit=1;
                    break;
                end
            end
            if (exit==1)
                break;
            end
        end
        if (exit==1)
            break;
        else
            n1=n1+n;
            n2=n2+n;
        end
    end
    if(exit==1)
        break;
    end
end

fid2=fopen('dec_test.txt','w');
for i=1:length(c)
    fprintf(fid2,c(i));
end
fclose(fid2);