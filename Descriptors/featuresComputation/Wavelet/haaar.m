function [v,w]=haaar(a, level)

a = imresize(a,[256, 256]);

%a=rgb2gray(a);
[y,x] = size(a); 

if nargin == 1
    l = 1;
else
    l = level;
end

f=1;
for p=1:l
[r,c]=size(a);
z=a;
    for i=1:1:r
        k=1;
        t=(r/2+1);
        for j=1:2:c
            avg=(a(i,j)+a(i,j+1))/2;
            dif=(a(i,j)-a(i,j+1))/2;
            z(i,k)=avg;
            z(i,t)=dif;
            k=k+1;
            t=t+1;
        end
    end
    a=z;
    for j=1:1:c
        t=(r/2+1);
        k=1;
        for i=1:2:r
            avg=(a(i,j)+a(i+1,j))/2;
            dif=(a(i,j)-a(i+1,j))/2;
            z(k,j)=avg;
            z(t,j)=dif;
            k=k+1;
            t=t+1;
        end
    end
    if p==1
        v=z;
    else
    v(1:y/(2^f),1:x/(2^f))=z;
    f=f+1;
    end
    a=z(1:y/(2^p),1:x/(2^p));
end
w=a;