clc;clear;
fid=fopen('test2.wav','r');
org_audio=fread(fid,[1 inf],'*uint8');
fclose(fid);
bin_sample=dec2bin(org_audio,8);
 
%%
bin_sample(1:10,:)

fid=fopen('test.txt','r');
t=fscanf(fid,'%c');
fclose(fid);

c=dec2bin(t,8);
len=size(c,1);
count=1;
p=1;
exit=0;
for i=1:size(bin_sample,1)
    if(count<=len)
        bin_sample(i,7:8)=c(count,p:p+1);
        p=p+2;
        if(p>8)
            p=1;
            count=count+1;
        end
    else
        exit=1;
    end
    if(exit==1)
        break;
    end
end

bin_sample(1:10,:)

for i=1:size(bin_sample,1)
    enc_aud(1,i)=uint8(bin2dec(bin_sample(i,1:8)));
end
fid2=fopen('enc_audio.mp3','w');
fwrite(fid2,enc_aud);
fclose(fid2);
    
            
        


