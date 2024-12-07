function out=charbits2uint8bits(charbitsarray)
h=uint8(zeros(1,length(charbitsarray)));
for x=1:length(charbitsarray)
    h(x)=uint8(str2double(charbitsarray(x)));
end
out=h;