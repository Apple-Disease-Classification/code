clc
clear all
close all
warning off all

imds = imageDatastore('C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train','IncludeSubfolders',true,'LabelSource','foldernames');
[imdsTV, imdsTest] = splitEachLabel(imds,0.8,0.2);

% Augmented datastore to handle resized input for AlexNet
audsTV = augmentedImageDatastore([227 227], imdsTV);
audsTest = augmentedImageDatastore([227 227], imdsTest);

fc = 'fc1000' %% resnet101's layer name from which perform the feature extraction

% Training set extraction
featuresresnet101 = activations(resnet101, audsTV, fc, 'MiniBatchSize', 32);
featuresresnet101 = squeeze(featuresresnet101);
featuresresnet101 = featuresresnet101';

% Test set extraction
featuresresnet101Test = activations(resnet101, audsTest, fc, 'MiniBatchSize', 32);
featuresresnet101Test = squeeze(featuresresnet101Test);
featuresresnet101Test = featuresresnet101Test';

load features_LBP18.mat;

F1=featuresresnet101;
F2=features_LBP18';

%combinazioni tra le feature handcrafted con le features deep(LBP18 + resnet101 ) 
[i1,j1] = ndgrid(1:size(F1,1),1:size(F1,2));
[i2,j2] = ndgrid(1:size(F2,1),(1:size(F2,2))+size(F1,2));
FeatureCombin = accumarray([i1(:),j1(:);i2(:),j2(:)],[F1(:);F2(:)]);

%label Data Train
label=data.Labels;

classifierSVM = fitcecoc(FeatureCombin,label) %support vector machine (SVM) models, classifierSVM is a ClassificationECOC model.
classifierEnsemble = fitcensemble(FeatureCombin,label) %returns the trained classification ensemble model object classifierEnsemble

%import feature extraction of LBP18
load features_LBP18_test.mat;
 
T1=featuresresnet101Test;
T2=features_LBP18_test';

%combinazioni test feature
[i11,j11] = ndgrid(1:size(T1,1),1:size(T1,2));
[i22,j22] = ndgrid(1:size(T2,1),(1:size(T2,2))+size(T1,2));
FeatureCombinTest = accumarray([i11(:),j11(:);i22(:),j22(:)],[T1(:);T2(:)]);

%returns a vector of predicted class labels for the predictor data
YPredSVM = predict(classifierSVM,FeatureCombinTest)
YPredEnsemble = predict(classifierEnsemble,FeatureCombinTest)
%interesse 
%
YPredSVMcell=cellstr(YPredSVM);
YPredEnsemblecell=cellstr(YPredEnsemble);
train_lab = imageDatastore("C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Test\*","FileExtensions",[".jpg",".tif"],'LabelSource','foldernames');
   label=train_lab.Labels;
   Cl = cellstr(label)

[confusion,order] = confusionmat(Cl,YPredEnsemblecell,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})


[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,7)

%Accuracy = 1
%Precision =2
%Recall = 7
%Specificity =11
%F-score =16
%MCC=18
%Balanced Accuracy=19
%
cvp = cvpartition(label,'holdout',80)

	Xtrain = features_GLCM13(cvp.training,:);
	ytrain = label(cvp.training,:);
	Xtest  = features_GLCM13(cvp.test,:);
	ytest  = label(cvp.test,:);


nca = fscnca(Xtrain,ytrain,'FitMethod','none');

L = loss(nca,Xtest,ytest)

cvp = cvpartition(ytrain,'kfold',5);
numvalidsets = cvp.NumTestSets;

n = length(ytrain);
lambdavals = linspace(0,20,20)/n;
lossvals = zeros(length(lambdavals),numvalidsets);


for i = 1:length(lambdavals)
    for k = 1:numvalidsets
        X = Xtrain(cvp.training(k),:);
        y = ytrain(cvp.training(k),:);
        Xvalid = Xtrain(cvp.test(k),:);
        yvalid = ytrain(cvp.test(k),:);

        nca = fscnca(X,y,'FitMethod','exact', ...
             'Solver','sgd','Lambda',lambdavals(i), ...
             'IterationLimit',30,'GradientTolerance',1e-4, ...
             'Standardize',true);
                  
        lossvals(i,k) = loss(nca,Xvalid,yvalid,'LossFunction','classiferror');
    end
end


meanloss = mean(lossvals,2)/10;


figure()
plot(lambdavals,meanloss,'ro-')
xlabel('Lambda')
ylabel('Loss (MSE)')
grid on


[~,idx] = min(meanloss) 

bestlambda = lambdavals(idx)

bestloss = meanloss(idx)

nca = fscnca(Xtrain,ytrain,'FitMethod','exact','Solver','sgd','Lambda',bestlambda,'Standardize',true,'Verbose',1);


figure()
plot(nca.FeatureWeights,'ro')
xlabel('Feature index')
ylabel('Feature weight')
grid on
