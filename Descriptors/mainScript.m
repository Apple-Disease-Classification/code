

% Esempio di calcolo delle feature per una singola immagine
addpath(genpath('featuresComputation'));
addpath(genpath('HAR'));

descriptor = 'LBP18'; % 'HAR', o 'LBP18'
color = 'gray';
graylevel = 256;
prepro = 'none';

 %features = featureExtraction(img, descriptor, color, graylevel, prepro);

%Esempio di calcolo features per piu' immagini:
% %img = datastore(....) o funzioni simili
 data = imageDatastore("C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train\*","FileExtensions",[".jpg",".tif"],'LabelSource','foldernames');

features =[];  
for i = 1:size(data.Files,1)
 
     image = imread(data.Files{i,1})
   feature = featureExtraction(image, descriptor, color, graylevel, prepro);
   features = [features feature];

  end
save features
