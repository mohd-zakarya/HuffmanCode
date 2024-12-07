clear all;
clc;

  img=imread('peppers_256.png');
 
msg='Hussain Ali sdg ssdfgsdfg sdfgsdf gsdgsfsdfg sfgsfgsfgs sdgsgsfgsfgsg dfgg' ;%fileread(uigetfile('*.m;*.txt;','Select message file'));













[r,c]=size(msg);
img=flip(img,2);
img1=rgb2ycbcr(img);

%------------>> separating RGB plains

Yp = img1(:, :, 1);
cb_plain  =img1(:, :, 2);
cr_plain = img1(:, :, 3);

rand_val=round((double(cr_plain)./255)*128);

%----------->>embedding msg size into green channel
msg_size=length(msg);

size_bits=dec2bin(msg_size,16);
 size_bits=charbits2uint8bits(size_bits);

for i=1:16
    if mod(cb_plain(i),2)>size_bits(i)
           cb_plain(i)=cb_plain(i)-1;
        
            elseif mod(cb_plain(i),2)<size_bits(i)
           cb_plain(i)=cb_plain(i)+1;
    end
end



%--------------->> dividing i plain into 4 equal sub images
[r,c]=size(Yp);
hr=r/2;

b_1=Yp(1:hr,1:hr);
b_2=Yp(1:hr,hr+1:hr+hr);
b_3=Yp(hr+1:hr+hr,1:hr);
b_4=Yp(hr+1:hr+hr,hr+1:hr+hr);



%-------------->> shuffling by magic matrix
 [si_1 ,si_2 ,si_3, si_4]=shuffling(b_1, b_2, b_3, b_4,hr);



%------------->> calculating diffrence 
difference_bits=cal_dif(msg,rand_val);

%------------->>assigning bits for encryption
cipher_bits=encryption(difference_bits);

%------------->> cyclic embeding in sub images

pix=1;
for i=1:8:length(cipher_bits)
    
    
          
    if mod(si_1(pix),2)>cipher_bits(i)
           si_1(pix)=si_1(pix)-1;
        
            elseif mod(si_1(pix),2)<cipher_bits(i)
           si_1(pix)=si_1(pix)+1;
    end
    
    if mod(si_1(pix+1),2)>cipher_bits(i+1)
           si_1(pix+1)=si_1(pix+1)-1;
        
            elseif mod(si_1(pix+1),2)<cipher_bits(i+1)
           si_1(pix+1)=si_1(pix+1)+1;
    end

 %----------------------------------------------
 
     
          
    if mod(si_2(pix),2)>cipher_bits(i+2)
           si_2(pix)=si_2(pix)-1;
        
            elseif mod(si_2(pix),2)<cipher_bits(i+2)
           si_2(pix)=si_2(pix)+1;
    end
    
    if mod(si_2(pix+1),2)>cipher_bits(i+3)
           si_2(pix+1)=si_2(pix+1)-1;
        
            elseif mod(si_2(pix+1),2)<cipher_bits(i+3)
           si_2(pix+1)=si_2(pix+1)+1;
    end
    
    
    %----------------------------------------------
 
  
          
    if mod(si_3(pix),2)>cipher_bits(i+4)
           si_3(pix)=si_3(pix)-1;
        
            elseif mod(si_3(pix),2)<cipher_bits(i+4)
           si_3(pix)=si_3(pix)+1;
    end
    
    if mod(si_3(pix+1),2)>cipher_bits(i+5)
           si_3(pix+1)=si_3(pix+1)-1;
        
            elseif mod(si_3(pix+1),2)<cipher_bits(i+5)
           si_3(pix+1)=si_3(pix+1)+1;
    end
    
    
      %----------------------------------------------
 
  
          
    if mod(si_4(pix),2)>cipher_bits(i+6)
           si_4(pix)=si_4(pix)-1;
        
            elseif mod(si_4(pix),2)<cipher_bits(i+6)
           si_4(pix)=si_4(pix)+1;
    end
    
    if mod(si_4(pix+1),2)>cipher_bits(i+7)
           si_4(pix+1)=si_4(pix+1)-1;
        
            elseif mod(si_4(pix+1),2)<cipher_bits(i+7)
           si_4(pix+1)=si_4(pix+1)+1;
    end

    pix=pix+2;
  
    
    
end
    







[si_1 ,si_2 ,si_3, si_4]=shuffling(si_1 ,si_2 ,si_3, si_4,hr);



%------------->> combining of the sub_images

stego_inten = uint8([si_1,si_2;si_3,si_4]);

%-------------------->> re-construction of stego image from rgb channels
HSI_IMG=cat(3,Yp,cb_plain,cr_plain);
HSI_IMG1=ycbcr2rgb(HSI_IMG);
stego_img=flip(HSI_IMG1,2);
figure,imshow(stego_img);
imwrite(stego_img,'stego.png') ;
h = msgbox('Embedding completed.','Success');



 img=double(img);
stego_img=double(stego_img);
Pvalue=PSNR(img,stego_img); 

%ncc=NCC(img,stego_img)
%ssim_val=ssim(img,stego_img);
%ssim_val
Pvalue