function [mb1, mb2, mb3, mb4, rotation_key ] = data_encryption()

%------------>> initialization of variables
m=[];
j=8;
bb1=[];
bb2=[];
bb3=[];
bb4=[];

%------------>> selecting of plain text
sec_msg=fileread(uigetfile('*.m;*.txt;','Select message file'));
[msg_r ,msg_c]=size(sec_msg);

%------------>> generating of random key
[ alpha_key ,key] = key_gen(msg_c);
 key_bits=key;
 ch=char(alpha_key);

 
rotation_key=alpha_key(1:4);


%-------------->> converting of msg to bits
for i=1:msg_c
    
    ch_m=sec_msg(i);
    d_m=double(ch_m);
    t_m=dec2bin(d_m,8);
    m=strcat(m,t_m);
end  

[mr,mc]=size(m);
msg_bits=zeros(1,mc);

for i=1:mc
    
   msg_bits(i)=uint8(str2double(m(i))); 

end    


%------------->>step no.3 of MLEA
q=1;
r=2;
for i=1:8:mc

    temp=msg_bits(i:i+7);
    b1=[temp(8),temp(1)];
    bb1(1,q:r)=b1;
    
    b2=[temp(7),temp(2)];
    bb2(1,q:r)=b2;
    
    b3=[temp(6),temp(3)];
    bb3(1,q:r)=b3;
    
    b4=[temp(5),temp(4)];
    bb4(1,q:r)=b4;
    
   q=q+2;
   r=r+2;
end

%------------->>step no.4 of MLEA
[br,bc]=size(bb1);
b1_xor=bitxor(bb1,1);
b2_xor=bitxor(bb2,1);
b3_xor=bitxor(bb3,1);
b4_xor=bitxor(bb4,1);
key_xor=bitxor(key_bits,1);


%-------------->> step 5 of MLEA
for i=1:8:bc
    b=b1_xor(i:i+7);
    for x=1:4
     tep= b1_xor(x);
     b1_xor(x)=b(j);
     b1_xor(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b2_xor(i:i+7);
    for x=1:4
     tep= b2_xor(x);
     b2_xor(x)=b(j);
     b2_xor(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b3_xor(i:i+7);
    for x=1:4
     tep= b3_xor(x);
     b3_xor(x)=b(j);
     b3_xor(j)=tep;
     j=j-1;
    end  
    j=8;
end 

for i=1:8:bc
    b=b4_xor(i:i+7);
    for x=1:4
     tep= b4_xor(x);
     b4_xor(x)=b(j);
     b4_xor(j)=tep;
     j=j-1;
    end  
    j=8;
end 
z=0;
for i=1:8:mc
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


%----------> step 7 of MLEA

for i=1:bc
       if key_xor(i)== 1
          b1_xor(i) = bitxor(b1_xor(i),1);
       end
end

for i=1:bc
       if key_xor(i)== 1
          b2_xor(i) = bitxor(b2_xor(i),1);
       end
end

for i=1:bc
      if key_xor(i)== 1
         b3_xor(i) = bitxor(b3_xor(i),1);
      end
end

for i=1:bc
      if key_xor(i)== 1
         b4_xor(i) = bitxor(b4_xor(i),1);
      end
end
mb1=b1_xor;
mb2=b2_xor;
mb3=b3_xor;
mb4=b4_xor;
end

