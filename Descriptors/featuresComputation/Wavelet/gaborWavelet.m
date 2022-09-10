function features = gaborWavelet(img)

img = imresize(img,[250 250]);
gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
features = gaborFeatures(im2double(img),gaborArray,128,128)';

%--------------------------------------------------------------------------

function featureVector = gaborFeatures(img,gaborArray,d1,d2)
% GABORFEATURES extracts the Gabor features of an input image.
% It creates a column vector, consisting of the Gabor features of the input
% image. The feature vectors are normalized to zero mean and unit variance.
%
% Inputs:
%       img         :	Matrix of the input image 
%       gaborArray	:	Gabor filters bank created by the function gaborFilterBank
%       d1          :	The factor of downsampling along rows.
%       d2          :	The factor of downsampling along columns.
%               
% Output:
%       featureVector	:   A column vector with length (m*n*u*v)/(d1*d2). 
%                           This vector is the Gabor feature vector of an 
%                           m by n image. u is the number of scales and
%                           v is the number of orientations in 'gaborArray'.
%
% Sample use:
% 
% img = imread('cameraman.tif');
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
% featureVector = gaborFeatures(img,gaborArray,4,4);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.
% 
if (nargin ~= 4), error('Please use the correct number of input arguments!'), end
if size(img,3) == 3, img = double(rgb2gray(img)); end

% Filter the image using the Gabor filter bank
% Filter input image by each Gabor filter
[u,v] = size(gaborArray);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = imfilter(img, gaborArray{i,j});
    end
end

% Create feature vector
% Extract feature vector from input image
featureVector = [];
for i = 1:u
    for j = 1:v
        gaborAbs = abs(gaborResult{i,j});
        gaborAbs = downsample(gaborAbs,d1);
        gaborAbs = downsample(gaborAbs.',d2);
        gaborAbs = gaborAbs(:);
        
        % Normalized to zero mean and unit variance. (if not applicable, please comment this line)
        gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
        
        featureVector =  [featureVector; gaborAbs];
    end
end

% Show filtered images (Please comment this section if not needed!)
% Show real parts of Gabor-filtered images
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(real(gaborResult{i,j}),[]);
%     end
% end
% 
% % Show magnitudes of Gabor-filtered images
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(abs(gaborResult{i,j}),[]);
%     end
% end

%-------------------------------------------------------------------------

function gaborArray = gaborFilterBank(u,v,m,n)
% GABORFILTERBANK generates a custum Gabor filter bank.
% It creates a u by v cell array, whose elements are m by n matrices; 
% each matrix being a 2-D Gabor filter.
% 
% Inputs:
%       u	:	No. of scales (usually set to 5) 
%       v	:	No. of orientations (usually set to 8)
%       m	:	No. of rows in a 2-D Gabor filter (an odd integer number, usually set to 39)
%       n	:	No. of columns in a 2-D Gabor filter (an odd integer number, usually set to 39)
% 
% Output:
%       gaborArray: A u by v array, element of which are m by n 
%                   matries; each matrix being a 2-D Gabor filter   
% 
% Sample use:
% 
% gaborArray = gaborFilterBank(5,8,39,39);

if (nargin ~= 4)    % Check correct number of arguments
    error('There must be four input arguments (Number of scales and orientations and the 2-D size of the filter)!')
end

% Create Gabor filters
% Create u*v gabor filters each being an m by n matrix

gaborArray = cell(u,v);
fmax = 0.25;
gama = sqrt(2);
eta = sqrt(2);

for i = 1:u
    
    fu = fmax/((sqrt(2))^(i-1));
    alpha = fu/gama;
    beta = fu/eta;
    
    for j = 1:v
        tetav = ((j-1)/v)*pi;
        gFilter = zeros(m,n);
        
        for x = 1:m
            for y = 1:n
                xprime = (x-((m+1)/2))*cos(tetav)+(y-((n+1)/2))*sin(tetav);
                yprime = -(x-((m+1)/2))*sin(tetav)+(y-((n+1)/2))*cos(tetav);
                gFilter(x,y) = (fu^2/(pi*gama*eta))*exp(-((alpha^2)*(xprime^2)+(beta^2)*(yprime^2)))*exp(1i*2*pi*fu*xprime);
            end
        end
        gaborArray{i,j} = gFilter;
        
    end
end

% Show Gabor filters (Please comment this section if not needed!)
% Show magnitudes of Gabor filters:
%figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
%for i = 1:u
%    for j = 1:v
%        subplot(u,v,(i-1)*v+j);
%        imshow(abs(gaborArray{i,j}),[]);
%    end
%end
%
% Show real parts of Gabor filters:
%figure('NumberTitle','Off','Name','Real parts of Gabor filters');
%for i = 1:u
%    for j = 1:v
%        subplot(u,v,(i-1)*v+j);
%        imshow(real(gaborArray{i,j}),[]);
%    end
%end