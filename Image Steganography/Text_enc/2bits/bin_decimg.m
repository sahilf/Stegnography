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
temp1=1;
temp2=1;
key=32678;
exit=0;
c='';
p=1;
for k=1:3
    img=a(1:m,n1:n2);
    for i=1:m
        for j=1:n
            if temp2<=key
                imbin=dec2bin(img(i,j),8);
                cbin(temp1,x)=imbin(7);
                x=x+1;
                cbin(temp1,x)=imbin(8);
                x=x+1;
                if(x>8)
                    c(p)=char(bin2dec(cbin(temp1,1:8)));
                    p=p+1;
                    temp1=temp1+1;
                    x=1;
                    temp2=temp2+1;
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
%disp(c);
fid2=fopen('dec.txt','w');
for i=1:length(c)
    fprintf(fid2,c(i));
end
fclose(fid2);

