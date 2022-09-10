
clc
clear all
close all
warning off all
% Esempio di calcolo delle feature per una singola immagine
addpath(genpath('featuresComputation'));
addpath(genpath('HAR'));
%img = imread('../img.png');
% img = imread('C:\Users\amesj\Desktop\Tesi\apple_disease_classification\Train\Blotch_Apple\B (107).jpg');

descriptor = 'LBP18'; % 'HAR', o 'LBP18'
color = 'gray';
graylevel = 256;
prepro = 'none';

 %features = featureExtraction(img, descriptor, color, graylevel, prepro);

%Esempio di calcolo features per piu' immagini:
% %img = datastore(....) o funzioni simili
 data = imageDatastore("C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train\*","FileExtensions",[".jpg",".tif"],'LabelSource','foldernames');
% %img=data.Files
% %size[x,y]=size(img)
% W=size(img,1)
% image = imread(data.Files{10,1})
% features = featureExtraction(image, descriptor, color, graylevel, prepro);
features =[];  
for i = 1:size(data.Files,1)
  %  feature=zeros(36,396)
%     % matrix_fear=zeros(36,396)
     image = imread(data.Files{i,1})
   feature = featureExtraction(image, descriptor, color, graylevel, prepro);
   features = [features feature];

%    %matrix_fear(:,2)=feature(:,2)
  end
save features