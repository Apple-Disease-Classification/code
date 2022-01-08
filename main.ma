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
Rosso = image(:,:,1);
Verde = image(:,:,2);
Blu = image(:,:,3);

figure('name','Risultato Input Image');
subplot(221);imshow(Im,[]);title('Input Image');
subplot(222);imshow(Rosso,[]);title('Canale rossa');
subplot(223);imshow(Verde,[]);title('Canale verde');
subplot(224);imshow(Blu,[]);title('Canale blu');

[L, a, b] = RGBtoLab(Rosso, Verde, Blu);

figure('name','Risultato color space  da RGB a LAB');
subplot(131);imshow(L,[]);title('Risultato L color space');
subplot(132);imshow(a,[]);title('Risultato a color space');
subplot(133);imshow(b,[]);title('Risultato b color space');

labb = cat(3,L,a,b);

% Create color transformation structure that defines an sRGB to L*a*b* conversion.
cform = makecform('srgb2lab');

% Perform the transformation by using the applycform function  
% to converts the color values in  Image (Im) to the color space specified in the color 
% transformation structure srgb2lab (cform) 

lab = applycform(Im,cform); 


figure('name','Risultato Input Image & L*a*b Color space');
subplot(121);imshow(Im,[]);title('Input RGB image');
subplot(122);imshow(lab);title('Risultato L*a*b color space');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);


%% K-Means Clustering segmentation

 cl = 5;
 [ABC,co] = KMeans_Clustering(ll,cl);
 [d,e]=size(co);
 for i=1:d
     for j=1:e
         if co(i,j)==3
             mat(i,j)=0;
         else
             mat(i,j)=co(i,j);
         end
     end
 end
 
 [m1,s5] = size(mat);
 for i = 1:m1
     for j = 1:s5
         if mat(i,j) == 0
             new_mat(i,j,1:3) = Im(i,j,1:3);
         else
             new_mat(i,j,1:3) = 0;
         end
     end
 end
 
figure('name','Risultato K-Means'),
subplot(121);imshow(mat,[]);title('Risultato K-means');
subplot(122);imshow(uint8(new_mat),[]);title('Risultato K-means on input image');

%% feature extraction = global color histogram(GCH), Color Coherence Vector (CCV)and Local Binary Pattern(LBP).

%% GCH :
 
 figure('name','Risultato color histogram');
 subplot(131);imhist(Rosso);title('histogram rosso');
 subplot(132);imhist(Verde);title('histogram verde');
 subplot(133);imhist(Blu);title('histogram blu');
   
%% CCV :

%The Function Color_Coherence_Vector take an image and return the Vector that describe this Image.
 ccv = Color_Coherence_Vector(image); 

c = mean(ccv)
% returns the mean of the number of coherent/incoherent pixels colored
c = mean(ccv)
data = c;
s1 = data;
save s1 s1


%% LBP :

%the LBP code is computed from  every pixel of the image to represent the texture of the image

a = ll;
 [m,n] = size(a);
 for i = 2:m-1
     for j = 2:n-1
         b = a(i-1:i+1,j-1:j+1);
         B(i-1:i+1,j-1:j+1) = Local_Binary_Pattern(b); %the function Restituisce un invariante di rotazione Local Binary Pattern (uniform patterns) per ogni pixel
     end
 end
 figure,imshow(B);
 title('Local Binary Patterns');

 localBP = mean(mean(B))
 data = localBP;
 s3 = data;
 save s3 s3
