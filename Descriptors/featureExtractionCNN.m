imds = imageDatastore('C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train','IncludeSubfolders',true,'LabelSource','foldernames');
[imdsTV, imdsTest] = splitEachLabel(imds,0.8,0.2);
YTrain = imdsTV.Labels;
YTest = imdsTest.Labels;

% Augmented datastore to handle resized input for AlexNet
audsTV = augmentedImageDatastore([227 227], imdsTV);
audsTest = augmentedImageDatastore([227 227], imdsTest);

alexnet_fc = 'fc7'; % AlexNet's layer name from which perform the feature extraction

% Training set extraction
featuresAlexTV = activations(alexnet, audsTV, alexnet_fc, 'MiniBatchSize', 32);
featuresAlexTV = squeeze(featuresAlexTV);
featuresAlexTV = featuresAlexTV';

% Test set extraction
featuresAlexTest = activations(alexnet, audsTest, alexnet_fc, 'MiniBatchSize', 32);
featuresAlexTest = squeeze(featuresAlexTest);
featuresAlexTest = featuresAlexTest';

%%
classifier = fitcecoc(featuresAlexTV,YTrain)

%%
YPred = predict(classifier,featuresAlexTest);

%%
idx = [20 25 30 35];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    I = readimage(imdsTest,idx(i));
    label = YPred(idx(i));
    imshow(I)
    title(char(label))
end






