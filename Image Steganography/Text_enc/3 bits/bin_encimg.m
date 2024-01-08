clc;clear;
org_img=imread('flower.png');
red=org_img(:,:,1);
green=org_img(:,:,2);
blue=org_img(:,:,3);


exit=0;

%Encryption of the image
fid=fopen('novel_new.txt','r');
t=fscanf(fid,'%c');
fclose(fid);

cbin=dec2bin(t,9);
len=size(cbin,1);
[m,n]=size(red);
x=1;
temp=1;
a=[red, green, blue];
n1=1;n2=n;
for k=1:3
    img=a(1:m,n1:n2);
    for i=1:m
        for j=1:n
            if temp<=len
                imbin=dec2bin(img(i,j),8);
                imbin(6)=cbin(temp,x);
                x=x+1;
                imbin(7)=cbin(temp,x);
                x=x+1;
                imbin(8)=cbin(temp,x);
                x=x+1;
                if(x>9)
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
b=isequal(org_img,enc_img);
disp(b);
imshow(enc_img);
imwrite(enc_img,'enc_flower.png');


                

            
        
        
            
            
            
        
        
