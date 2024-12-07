
 img=imread('stego.png');

img1=flip(img,2);

%------------>> converting to HSI plain from RGB

red_channel = img1(:, :, 1);
green_channel = img1(:, :, 2);
blue_channel = img1(:, :, 3);
rand_val=round((double(red_channel)./255)*128);

tmp=mod(green_channel,2);
msg_bits=tmp(1:16);
msg_bits=num2str(msg_bits);

msg_size=bin2dec(msg_bits);
msg_size

%--------------->> dividing i plain into 4 equal sub images
[r,c]=size(blue_channel);
hr=r/2;

Is_1=blue_channel(1:hr,1:hr);
Is_2=blue_channel(1:hr,hr+1:hr+hr);
Is_3=blue_channel(hr+1:hr+hr,1:hr);
Is_4=blue_channel(hr+1:hr+hr,hr+1:hr+hr);
 
 [si_1 ,si_2 ,si_3, si_4]=shuffling(Is_1, Is_2, Is_3, Is_4,hr);
 
bits=zeros(1,msg_size*8);

pix=1;
 for i=1:8:msg_size*8
     
   bits(i) = mod(si_1(pix),2);
   bits(i+1) = mod(si_1(pix+1),2);
   
   bits(i+2) = mod(si_2(pix),2);
   bits(i+3) = mod(si_2(pix+1),2);
   
   bits(i+4) = mod(si_3(pix),2);
   bits(i+5) = mod(si_3(pix+1),2);
   
   bits(i+6) = mod(si_4(pix),2);
   bits(i+7) = mod(si_4(pix+1),2);
   pix=pix+2;  
     
 end
 
 bits=decryption(bits);
 
char_val=bits2decimal( bits,rand_val);
plain_text=char(char_val)
  
  