function [ msgbits ] = cal_dif( msg, val )
[mr , mc]=size(msg);
[vr , vc]=size(val);
pix_val=reshape(val,1,vr*vc);
dif_bits=ones(1,mc*8);

j=1;

for i=1:mc 
    ch_val=int8(double(msg(i)))
    pv=int8(pix_val(i))
    v=pv-ch_val;
     k=dec2bin(typecast(int8(v),'uint8'),8);
     
     dif_bits(j:j+7)=charbits2uint8bits(k);
     j=j+8;
end
msgbits=dif_bits;
end

