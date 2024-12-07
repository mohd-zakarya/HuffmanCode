function [ ans ] = NCC( c_img, s_img )
prod=c_img.*s_img;
n= sum(sum(prod));
sqr=(s_img.*s_img);
dn= sum(sum(sqr));
ans=n./dn;
end

