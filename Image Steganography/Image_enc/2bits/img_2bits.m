clc;clear;
org_img=imread('abd.png');
red=org_img(:,:,1);
blue=org_img(:,:,3);
green=org_img(:,:,2);
a=[red green blue];
[m,n]=size(red);

img=imread('msd.png');
red1=img(:,:,1);
blue1=img(:,:,3);
green1=img(:,:,2);
a1=[red1 green1 blue1];
[m1,n1]=size(red1);
%imshow(red);
% subplot(3,1,1);
% imshow(red);
% subplot(3,1,2);imshow(green);
% subplot(3,1,3);imshow(blue);
% im=cat(3,red,green,blue);
% imshow(im)
%q=length(c);
%disp(q);

%Encryption of the image

x=1;y=n;
x1=1;y1=n1;
p=1;
cout=1;
    for k=1:3
        temp=a(1:m,x:y);
        temp1=a1(1:m1,x1:y1);
        b1=dec2bin(temp1');
        len=size(b1,1);
        disp(cout);
        exit=0;
        while(size(b1,2)<8)
            b1=strcat('0',b1);
        end
        if(k==1)
            disp(a1(1,1:10));
            disp(bin2dec(b1(1:10,:)));
        end
        for i=1:m
            for j=1:n
                if(cout<=len)
                    b=dec2bin(temp(i,j));
                    while(size(b,2)<8)
                        b=strcat('0',b);
                    end
                    b(7:8)=b1(cout,p:p+1);
                    p=p+2;
                    if(p>8)
                        cout=cout+1;
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
%         disp(k);
%         disp(count);
        disp(cout);
        cout=1;
        x=x+n;
        y=y+n;
        x1=x1+n1;
        y1=y1+n1;
    end

enc_img=cat(3,a(1:m,1:n),a(1:m,n+1:2*n),a(1:m,2*n+1:3*n));
imshow(enc_img);
imwrite(enc_img,'enc_im_in_img.png');


        
