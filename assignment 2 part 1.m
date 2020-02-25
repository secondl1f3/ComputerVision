img = imread('image1.jpg');
image_size = size(img);
[x,y,z] = size(img);
%find the brightness range
minimum_range= min(min(img));
maximum_range= max(max(img));
%show image histogram
imhist(img);

%find image brightness average
img_brightness = mean2(img);
img_new_bright = 200-img_brightness;
new_img = img+img_new_bright;
image_info = imageinfo('image1.jpg');
%reduce the brightness
images = img-180;
%imshow(image);
image_gray = rgb2gray(img);
%convert image binarized
image_binarized = image_gray > 47;
image_binarized = im2uint8(image_binarized);

subplot(3,3,2);
imshow(new_img);
title('4. Brightness = 200', 'FontSize', 12)
subplot(3,3,5);
imshow(image_binarized);
title('5. Extract the sail of the boat', 'FontSize', 12)
subplot(3,3,8);
subtract_img = img - image_binarized;
imshow(subtract_img);
title('6. Subtract the image ', 'FontSize', 12)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);

