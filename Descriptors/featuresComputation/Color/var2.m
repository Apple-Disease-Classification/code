function v = var2(I)
%VAR2 Variance of matrix elements.
%   Example
%       I = imread('liftingbody.png');
%       val = var2(I)
%
%   See also CORR2, MEAN2, MEAN, STD.

% validate that our input is valid for the IMHIST optimization
fast_data_type = isa(I,'logical') || isa(I,'int8') || isa(I,'uint8') || ...
    isa(I,'uint16') || isa(I,'int16');

% only use IMHIST for images of sufficient size
big_enough = numel(I) > 300000;

if fast_data_type && isequal(ndims(I),2) && ~issparse(I) && big_enough
    
    % compute histogram
    if islogical(I)
        num_bins = 2;
    else
        data_type = class(I);
        num_bins = double(intmax(data_type)) - double(intmin(data_type)) + 1;
    end
    [bin_counts, bin_values] = imhist(I, num_bins);
    total_pixels = numel(I);
    nhist =  bin_counts./total_pixels; %normalized histogram
    mean_pixel = sum(nhist.*bin_values); % Average gray level. 
    v = sum( nhist .* (bin_values - mean_pixel).^ 2); %Variance    
else
    % use simple implementation
    if ~isa(I,'double')
        I = double(I);
    end
    v = var(I(:));
end