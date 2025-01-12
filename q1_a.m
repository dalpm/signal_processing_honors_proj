%% Question 1(a)
lena512 = load("lena512.mat");
square = load("square.mat");
lena512 = lena512.lena512;
square = square.A;


%% Box Blur 3x3, 5x5, 11x11 - Lena
blurred_lenna_3 = box_blur(lena512, 3);
blurred_lenna_5 = box_blur(lena512, 5);
blurred_lenna_11 = box_blur(lena512, 11);
tiledlayout(2, 2);
nexttile
imshow(lena512, [])
title("Original Image")
nexttile
imshow(blurred_lenna_3, [])
title("3x3 Box Blur")
nexttile
imshow(blurred_lenna_5, [])
title("5x5 Box Blur")
nexttile
imshow(blurred_lenna_11, [])
title("11x11 Box Blur")


%% Gaussian Blur 3x3,5x5
blurred_lenna_gaus_3 = gaussian_blur(lena512, 3);
blurred_lenna_gaus_5 = gaussian_blur(lena512, 5);
tiledlayout(2, 2);
nexttile
imshow(lena512, [])
title("Original Image")
nexttile
imshow(blurred_lenna_gaus_3, [])
title("3x3 Gaussian Blur")
nexttile
imshow(blurred_lenna_gaus_5, [])
title("5x5 Gaussian Blur")

%% Laplacian Blur 3x3, with 2 different kernels
lena_lapl_1 = laplacian_blur(lena512, 1);
lena_lapl_2 = laplacian_blur(lena512, 2);
tiledlayout(2, 2);
nexttile
imshow(lena512, [])
title("Original Image")
nexttile
imshow(lena_lapl_1, [])
title("3x3 Laplacian Blur - 1")
nexttile
imshow(lena_lapl_2, [])
title("3x3 Laplacian Blur - 2")
