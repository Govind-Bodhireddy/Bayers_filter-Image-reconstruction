raw_image=imread('bayer-filter-2.jpg');
[m,n]=size(raw_image);
R=zeros(m,n);
G=R;
B=R;
for i=2:m-1
    for j=2:n-1
        if (mod(i,2)~=0 & mod(j,2)~=0)
            R(i,j)=raw_image(i,j);
        elseif(mod(i,2)==0 & mod(j,2)==0)
            B(i,j)=raw_image(i,j);
        else
            G(i,j)=raw_image(i,j);
        end
    end
end
for j=1:n
    if (mod(j,2)~=0)
        R(1,j)=raw_image(1,j);
        G(m,j)=raw_image(m,j);
    else
        G(1,j)=raw_image(1,j);
        B(m,j)=raw_image(m,j);
    end
end
for i=2:m-1
    if (mod(i,2)==0)
        G(i,1)=raw_image(i,1);
        B(i,n)=raw_image(i,m);
    else
        R(i,1)=raw_image(i,1);
        G(i,m)=raw_image(i,m);
    end
end
%interpolation
for i=2:m-1
    for j=2:n-1
        if (mod(i,2)==0 & mod(j,2)==0)
            R(i,j)=(R(i-1,j-1)+R(i-1,j+1)+R(i+1,j-1)+R(i+1,j+1))/4;
            G(i,j)=G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)/4;
        elseif(mod(i,2)~=0 & mod(j,2)~=0)
            G(i,j)=G(i,j-1)+G(i,j+1)+G(i-1,j)+G(i+1,j)/4;
            B(i,j)=(B(i-1,j-1)+B(i-1,j+1)+B(i+1,j-1)+B(i+1,j+1))/4;
        else
            R(i,j)=R(i-1,j)+R(i+1,j)/2;
            B(i,j)=B(i,j-1)+B(i,j+1)/2;
        end
    end
end
for j=2:n-1
    if (mod(j,2)~=0)
        G(1,j)=(G(1,j-1)+G(1,j+1)+G(2,j))/3;
        B(1,j)=(B(2,j-1)+B(2,j-1))/2;
        R(m,j)=(R(m-1,j-1)+R(m-1,j+1))/2;
        G(m,j)=(G(m,j-1)+G(m,j+1)+G(m-1,j))/3;
    else
        R(1,j)=(R(1,j-1)+R(1,j+1))/2;
        B(1,j)=B(2,j);
        R(m,j)=R(m-1,j);
        B(m,j)=(B(m,j-1)+B(m-1,j)+B(m,j+1))/3;
    end
end
for i=2:m-1
    if (mod(i,2)==0)
        B(i,1)=B(i,2);
        R(i,1)=(R(i-1,1)+R(i+1,1))/2;
        R(i,n)=(R(i-1,n-1)+R(i-1,n-1))/2;
        G(i,n)=(G(i-1,n)+G(i+1,n)+G(i,n-1))/3;
    else
        B(i,n)=(B(i-1,n)+B(i+1,n))/2;
        R(i,n)=R(i,n-1);
        G(i,1)=(G(i-1,1)+G(i+1,1)+G(i,2))/3;
        B(i,1)=(B(i-1,2)+B(i+1,2))/2;
    end
end
%edge Pixels
B(1,1)=B(2,2);
G(1,1)=(G(1,2)+G(2,1))/2;
B(1,n)=B(2,n);
R(1,n)=R(1,n-1);
R(m,1)=R(m-1,1);
B(m,1)=B(m,2);
G(m,n)=(G(m-1,n)+G(m,n-1))/2;
R(m,n)=R(m-1,n-1);
I=cat(3,R,G,B);
imshowpair(raw_image,uint8(I),'montage');