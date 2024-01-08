clear;
clc;
fid=fopen('enc_audio.mp3','r');
org_audio=fread(fid,[1 inf],'*uint8');
fclose(fid);
bin_sample=dec2bin(org_audio,8);
exit=0;
key=40;
count=1;
p=1;
text='';
for i=1:size(bin_sample,1)
    if(count<=key)
        c(count,p:p+1)=bin_sample(i,7:8);
        p=p+2;
        if(p>8)
            p=1;
            text(count)=char(bin2dec(c(count,1:8)));
            count=count+1;
        end
    else
        exit=1;
    end
    if(exit==1)
        break;
    end
end
display(text);

        