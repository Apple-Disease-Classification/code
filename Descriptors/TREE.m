clc
clear all
close all
warning off all
%%%%%%%%%%%%%%%%%%%%%%%%%%  TREE_LBP18   %%%%%%%%%%%%%%%%
%  load features_LBP18.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_LBP18';
%  Y = C;
%  TREE_LBP18 = fitctree(X,Y,'CrossVal','on');
%  save TREE_LBP18 TREE_LBP18

 
%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_hist  %%%%%%%%%%%%%%%%%
%  load features_hist.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_hist';
%  Y = C;
%  TREE_hist = fitctree(X,Y,'CrossVal','on');
%  save TREE_hist TREE_hist


%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_cgram  %%%%%%%%%%%%%%%%%

%  load features_cgram.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_cgram';
%  Y = C;
%  TREE_cgram = fitctree(X,Y,'CrossVal','on');
%  save TREE_cgram TREE_cgram

%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_haar  %%%%%%%%%%%%%%%%%

%  load features_haar.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_haar';
%  Y = C;
%  TREE_haar = fitctree(X,Y,'CrossVal','on');
%  save TREE_haar TREE_haar

%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_HAR  %%%%%%%%%%%%%%%%%
% 
%  load features_HAR.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_HAR';
%  Y = C;
%  TREE_HAR = fitctree(X,Y,'CrossVal','on');
%  save TREE_HAR TREE_HAR
 
%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_histMask  %%%%%%%%%%%%%%%%%

%  load features_histMask.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_histMask';
%  Y = C;
%  TREE_histMask = fitctree(X,Y,'CrossVal','on')
%  save TREE_histMask TREE_histMask

%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_gabor  %%%%%%%%%%%%%%%%%
%  load features_gabor.mat
%  label=data.Labels;
%  C = cellstr(label)
%  X = features_gabor';
%  Y = C;
%  TREE_gabor = fitctree(X,Y,'CrossVal','on')
%  save TREE_gabor TREE_gabor

%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_CM  %%%%%%%%%%%%%%%%%

%  load features_CM.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_CM';
%  Y = C;
%  TREE_CM = fitctree(X,Y,'CrossVal','on')
%  save TREE_CM TREE_CM

%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_HARri  %%%%%%%%%%%%%%%%%
% 
%  load features_HARri.mat
%  label=data.Labels;
%  C = cellstr(label)
%  X = features_HARri';
%  Y = C;
%  TREE_HARri = fitctree(X,Y,'CrossVal','on')
%  save TREE_HARri TREE_HARri

%%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_GLCM13 %%%%%%%%%%%%%%%%%%%%%%%

% 
%  load features_GLCM13.mat
%  label=data.Labels;
%  C = cellstr(label)
%  X = features_GLCM13';
%  Y = C;
%  TREE_GLCM13 = fitctree(X,Y,'CrossVal','on')
%  save TREE_GLCM13 TREE_GLCM13


%%%%%%%%%%%%%%%%%%%%%%%%%%%% TREE_HM %%%%%%%%%%%%%%%%%%%%%%%

%  load features_HM.mat
%  label=data.Labels;
%  C = cellstr(label)
%   X = features_HM';
%  Y = C;
%  TREE_HM = fitctree(X,Y,'CrossVal','on')
%  save TREE_HM TREE_HM