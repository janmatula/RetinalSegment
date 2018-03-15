clc;
clear all;
close all;
figure(1)

inImg = im2double(imread('21_training.bmp'));
dim = ndims(inImg);

red = inImg(:,:,1).*0.3;
green = inImg(:,:,2).*0.59;
blue = inImg(:,:,3).*0.11;
inImg = red+ green + blue;
subplot(131)
imshow(inImg);

[sizex sizey] = size(inImg);


se = strel('disk',3);
openedImg = imopen(inImg, se);
subplot(132)
imshow(openedImg)
title('After opening')

se2 = strel('disk', 8)
closedImg = imclose(openedImg, se2);
subplot(133)
imshow(closedImg)
title('After closing')

figure(2)
novyImg = inImg - closedImg;
%novyImg = novyImg./max(max(novyImg));
subplot(121)
imshow(novyImg, [])

prah= -0.004;
novyImg(novyImg>prah)=0;
novyImg(novyImg<prah)=1;
subplot(122)
imshow(novyImg)

connected = bwconncomp(novyImg, 8);

numPixels = cellfun(@numel,connected.PixelIdxList);
biggest = 1000000;
while biggest>150
    [biggest,idx] = max(numPixels);
    numPixels(idx)=0;
    novyImg(connected.PixelIdxList{idx}) = 2;
end
novyImg(novyImg~=2)=0;

figure(3)
imshow(novyImg)

% figure(4)
% podvzor = novyImg(1:2:end, 1:2:end);
% imshow(podvzor);



% newRange = 0.2;  %// choose the new maximum. (new minimum always at 0.0)
% imgMin = double(min(novyImg(:)));
% imgMax = double(max(novyImg(:)));
% kontrast = (novyImg - imgMin) / (imgMax - imgMin) * newRange;
% 
% subplot(122)
% imshow(kontrast);
% 
% Threshold = 3;
% bloodVessels = VesselExtract(im2uint8(kontrast), Threshold);
% figure(3)
% imshow(bloodVessels);
