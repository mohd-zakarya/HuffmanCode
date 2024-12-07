function [mse,psnr]=PSNR(coverimage,stegoimage)
% coverimage=imread(coverimage);% Original Cover
% stegoimage=imread(stegoimage); % Stego Image
[cm,cn,cp]=size(coverimage);
if cp==3
    coverimage=rgb2gray(coverimage);
end
[sm,sn,sp]=size(stegoimage);
if sp==3
    stegoimage=rgb2gray(stegoimage);
end
[m n]=size(stegoimage);
[m1 n1]=size(coverimage);
total=[];

for x=1:m
    for y=1:m1
        t=double(power((coverimage(x,y)-stegoimage(x,y)),2));
%         t1=t*t;
        total=[total t];
    end
end
total=sum(total);
a=double(max(max(coverimage)));
b=double(max(max(stegoimage)));
d=double(max(a,b));
d=d*d;
mse=total/(m*m1);
psnr=10*(log10(double(d/mse)));
 
% warndlg(sprintf('PSNR=%f  db',psnr),'Hussain Ali'); 