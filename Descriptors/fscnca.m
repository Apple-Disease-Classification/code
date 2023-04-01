%%%%%%%%%%%%%%%%%%%%%%%%---------------GLCM13--------------%%%%%%%%%%%%%%%%%%%%%%%%

load features_GLCM13.mat

label=data.Labels;


cvp = cvpartition(label,'holdout',155)

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


tol    = 0.02;
selidx = find(nca.FeatureWeights > tol*max(1,max(nca.FeatureWeights)))

L = loss(nca,Xtest,ytest)

features = Xtrain(:,selidx);

knnMdl = fitcknn(features,ytrain,'NumNeighbors',5,'Standardize',1)

L = 1-loss(knnMdl,Xtest(:,selidx),ytest)


YPred = predict(knnMdl,features);


[confusion,order] = confusionmat(ytrain,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,11)


%%%%%%%%%%%%%%%%%%%%%%%%---------------CM--------------%%%%%%%%%%%%%%%%%%%%%%%%

load features_CM.mat
label=data.Labels;


cvp = cvpartition(label,'holdout',155)

	Xtrain = features_CM(cvp.training,:);
	ytrain = label(cvp.training,:);
	Xtest  = features_CM(cvp.test,:);
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


tol    = 0.02;
selidx = find(nca.FeatureWeights > tol*max(1,max(nca.FeatureWeights)))

L = loss(nca,Xtest,ytest)

features = Xtrain(:,selidx);

knnMdl = fitcknn(features,ytrain,'NumNeighbors',5,'Standardize',1)

L = 1-loss(knnMdl,Xtest(:,selidx),ytest)


YPred = predict(knnMdl,features);


[confusion,order] = confusionmat(ytrain,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,11)


%%%%%%%%%%%%%%%%%%%%%%%%---------------LBP18--------------%%%%%%%%%%%%%%%%%%%%%%%%

load features_LBP18.mat
label=data.Labels;
features_LBP18=features_LBP18'

cvp = cvpartition(label,'holdout',155)

	Xtrain = features_LBP18(cvp.training,:);
	ytrain = label(cvp.training,:);
	Xtest  = features_LBP18(cvp.test,:);
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


tol    = 0.02;
selidx = find(nca.FeatureWeights > tol*max(1,max(nca.FeatureWeights)))

L = loss(nca,Xtest,ytest)

features = Xtrain(:,selidx);

knnMdl = fitcknn(features,ytrain,'NumNeighbors',5,'Standardize',1)

L = 1-loss(knnMdl,Xtest(:,selidx),ytest)


 
YPred = predict(knnMdl,features);


[confusion,order] = confusionmat(ytrain,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,11)

%%%%%%%%%%%%%%%%%%%%%%%%---------------CM+resnet101--------------%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
warning off all

imds = imageDatastore('C:\Users\amesj\Desktop\Tesi\Mycode_test_update\DB_Train','IncludeSubfolders',true,'LabelSource','foldernames');



[imdsTV, imdsTest] = splitEachLabel(imds,0.8,0.2);

% Augmented datastore to handle resized input for AlexNet
%audsTV = augmentedImageDatastore([227 227], imdsTV);
audsTest = augmentedImageDatastore([227 227], imdsTest);

audsTV = augmentedImageDatastore([227 227], imds);

fc ='fc1000'; %'efficientnet-b0|model|head|dense|MatMul' %% resnet101's layer name from which perform the feature extraction

% Training set extraction
featuresresnet101 = activations(resnet101, audsTV, fc, 'MiniBatchSize', 32);
featuresresnet101 = squeeze(featuresresnet101);
featuresresnet101 = featuresresnet101';

% Test set extraction
featuresresnet101Test = activations(resnet101, audsTest, fc, 'MiniBatchSize', 32);
featuresresnet101Test = squeeze(featuresresnet101Test);
featuresresnet101Test = featuresresnet101Test';

load features_CM.mat;

F1=featuresresnet101';
F2=features_CM;

%combinazioni tra le feature handcrafted con le features deep(LBP18 + resnet101 ) 
[i1,j1] = ndgrid(1:size(F1,1),1:size(F1,2));
[i2,j2] = ndgrid(1:size(F2,1),(1:size(F2,2))+size(F1,2));
FeatureCombin = accumarray([i1(:),j1(:);i2(:),j2(:)],[F1(:);F2(:)]);
FeatureCombine = FeatureCombin'

%label Data Train
label1=data.Labels;
label2=imds.Labels;
label=[label1;label2]
labelC = cellstr(label)





cvp = cvpartition(label1,'holdout',155)

	Xtrain = features_CM(cvp.training,:);
	ytrain = label(cvp.training,:);
	Xtest  = features_CM(cvp.test,:);
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


tol    = 0.02;
selidx = find(nca.FeatureWeights > tol*max(1,max(nca.FeatureWeights)))

L = loss(nca,Xtest,ytest)

features = Xtrain(:,selidx);

knnMdl = fitcknn(features,ytrain,'NumNeighbors',5,'Standardize',1)

L = 1-loss(knnMdl,Xtest(:,selidx),ytest)


YPred = predict(knnMdl,features);


[confusion,order] = confusionmat(ytrain,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,11)



