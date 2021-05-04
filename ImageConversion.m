%% This File is a experimental script used to mess around with designing functions
%
% By Kristtiya Guerra
%% Importing and Converting image
Img = imread('Duck.jpg'); %Reads image
info = imfinfo('Duck.PNG'); %Obtains information about image

Img_gray = rgb2gray(Img);

%Converting image to binary grayscale (0s and 1s w/o shaders)
threshold = 120; %Adjust based on image
Img_gray_bin = Img_gray > threshold;

figure(1)
a = subplot(1,3,1);
hold on
imshow(Img)
b = subplot(1,3,2);
imshow(Img_gray)
c = subplot(1,3,3);
imshow(Img_gray_bin)
hold off

%%

Red = Img(:,:,1);
Green = Img(:,:,2);
Blue = Img(:,:,3);
figure(2);



Red_Array = RGB4Thresh(Red);
Green_Array = RGB4Thresh(Green);
Blue_Array = RGB4Thresh(Blue);

Img(:,:,1) = Red_Array;
Img(:,:,2) = Green_Array;
Img(:,:,3) = Blue_Array;
imshow(Img)
%% QPSK Data Image Conversion
% 1
% -1
% 1i
% -1i

%Brainstorm: Using RGB triplets such that the binary is used to determine
%state of number. Since we cannot store imaginary numbers.
% [Magnitude  Value Imaginary]
% 1    = [0 1 0] green
% -1   = [1 1 0] yellow
% 1i   = [0 1 1] cyan
% -1i  = [1 1 1] white

%Run through each pixels's rgb and determine how close it is to threshold
%Obtain RGB values



ax1 = subplot(2,2,1);
imshow(Img)
ax2 = subplot(2,2,2);
imshow(Red)
ax3 = subplot(2,2,3);
imshow(Green)
ax4 = subplot(2,2,4);
imshow(Blue)

threshold = 100; %Adjust based on image
Red_bin = Red > threshold;
threshold = 100; %Adjust based on image
Green_bin = Green > threshold;
threshold = 100; %Adjust based on image
Blue_bin = Blue > threshold;

Img(:,:,1) = Red_bin;
Img(:,:,2) = Green_bin;
Img(:,:,3) = Blue_bin;
%Plot RGB values
figure(3);
hold on
ax1 = subplot(1,4,1);
imshow(Red_bin)
title('Red Binary Array');
ax2 = subplot(1,4,2);
imshow(Green_bin)
title('Green Binary Array');
ax3 = subplot(1,4,3);
imshow(Blue_bin)
title('Blue Binary Array');
ax4 = subplot(1,4,4);
imshow(Img*256)
hold off

%%
% Red_bin(Red_bin==0)=50;
% Red_bin(Red_bin==1)=100;
% 
% Green_bin(Green_bin==0)=50;
% Green_bin(Green_bin==1)=100;
% 
% Blue_bin(Blue_bin==0)=50;
% Blue_bin(Blue_bin==1)=100;


% figure
% imshow(Img_QPSK)


%%
Img(:,:,1) = Red_bin;
Img(:,:,2) = Green_bin;
Img(:,:,3) = Blue_bin;

figure;
imshow(Img*256)
title('full');
%% Test  Function
X = ImgtoBinary('Duck.jpg',.45);
row_n = height(X);
column_n = width(X);
Data = row_n * column_n;
Y = X';
Y = Y(:)';
%% Defining Functions

function y = Img2Array(Binary_image)
    A = Binary_image';
    Y = A(:)';
end
function y = ThresholdBin(Percentage,GrayImg)
    maxGray = max(GrayImg(:));
    minGray = min(GrayImg(:));
    y = minGray + (Percentage)*(maxGray - minGray); %Adjust based on image
end
function bin = ImgtoBinary(imgname,perc_thresh)
    Img = imread(imgname); %Reads image
    Img_gray = rgb2gray(Img);
    thresh = ThresholdBin(perc_thresh,Img_gray);
    bin = Img_gray > thresh;
    figure;
    imshow(bin)
end
