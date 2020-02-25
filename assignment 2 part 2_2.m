% Read in original RGB image.
rgbImage = imread('image2.jpg');
% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel
% Create an all black channel.
allBlack = zeros(size(rgbImage, 1), size(rgbImage, 2), 'uint8');
% Create color versions of the individual color channels.
just_red = cat(3, redChannel, allBlack, allBlack);
just_green = cat(3, allBlack, greenChannel, allBlack);
just_blue = cat(3, allBlack, allBlack, blueChannel);
% Recombine the individual color channels to create the original RGB image again.
recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
% Display them all.
subplot(3, 3, 2);
%imshow(rgbImage);
img_gray = rgb2gray(rgbImage);
imshow(img_gray);
fontSize = 12;
title('Original Gray Image', 'FontSize', fontSize)
subplot(3, 3, 4);
imshow(just_red);
title('Red Channel in Red', 'FontSize', fontSize)
subplot(3,3,7);
red_gray = rgb2gray(just_red);
imshow(red_gray);

subplot(3, 3, 5);
imshow(just_green)
title('Green Channel in Green', 'FontSize', fontSize)
subplot(3,3,8);
green_gray = rgb2gray(just_green);
imshow(green_gray);

subplot(3, 3, 6);
imshow(just_blue);
title('Blue Channel in Blue', 'FontSize', fontSize)
subplot(3, 3, 9);
blue_gray = rgb2gray(just_blue);
imshow(blue_gray);
subplot(3, 3, 3);
imshow(recombinedRGBImage);
title('Recombined to Form Original RGB Image Again', 'FontSize', fontSize)
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Computer Vision Assignment 2', 'NumberTitle', 'Off')