clc;
clear all;
%close all;

%Read Input Retina Image
inImg = imread('01_test.bmp');
dim = ndims(inImg);
if(dim == 3)
    Input is a color image
    inImg = rgb2gray(inImg);
end

% red = inImg(:,:,1); % Red channel
% green = inImg(:,:,2); % Green channel
% blue = inImg(:,:,3); % Blue channel
% inImg = ;

%Extract Blood Vessels
Threshold = 10;
bloodVessels = VesselExtract(inImg, Threshold);

%Output Blood Vessels image

figure;
subplot(121);imshow(inImg);title('Input Image');
subplot(122);imshow(bloodVessels);title('Extracted Blood Vessels');