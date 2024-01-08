clc;clear all;close all;
vid=VideoReader('encrpted video.avi');
number_frames=vid.NumberOfFrames;
dec_frames=struct;
for i=1:number_frames
    b=read(vid,i);
    dec_frames.(strcat('Frame_',int2str(i)))=b;
end
c='';
key=2265479;

exit=0;
temp=1;

for f=1:number_frames
    a=[];
    enc_img=dec_frames.(strcat('Frame_',int2str(f)));
    red=enc_img(:,:,1);
    green=enc_img(:,:,2);
    blue=enc_img(:,:,3);
    [m,n]=size(red);
    a=[red green blue];
    x=1;
    n1=1;n2=n;
    for k=1:3
        img=a(1:m,n1:n2);
        for i=1:m
            for j=1:n
                if temp<=key
                    imbin=dec2bin(img(i,j));
                    while size(imbin,2)<8
                        imbin=strcat('0',imbin);
                    end
                    if(imbin(1:4)=='1')
                        if(x+3 <=8)
                            cbin(temp,x:x+3)=imbin(5:8);
                            x=x+4;
                        else
                            cbin(temp,x:x+1)=imbin(5:6);
                            c(temp)=char(bin2dec(cbin(temp,1:8)));
                            temp=temp+1;x=1;
                            cbin(temp,x:x+1)=imbin(7:8);
                            x=x+2;
                        end
                    else
                        cbin(temp,x:x+1)=imbin(7:8);
                        x=x+2;
                    end
                    if(x>=8)
                        c(temp)=char(bin2dec(cbin(temp,1:8)));
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
        n1=n1+n;
        n2=n2+n;
        if (exit==1)
            break;
        end
    end
    if (exit==1)
        break;
    end
end
%disp(c);
fid2=fopen('dec_test.txt','w');
for i=1:length(c)
    fprintf(fid2,c(i));
end
fclose(fid2);