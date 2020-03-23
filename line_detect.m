I=imread('image1.png');
image(I), title('Original Image');

% Line Formula
horizontalKernel = [-1,-1,-1;2,2,2;-1,-1,-1];
verticalKernel = [2,-1,-1;-1,2,-1;-1,-1,2];
%verticalKernel = [-1,2,-1;-1,2,-1;-1,2,-1];
%diagUpKernel = [-1,-1,2;-1,2,-1;2,-1,-1];
diagUpKernel = [-1,2,-1;-1,2,-1;-1,2,-1];

% Title Images
title_horizontal = 'Horizontal Lines';
title_vertical = 'Vertical Lines';
title_diagonal = 'Diagonal Lines';

% Call the function to detect the lines
[herizontal]=line_detection(I,horizontalKernel,title_horizontal);
[vertical]=line_detection(I,verticalKernel,title_vertical);
[diagonalUp]=line_detection(I,diagUpKernel,title_diagonal);

% Detect the lines
function [line] = line_detection(I, line_format, title_line)

figure;
line = imfilter(I, line_format);
imshow(line), title(title_line);

end