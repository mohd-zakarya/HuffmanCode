function [ x1,x2,x3,x4 ] = re_rotation(key , i1 ,i2 , i3 ,i4 )
 x1=0;
 x2=0;
 x3=0;
 x4=0;
 
    b='first';
        for i=1:4
            z=double(key(i));
            
            
            switch b
                
                
                case 'fourth'
                    
                if mod(z,2)==0
                x4 = rot90(i4,3);
                else
                x4 = rot90(i4,2);
                end
                
                   
                case 'third'
                if mod(z,2)==0
                x3 = rot90(i3,3);
                else
                x3 = rot90(i3,2);
                end
                b='fourth';    
                
                
                
                case 'second'
                if mod(z,2)==0
                x2 = rot90(i2,3);
                else
                x2 = rot90(i2,2); 
                end
                b='third';    

                case 'first'
                if mod(z,2)==0
                x1 = rot90(i1,3);
                else
                x1 = rot90(i1,2);
                end
                b='second';    
                

            end
        end
% figure,imshow(x1)
% figure,imshow(x2)
% figure,imshow(x3)
% figure,imshow(x4)
end



