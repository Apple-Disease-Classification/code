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

svmMdl = fitcknn(features,ytrain,'NumNeighbors',5,'Standardize',1)

L = 1-loss(svmMdl,Xtest(:,selidx),ytest)


 
YPred = predict(svmMdl,features);


[confusion,order] = confusionmat(ytrain,YPred,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})

[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,1)
