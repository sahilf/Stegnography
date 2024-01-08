clear;
clc;
% [Y Fs]=audioread('Test2.wav');
% samples = Y*65535;
% sample_abs = abs(samples);
% scalar_matrix = samples./sample_abs;
% x=dec2bin(sample_abs');
% [m n]=size(scalar_matrix);
% temp=1;
% for i=1:m
%     for j=1:n
%         if(scalar_matrix(i,j)==-1)
%             bin_sample(temp,1:16)=strcat('1',x(temp,1:15));
%         else
%             bin_sample(temp,1:16)=strcat('0',x(temp,1:15));
%         end
%         temp=temp+1;
%     end
% end

fid=fopen('test2.wav','r');
org_audio=fread(fid,[1 inf],'*uint8');
fclose(fid);
bin_sample=dec2bin(org_audio,8);
%%

org_img=imread('abd.png');
red=org_img(:,:,1);
green=org_img(:,:,2);
blue=org_img(:,:,3);
a=[red green blue];
[m,n]=size(red);
x=1;y=n;
exit=0;

len=size(bin_sample,1);
p=1;
count=1;
for k=1:3
    temp=a(1:m,x:y);
    for i=1:m
        for j=1:n
            if(count<=len)
                b=dec2bin(temp(i,j),8);
                if(b(1:4)=='1')
                    if(p+3<=8)
                        b(5:8)=bin_sample(count,p:p+3);
                        p=p+4;
                    else
                        b(5:6)=bin_sample(count,p:p+1);
                        count=count+1;p=1;
                        b(7:8)=bin_sample(count,p:p+1);
                        p=p+2;
                    end
                else
                    b(7:8)=bin_sample(count,p:p+1);
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
    x=x+n;
    y=y+n;
    if(exit==1)
        break;
    end
end

enc_img=cat(3,a(1:m,1:n),a(1:m,n+1:2*n),a(1:m,2*n+1:3*n));
imshow(enc_img);
imwrite(enc_img,'enc_im_in_img.png');



            
