clc;clear all;close all;

vid=VideoReader('enc_video.avi');
number_frames=vid.NumberOfFrames;
dec_frames=struct;


for i=1:number_frames
    b=read(vid,i);
    dec_frames.(strcat('Frame_',int2str(i)))=b;
end

key=2265479;
c='';

exit=0;
temp=1;

count=0;

for f=1:number_frames
    count=count+1;
    enc_img=dec_frames.(strcat('Frame_',int2str(f)));
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
                if (temp)<=key
                    imbin=dec2bin(img(i,j));
                    while length(imbin)<8
                        imbin=strcat('0',imbin);
                    end
                    cbin(temp,x:x+1)=imbin(7:8);
                    x=x+2;
                    if(x>=8)
                        c=strcat(c,char(bin2dec(cbin(temp,1:8))));
                        temp=temp+1;
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

disp(count);

fid2=fopen('dec_test.txt','w');
for i=1:length(c)
    fprintf(fid2,c(i));
end
fclose(fid2);