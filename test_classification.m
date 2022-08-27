%% Read input image
 [f,p] = uigetfile('*.jpg;*.bmp');
 Im = imread([p f]);
 Im = imresize(Im,[256 256]);
%% rgb to lab color space conversion
image = Im;
Rosso = image(:,:,1);
Verde = image(:,:,2);
Blu = image(:,:,3);

[L, a, b] = RGBtoLab(Rosso, Verde, Blu);
labb = cat(3,L,a,b);

cform = makecform('srgb2lab');

lab = applycform(Im,cform); 

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);

%% K-Means segmentation

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
 
 %% CCV
  ccv = Color_Coherence_Vector(image); 
 
a = ll;
[m,n] = size(a); 
 for i = 2:m-1
     for j = 2:n-1
         b = a(i-1:i+1,j-1:j+1);
         B(i-1:i+1,j-1:j+1) = Local_Binary_Pattern(b);
     end
 end
 figure,imshow(B);
 title('Local Binary Patterns');
 
 localBP = mean(mean(B))
 data = localBP;

  load net1
  y = round(sim(net1,data)) %Run the neural network "net1" on data "data"
  if y == 0
      msgbox('Apple Normal','Result');
  elseif y == 1
      msgbox('Apple Blotch','Result');
  elseif y == 2
      msgbox('Apple Rot','Result');
  elseif y == 3
      msgbox('Apple Scab','Result');
  else 
       msgbox('Error', 'Result');
  end

