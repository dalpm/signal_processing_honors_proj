%% Question 1(c)
lena512 = load("lena512.mat");
lena512 = lena512.lena512;

Y = fft2(lena512);
%% set the phase equal to 0
Y1 = abs(Y);

img1 = ifft2(Y1);
% normalizing the values to 0 - 255
img1 = img1 - min(img1, [],"all");
img1 = img1 .* (255 / max(img1, [],"all"));

tiledlayout(1, 2)
nexttile
imshow(lena512, [])
title("Original Image")
nexttile
imshow(img1, [])
title("f_{1}(x,y), Phase Equal to 0")
%% set the magnitude equal to 1
Y2 = Y;
[r, c] = size(Y2);
for i=1:r
    for j=1:c
        Y2(i, j) = Y2(i, j) / abs(Y2(i, j));
    end
end

img2 = ifft2(Y2);
% normalizing the values to 0 - 255
img2 = img2 - min(img2, [],"all");
img2 = img2 .* (255 / max(img2, [],"all"));


tiledlayout(1, 2)
nexttile
imshow(lena512, [])
title("Original Image")
nexttile
imshow(img2, [])
title("f_{2}(x,y), Magnitude Equal to 1")