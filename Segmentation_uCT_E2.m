close all
clear all
clc

ExpImage_t1=imread('E2_0900.tif');
ExpImage_t2=imread('E2_1000.tif');
ExpImage_t3=imread('E2_1100.tif');

size1 = size(ExpImage_t1);
size2 = size(ExpImage_t2);
size3 = size(ExpImage_t3);

% [xmin ymin width height]
CroppedArea1 = [800 1100 200 200]; % For C
CroppedArea2 = [850 1000 200 200]; % For C
CroppedArea3 = [900 850 200 200]; % For C
%------------
figure (11)
imshow(ExpImage_t1)
h1 = drawrectangle('Position',CroppedArea1,'StripeColor','r');
ExpImage_crop1 = imcrop(ExpImage_t1,CroppedArea1);

figure (21)
imshow(ExpImage_t2)
h2 = drawrectangle('Position',CroppedArea2,'StripeColor','r');
ExpImage_crop2 = imcrop(ExpImage_t2,CroppedArea2);

figure (31)
imshow(ExpImage_t3)
h3 = drawrectangle('Position',CroppedArea3,'StripeColor','r');
ExpImage_crop3 = imcrop(ExpImage_t3,CroppedArea3);
%------------
figure (12)
imshow(ExpImage_crop1)

figure (22)
imshow(ExpImage_crop2)

figure (32)
imshow(ExpImage_crop3)
%------------
figure (13)
imhist(ExpImage_crop1)
xlim([0, max(ExpImage_crop1(:))]);

figure (23)
imhist(ExpImage_crop2)
xlim([0, max(ExpImage_crop2(:))]);

figure (33)
imhist(ExpImage_crop3)
xlim([0, max(ExpImage_crop3(:))]);
%------------
minGrayLevel1 = min(ExpImage_crop1(:));
maxGrayLevel1 = max(ExpImage_crop1(:));
minGrayLevel2 = min(ExpImage_crop2(:));
maxGrayLevel2 = max(ExpImage_crop2(:));
minGrayLevel3 = min(ExpImage_crop3(:));
maxGrayLevel3 = max(ExpImage_crop3(:));

threshold1 = 10800; % For C
threshold2 = 10600; % For C
threshold3 = 10600; % For C

image_thresholded1 = ExpImage_crop1;
image_thresholded1(image_thresholded1<=threshold1) = 0;
image_thresholded1(image_thresholded1>threshold1) = 10000;

image_thresholded2 = ExpImage_crop2;
image_thresholded2(image_thresholded2<=threshold2) = 0;
image_thresholded2(image_thresholded2>threshold2) = 10000;

image_thresholded3 = ExpImage_crop3;
image_thresholded3(image_thresholded3<=threshold3) = 0;
image_thresholded3(image_thresholded3>threshold3) = 10000;
%------------
figure (14)
imshow(image_thresholded1)

figure (24)
imshow(image_thresholded2)

figure (34)
imshow(image_thresholded3)
%------------
figure (15)
imhist(image_thresholded1)
xlim([0, max(image_thresholded1(:))]);

figure (25)
imhist(image_thresholded2)
xlim([0, max(image_thresholded2(:))]);

figure (35)
imhist(image_thresholded3)
xlim([0, max(image_thresholded3(:))]);
%------------
targetPixelValue_Low = 0;
targetPixelValue_High = 10000;

count_Low1 = sum(image_thresholded1(:) == targetPixelValue_Low);
count_High1 = sum(image_thresholded1(:) == targetPixelValue_High);
count_Low2 = sum(image_thresholded2(:) == targetPixelValue_Low);
count_High2 = sum(image_thresholded2(:) == targetPixelValue_High);
count_Low3 = sum(image_thresholded3(:) == targetPixelValue_Low);
count_High3 = sum(image_thresholded3(:) == targetPixelValue_High);

packing1 = count_High1 / (count_Low1 + count_High1);
packing2 = count_High2 / (count_Low2 + count_High2);
packing3 = count_High3 / (count_Low3 + count_High3);

packing_matrix = [packing1 packing2 packing3];
packing_mean = mean(packing_matrix)
packing_std = std(packing_matrix)
