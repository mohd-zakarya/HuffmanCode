function [ msg] = decryption( k,b1,b2,b3,b4 )

%------------->> converting key to bits & passing from MLEA STEP 4 AND 5.
[kr,kc]=size(k);
key=[];
j=8;
for i=1:kc 
    ch_k=k(i);
    d_k=double(ch_k);
    b_k=dec2bin(d_k,8);
    key=horzcat(key,b_k);
end  

key_bits=zeros(1,kc*8);
for i=1:kc*8
    
   key_bits(i)=uint8(str2double(key(i))); 

end   

[kb_r,kb_c]=size(key_bits);
bc=(kb_c/4);

 

key_xor=bitxor(key_bits,1);


z=0;
for i=1:8:bc
    b=key_xor(i:i+7);
    
    for x=1:4
     tep= key_xor(x+z);
     key_xor(x+z)=b(j);
     key_xor(j+z)=tep;
     j=j-1;
    end  
    z=z+8;
    j=8;
end 

%------------>>  step NO.7 of MLEA 
for i=1:bc
       if key_xor(i)== 1
           tmp=b1(i);
          b1(i) = bitxor(tmp,1);
       end
end

for i=1:bc
       if key_xor(i)== 1
           tmp=b2(i);
          b2(i) = bitxor(tmp,1);
       end
end

for i=1:bc
      if key_xor(i)== 1
          tmp=b3(i);
         b3(i) = bitxor(tmp,1);
      end
end

for i=1:bc
      if key_xor(i)== 1
          tmp=b4(i);
         b4(i) = bitxor(tmp,1);
      end
end

%------------------>> step NO.5 of MLEA 

for i=1:8:bc
    b=b1(i:i+7);
    for x=1:4
     tep= b1(x);
     b1(x)=b(j);
     b1(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b2(i:i+7);
    for x=1:4
     tep= b2(x);
     b2(x)=b(j);
     b2(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b3(i:i+7);
    for x=1:4
     tep= b3(x);
     b3(x)=b(j);
     b3(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b4(i:i+7);
    for x=1:4
     tep= b4(x);
     b4(x)=b(j);
     b4(j)=tep;
     j=j-1;
    end  
    j=8;
end 


%-------------->>  step NO.4 of MLEA 
b1_xor=bitxor(b1,1);
b2_xor=bitxor(b2,1);
b3_xor=bitxor(b3,1);
b4_xor=bitxor(b4,1);

%-------------->>   reverse of step NO.7 of MLEA  to get plain text in
%-------------->>   orignal sequance
combin=zeros(1,kb_c);
x=1;
for i=1:8:kb_c
     combin(i+7)=b1_xor(x);
     combin(i)=b1_xor(x+1);
     x=x+2;
end

x=1;
for i=2:8:kb_c
     combin(i+5)=b2_xor(x);
     combin(i)=b2_xor(x+1);
     x=x+2;
end

x=1;
for i=3:8:kb_c
     combin(i+3)=b3_xor(x);
     combin(i)=b3_xor(x+1);
     x=x+2;
end

x=1;
for i=4:8:kb_c
     combin(i+1)=b4_xor(x);
     combin(i)=b4_xor(x+1);
     x=x+2;
end




msg=combin;

end

