function [ t_img ] = transposition( img )

red_Ch = img(:, :, 1);
green_Ch = img(:, :, 2);
blue_Ch = img(:, :, 3);

t_r=red_Ch';
t_g=green_Ch'; 
t_b=blue_Ch';

 t_img=cat(3,t_r,t_g,t_b);



end

