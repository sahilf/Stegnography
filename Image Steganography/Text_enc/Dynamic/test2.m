%Decryption of the image
clc;clear;
enc_img=imread('enc_flower.png');
red_enc=enc_img(:,:,1);
green_enc=enc_img(:,:,2);
blue_enc=enc_img(:,:,3);
[m,n]=size(red_enc);
a=[red_enc,green_enc,blue_enc];
n1=1;n2=n;
x=1;
temp=1;
key=32678;
c='';
exit=0;
for k=1:3
    img=a(1:m,n1:n2);
    for i=1:m
        for j=1:n
            if temp<=key
                imbin=dec2bin(img(i,j),8);
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
% disp(c);
fid2=fopen('dec_test.txt','w');
for i=1:length(c)
    fprintf(fid2,c(i));
end
fclose(fid2);

