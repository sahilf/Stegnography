clc;clear all;
org_img=imread('enc_im_in_img.png');
red=org_img(:,:,1);
blue=org_img(:,:,3);
green=org_img(:,:,2);
a=[red green blue];
[m,n,o]=size(org_img);
key1=169;key2=299;
x=1;y=n;
x1=1;y1=1;
x2=1;y2=key2;
p=1;count=1;
for k=1:3
    exit=0;
    temp=a(1:m,x:y);%org img
    for i=1:m
        for j=1:n
            b=dec2bin(temp(i,j));
            while(size(b,2)<8)
                b=strcat('0',b);
            end
            b1(count,p:p+1)=b(7:8);
            p=p+2;
            if(p>8)
                 temp1(x1,y1)=bin2dec(b1(count,1:8));% new img
                 y1=y1+1;
                 if(y1>key2)
                       x1=x1+1;y1=1;
                       if(x1>key1)
                            exit=1;
                       end
                 end
                 count=count+1;
                 p=1;
            end
            if(exit==1)
               break;
            end
        end
        if(exit==1)
               break;
        end
    end
        a1(1:key1,x2:y2)=uint8(temp1);
        clear temp1;
        x=x+n;
        y=y+n;
        x1=1;y1=1;
        x2=x2+key2;y2=y2+key2;
end
          
dec_img=cat(3,a1(1:key1,1:key2),a1(1:key1,key2+1:2*key2),a1(1:key1,2*key2+1:3*key2));
imshow(dec_img);
imwrite(dec_img,'dec_im_in_img.jpg');

  

            
        
        
            
            
            
        
        
