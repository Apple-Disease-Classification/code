clc
clear all
close all
warning off all

imds = imageDatastore('C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train','IncludeSubfolders',true,'LabelSource','foldernames');
[imdsTV, imdsTest] = splitEachLabel(imds,0.8,0.2);
% label=imds.Labels;
% Cl = cellstr(label)
YTrain = imdsTV.Labels;
YTest = imdsTest.Labels;

% Augmented datastore to handle resized input for AlexNet
% audsTV = augmentedImageDatastore([227 227], imdsTV);
% audsTest = augmentedImageDatastore([227 227], imdsTest);

% audsTV = augmentedImageDatastore([299 299], imdsTV);
% audsTest = augmentedImageDatastore([299 299], imdsTest);

audsTV = augmentedImageDatastore([331 331], imdsTV);
audsTest = augmentedImageDatastore([331 331], imdsTest);

% audsTV = augmentedImageDatastore(inputSize(1:2),imdsTV);
% audsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);

%net = googlenet;
%net = inceptionv3;
%net=densenet201;
%net = mobilenetv2;
%net = resnet18;
%net =resnet50;
%net=resnet101;
%net=xception;
%net=inceptionresnetv2;
%net=shufflenet;
%net=nasnetmobile;
%net=nasnetlarge;
net=efficientnetb0;

alexnet_fc ='efficientnet-b0|model|head|dense|MatMul' %'node_202'%'predictions'; %'Logits'%'fc1000';%'predictions'; %'loss3-classifier' %'fc7'; % AlexNet's layer name from which perform the feature extraction

% Training set extraction
featuresAlexTV = activations(net, audsTV, alexnet_fc,'MiniBatchSize', 32);
featuresAlexTV = squeeze(featuresAlexTV);
featuresAlexTV = featuresAlexTV';


% featuresTrain = activations(net,augimdsTrain,layer,OutputAs="rows");
% featuresTest = activations(net,augimdsTest,layer,OutputAs="rows");

% Test set extraction
featuresAlexTest = activations(net, audsTest, alexnet_fc, 'MiniBatchSize', 32);
featuresAlexTest = squeeze(featuresAlexTest);
featuresAlexTest = featuresAlexTest';

%%
classifier = fitcecoc(featuresAlexTV,YTrain)
%classifier =fitcknn(featuresAlexTV,YTrain)
%classifier = fitcensemble(featuresAlexTV,YTrain)
%classifier = fitctree(featuresAlexTV,YTrain)
%%
YPred = predict(classifier,featuresAlexTest);
[confusion,order] = confusionmat(YTest,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,1)
%Accuracy = 1
%Precision =2
%Recall = 7
%Specificity =11
%F-score =16
%MCC=18
%Balanced Accuracy=19
%%




% idx = [20 25 30 35];
% figure
% for i = 1:numel(idx)
%     subplot(2,2,i)
%     I = readimage(imdsTest,idx(i));
%     label = YPred(idx(i));
%     imshow(I)
%     title(char(label))
% end
% 





