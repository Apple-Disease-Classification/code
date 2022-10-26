Risults of descriptor HM with classification Random Forest

load features_HM_test.mat
load Random_Forest_HM.mat  
data_test =features_HM_test'
grouphat = predict(Random_Forest_HM,data_test);
[confusion,order] = confusionmat(Cl,grouphat,'Order',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'})
save confusion_Random_Forest_HM confusion
[microAVG, macroAVG, wAVG, stats] = computeMetrics(confusion,19)

%Accuracy = 1
%Precision =2
%Recall = 7
%Specificity =11
%F-score =16
%MCC=18
%Balanced Accuracy=19
