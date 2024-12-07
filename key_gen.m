function [k, key ] = key_gen( size )

  t_size=size*8;
  key_bin=zeros();
  rand_no=(121-97)*rand(1,size)+97;

    for i=1:size
        k(i)=int8(rand_no(i));
    end
     
    
    
   
     key_bin=double(k);
     key_bin=dec2bin(key_bin,8);
     key_bin=key_bin';
     key_bin=double(key_bin);
     key_1D=reshape(key_bin,1,t_size);
    
     for bit=1:t_size
         key_1D(bit)=mod(key_1D(bit),2);
     end
     key=double(key_1D);
end

