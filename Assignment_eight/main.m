% Applying DWT and IDWT on image
close all;
clc;
%% read Inputs

% read the image
I = imread('image.png');
I = rgb2gray(I);
[rows columns]=size(I);

% Daubechies D4 Filter
lpfCoeff =[0.48296 0.83652 0.22414 -0.12941];

%% Decomposition level
J = 4;

%% Start the decomposition and Reconstruction process

% DWT
[C, S, wc] = discreteWavletTrans(I, J, lpfCoeff);

figure(1), ptr2d(wc, J); colormap(gray(256)); % show the DWT result
title(['DWT at level ', num2str(J)]);

 figure(2)
% reconstruction at different levels
for level = 1:J
    
    imageReconst = InvdiscreteWavletTrans(C, S, level, lpfCoeff);
    subplot(2,2,level);
    affiche(imageReconst);
    title(['IDWT at level ', num2str(level)]);
end

figure(3), 
subplot(1,2,1), affiche(I), title('Original Image')
subplot(1,2,2), affiche(imageReconst); title(['Final Reconstruction , level = ', num2str(J)] );

%max(abs(imageReconst(:)-I(:)))

%% Image Denoising

% Daubechies D4 Filter
lpfCoeff =[0.48296 0.83652 0.22414 -0.12941];

% Change level of Decmposition HERE
J = 4;

variance  = 30;

% add uniform noise to image range 30
% addnoise is a separated function
Inoise = addnoise(I,30);

% DWT
[C, S, wc] = discreteWavletTrans(Inoise, J, lpfCoeff);

%estimation of noise level
nEle = S(J,1) * S(J,2);
hf = [C(1, nEle+1:2*nEle) C(1, 2*nEle+1:3*nEle) C(1, 3*nEle+1:4*nEle)];

%calculate sigma
sigma=median(abs(hf))/0.6745;

threshold=3*sigma;

% Soft thresholding
CSoft = (sign(C).*(abs(C)-threshold)).*((abs(C)>threshold));

%Hard Thresholding
CHard = C.*((abs(C)>threshold));

%reconstruction with soft and hard thresholds
imageReconstSoft = InvdiscreteWavletTrans(CSoft, S, J, lpfCoeff);
imageReconstHard = InvdiscreteWavletTrans(CHard, S, J, lpfCoeff);

figure(4)
subplot(2,2,1),affiche(I), title('original image');
subplot(2,2,2),affiche(Inoise), title(['Uniform Noise Image,  variance :', num2str(variance)]);
subplot(2,2,3),affiche(imageReconstSoft), title('Denoise Soft Thresholding')
subplot(2,2,4),affiche(imageReconstHard), title('Denoise Hard Thresholding')


squaredErrorImage1 = (double(I) - double(imageReconstSoft)) .^ 2;
squaredErrorImage2 = (double(I) - double(imageReconstHard)) .^ 2;
mse1 = sum(sum(squaredErrorImage1)) / (rows * columns);
mse2 = sum(sum(squaredErrorImage2)) / (rows * columns);
    
fprintf('The mean square error for denoising image soft threshold is %.2f.', mse1);
fprintf('\n')
fprintf('The mean square error for denoising image hard threshold is %.2f.', mse2);