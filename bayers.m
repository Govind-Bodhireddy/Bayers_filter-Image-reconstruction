I=imread('peppers.png');
[R,G,B]=imsplit(I);
[m,n]=size(R);
Bayers_Image=zeros(size(R));
[i,j]=meshgrid(1:m,1:n);
idx_R= mod(i,2)~=0 & mod(j,2)~=0;
Bayers_Image(idx_R)=R(idx_R);
idx_B=mod(i,2)==0 & mod(j,2)==0;
Bayers_Image(idx_B)=B(idx_B);
idx_G=~(idx_R | idx_B);
Bayers_Image(idx_G)=G(idx_G);
Bayers_Image=uint8(Bayers_Image);
imwrite(Bayers_Image,'raw_image.jpeg');
imshowpair(I,Bayers_Image,'montage');

