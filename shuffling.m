function [ is1,is2,is3,is4 ] = shuffling( Ic_1, Ic_2 ,Ic_3, Ic_4,hr )

[Ir,Ic]=size(Ic_1);
sz=Ir*Ic;
magic_mat=magic(hr);

 new=uint8(zeros(hr,hr));
for i=1:sz
  new(i)=Ic_1(magic_mat(i));
end
is1=new;

for i=1:sz
   new(i)=Ic_2(magic_mat(i));
end
is2=new;

for i=1:sz
new(i)=Ic_3(magic_mat(i));
end
is3=new;

for i=1:sz
new(i)=Ic_4(magic_mat(i));
end
is4=new;

end

