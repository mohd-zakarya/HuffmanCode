function [ cipher ] = encryption( bits )


%---------->> taking xor
bits_xor=bitxor(bits,1);



for i=1:8:length(bits_xor)

   block=bits_xor(i:i+7);
   b1=block(1:4);
   bits_xor(i:i+3)=bits_xor(i+4:i+7);
   bits_xor(i+4:i+7)=b1;

end

%------------>> circular shift

for i=1:8:length(bits_xor)

   block=bits_xor(i:i+7);
   b1=block(1:7);
   b2=block(8);
  
   bits_xor(i)=b2;
   bits_xor(i+1:i+7)=b1;
   
end

%----------->> xor based on half bits

half=length(bits)/2;

b1=bits_xor(1:half);
b2=bits_xor(half+1:length(bits));

for i=1:half
    if b1(i)==1
        b2(i)=bitxor(b2(i),1);
    end
end


cipher=bits_xor;

end

