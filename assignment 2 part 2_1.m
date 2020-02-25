%Read in original RGB image.
rgbImage = imread('image2.jpg');
%Extract color channels.
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
imshow(rgbImage);
fontSize = 12;
title('Original RGB Image', 'FontSize', fontSize)
subplot(3, 3, 3);
imhist(rgbImage);
title('Histogram of Original Image', 'FontSize', fontSize)

%%
%Red Channel
subplot(3, 3, 4);
imshow(just_red);
title('Red Channel in Red', 'FontSize', fontSize)
subplot(3, 3, 7);
imhist(just_red);
title('Histogram of Red Channel', 'FontSize', fontSize)
minimum_brightness_red = min(min(just_red));
maximum_brightness_red = max(max(just_red));
matrix_red = just_red(1:8,1:8);
red_gray = rgb2gray(just_red);
%%
%%Green Channel
subplot(3, 3, 5);
imshow(just_green);
title('Green Channel in Green', 'FontSize', fontSize)
subplot(3, 3, 8);
imhist(just_green);
title('Histogram of Green Channel', 'FontSize', fontSize)
minimum_brightness_green = min(min(just_green));
maximum_brightness_green = max(max(just_green));

matrix_green = just_green(1:8,1:8);
green_gray = rgb2gray(just_green);
%%
%%Blue Channel
subplot(3, 3, 6);
imshow(just_blue);
title('Blue Channel in Blue', 'FontSize', fontSize)
subplot(3, 3, 9);
imhist(just_blue);
title('Histogram of Blue Channel', 'FontSize', fontSize)
matrix_blue = just_blue(1:8,1:8);
blue_gray = rgb2gray(just_blue);
minimum_brightness_blue = min(min(just_blue));
maximum_brightness_blue = max(max(just_blue));
%%
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);

% Give a name to the title bar.
set(gcf, 'Name', 'Computer Vision Assignment 2', 'NumberTitle', 'Off')