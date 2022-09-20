clc
clear all
close all
warning off all
%%%%%%%%%%%%%%%%%%%%%%%%%%  SVM_LBP18   %%%%%%%%%%%%%%%%
% load features_LBP18.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_LBP18';
% Y = C;
% SVM_LBP18 = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_LBP18 SVM_LBP18

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_hist  %%%%%%%%%%%%%%%%%
% load features_hist.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_hist';
% Y = C;
% SVM_hist = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_hist SVM_hist

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_cgram  %%%%%%%%%%%%%%%%%

% load features_cgram.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_cgram';
% Y = C;
% SVM_cgram = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_cgram SVM_cgram

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_haar  %%%%%%%%%%%%%%%%%

% load features_haar.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_haar';
% Y = C;
% SVM_haar = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_haar SVM_haar

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_HAR  %%%%%%%%%%%%%%%%%

% load features_HAR.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_HAR';
% Y = C;
% SVM_HAR = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_HAR SVM_HAR

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_histMask  %%%%%%%%%%%%%%%%%

% load features_histMask.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_histMask';
% Y = C;
% SVM_histMask = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_histMask SVM_histMask

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_gabor  %%%%%%%%%%%%%%%%%
% 
% load features_gabor.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_gabor';
% Y = C;
% SVM_gabor = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_gabor SVM_gabor

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_CM  %%%%%%%%%%%%%%%%%

% load features_CM.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_CM';
% Y = C;
% SVM_CM = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_CM SVM_CM

%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_HARri  %%%%%%%%%%%%%%%%%
% 
% load features_HARri.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_HARri';
% Y = C;
% SVM_HARri = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_HARri SVM_HARri
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_cgram %%%%%%%%%%%%%%%%%%%%%%%


% load features_cgram.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_cgram';
% Y = C;
% SVM_cgram = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_cgram SVM_cgram

%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_GLCM13 %%%%%%%%%%%%%%%%%%%%%%%


% load features_GLCM13.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_GLCM13';
% Y = C;
% SVM_GLCM13 = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_GLCM13 SVM_GLCM13


%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM_HM %%%%%%%%%%%%%%%%%%%%%%%

% 
% load features_HM.mat
% label=data.Labels;
% C = cellstr(label)
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% X = features_HM';
% Y = C;
% SVM_HM = fitcecoc(X,Y,'Learners',t,'FitPosterior',true,'ClassNames',{'Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'},'Verbose',2);
% save SVM_HM SVM_HM