function [F] = histFeaturesMasked(I, mask, normalization)
%Compute first order statistics that can be computed from the histogram%
%   Example
%       I = imread('liftingbody.png');
%       [F] = histFeatures(I)
if nargin == 2
    normalization = false;
end

if islogical(I)
    num_bins = 2;
else
    data_type = class(I);
    num_bins = double(intmax(data_type)) - double(intmin(data_type)) + 1;
end
[bin_counts, bin_values] = imhist(I, num_bins);
num = imhist(mask);
bin_counts(1)=bin_counts(1)-num(1);
total_pixels = sum(bin_counts);  %total pixel number
nhist =  bin_counts./total_pixels; %normalized histogram
mean_pixel = sum(nhist.*bin_values);
F(1) = mean_pixel; % Average gray level. 

v = sum( nhist .* (bin_values - mean_pixel).^ 2); %Variance
F(2) = sqrt(v); % Standard deviation. 
F(3) = 1 - 1/(1 + (v/(num_bins - 1)^2));  % Smoothness. 
F(4) = (sum((bin_values - mean_pixel) .^ 3 .* bin_counts) + eps) / (((total_pixels - 1) * F(2)^3)+eps); % Skewness 
F(5) = (sum((bin_values - mean_pixel) .^ 4 .* bin_counts) + eps) / (((total_pixels - 1) * F(2)^4)+eps); % Kurtosis
F(6) = sum(nhist.^2); % Uniformity. 
F(7) = -sum(nhist.*(log2(nhist + eps))); % Entropy. 

if normalization
    F(1) = F(1)/num_bins;
    F(2) = F(2)/num_bins;
    F(4) = (F(4)^2)/num_bins;
    F(5) = F(5)/num_bins;
    F(7) = F(7)/num_bins;
end