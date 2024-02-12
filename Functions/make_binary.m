function [ bin, thresh] = make_binary(cropped_img)

% make_binary binarizes the cropped grain image and remove dust and small particles 
gray = im2double(rgb2gray(cropped_img));
% makes a grayscale image and then change format to double precision
thresh = graythresh(gray);
% calculates treshold to binarize
bin = gray > thresh;
% binarize grayscale image
bin = imcomplement(bin);
% flip 0 <-> 1
% Get a mask of the blue channel
%bin = cropped_img(:,:,3) < 173;
% Get rid of junk near edge of image.
%bin = imclearborder(bin);
%bin_clean = (bwareafilt(bin, [2000, 45000]));
%bin_clean = imclearborder(bin_clean);


end

