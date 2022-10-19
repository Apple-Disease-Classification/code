clc
clear all
close all
warning off all
%%%%%%%%%%%%%%%%%%%%%%%%%%  Random_Forest_LBP18   %%%%%%%%%%%%%%%%
%  load features_LBP18.mat
%  label=data.Labels;
%  C = cellstr(label)
%  X = features_LBP18';
%  Y = C;
%  Random_Forest_LBP18 = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_LBP18 Random_Forest_LBP18
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_hist  %%%%%%%%%%%%%%%%%
%  load features_hist.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_hist';
%  Y = C;
%  Random_Forest_hist = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_hist Random_Forest_hist


%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_cgram  %%%%%%%%%%%%%%%%%

%  load features_cgram.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_cgram';
%  Y = C;
%   Random_Forest_cgram = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_cgram Random_Forest_cgram

%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_haar  %%%%%%%%%%%%%%%%%

%  load features_haar.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_haar';
%  Y = C;
%  Random_Forest_haar = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_haar Random_Forest_haar

%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_HAR  %%%%%%%%%%%%%%%%%

%  load features_HAR.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_HAR';
%  Y = C;
%  Random_Forest_HAR = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_HAR Random_Forest_HAR
 
%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_histMask  %%%%%%%%%%%%%%%%%

%  load features_histMask.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_histMask';
%  Y = C;
%  Random_Forest_histMask = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_histMask Random_Forest_histMask

%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_gabor  %%%%%%%%%%%%%%%%%
%  load features_gabor.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_gabor';
%  Y = C;
% Random_Forest_gabor = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_gabor Random_Forest_gabor

%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_CM  %%%%%%%%%%%%%%%%%

%  load features_CM.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_CM';
%  Y = C;
%  Random_Forest_CM = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_CM Random_Forest_CM

%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_HARri  %%%%%%%%%%%%%%%%%
% 
%  load features_HARri.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_HARri';
%  Y = C;
%  Random_Forest_HARri = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_HARri Random_Forest_HARri

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_GLCM13 %%%%%%%%%%%%%%%%%%%%%%%

% 
%  load features_GLCM13.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_GLCM13';
%  Y = C;
%   Random_Forest_GLCM13 = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_GLCM13 Random_Forest_GLCM13


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Random_Forest_HM %%%%%%%%%%%%%%%%%%%%%%%

%  load features_HM.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_HM';
%  Y = C;
%  Random_Forest_HM = TreeBagger(60,X,Y,'OOBPred','On','Method','classification')
%  save Random_Forest_HM Random_Forest_HM