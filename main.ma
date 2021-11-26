clc;
clear all;
close all;
warning off all;

%% Read input image

[f,p] = uigetfile('*.jpg;*.bmp');
Im = imread([p f]);
Im = imresize(Im,[256 256]);

%% rgb to lab color space conversion

image = Im;
Red = image(:,:,1);
Green = image(:,:,2);
Blue = image(:,:,3);

figure('name','Input Image result');
subplot(221);imshow(Im,[]);title('Input Image');
subplot(222);imshow(Red,[]);title('Red band Image');
subplot(223);imshow(Green,[]);title('Green band Image');
subplot(224);imshow(Blue,[]);title('Blue band Image');

[L, a, b] = RGBtoLab(Red, Green, Blue);

figure('name','RGB to LAB color space result');
subplot(131);imshow(L,[]);title('Risultato L color space');
subplot(132);imshow(a,[]);title('Risultato a color space');
subplot(133);imshow(b,[]);title('Risultato b color space');
labb = cat(3,L,a,b);
cform = makecform('srgb2lab');
lab = applycform(Im,cform); 


figure('name','Risultato Input Image & L*a*b Color space');
subplot(121);imshow(Im,[]);title('Input RGB image');
subplot(122);imshow(lab);title('Risultato L*a*b color space');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);


%% K-Means segmentation

 cl = 5;
 [ABC,c] = KMeans_Clustering(ll,cl);
 [d,e]=size(c);
 for i=1:d
     for j=1:e
         if c(i,j)==3
             new(i,j)=0;
         else
             new(i,j)=c(i,j);
         end
     end
 end
 
 [m1,s5] = size(new);
 for i = 1:m1
     for j = 1:s5
         if new(i,j) == 0
             new1(i,j,1:3) = Im(i,j,1:3);
         else
             new1(i,j,1:3) = 0;
         end
     end
 end
figure('name','Risultato K-Means'),
subplot(121);imshow(new,[]);title('Risultato K-means');
subplot(122);imshow(uint8(new1),[]);title('Risultato K-means on input image');
