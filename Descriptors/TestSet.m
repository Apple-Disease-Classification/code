clc
clear all
close all
warning off all
% Esempio di calcolo delle feature per una singola immagine
addpath(genpath('featuresComputation'));


descriptor = 'GLCM13'; %'HM', 'HAR', o 'LBP18','hist','cgram','haar','histMask','gabor','CM','HARri','GLCM13'
%'HM'
color = 'gray';
graylevel = 256;
prepro = 'none';

 %features = featureExtraction(img, descriptor, color, graylevel, prepro);

%Esempio di calcolo features per piu' immagini:
 data = imageDatastore("C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Test\*","FileExtensions",[".jpg",".tif"],'LabelSource','foldernames');

features_GLCM13_test =[];  
for i = 1:size(data.Files,1)
  %  feature=zeros(36,396)
   % matrix_fear=zeros(36,396)
     image = imread(data.Files{i,1})
   feature = featureExtraction(image, descriptor, color, graylevel, prepro);
   features_GLCM13_test = [features_GLCM13_test feature];

%    %matrix_fear(:,2)=feature(:,2)
  end
save features_GLCM13_test features_GLCM13_test data
