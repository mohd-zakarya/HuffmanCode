function org_msg =bits2str(bits)

n=1;

[r ,c]=size(bits);
c_no=c/8;
s2='';
s4=[];
s6=[];
for k=1:c_no
 
    for x=1:8
        
    b=bits(n);
    s6=horzcat(s6,b);
    
    n=n+1;
  
    
    end
    s2=num2str(s6);
    s6=[];
dec_num(k)= bin2dec(s2);
   
end
    org_msg =dec_num ;

