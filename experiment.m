I1 = rgb2gray(imread('matric1.bmp'));
I2 = rgb2gray(imread('matric2.bmp'));
I3 = rgb2gray(imread('matric3.bmp'));
I4 = rgb2gray(imread('matric4.bmp'));
I5 = rgb2gray(imread('matric5.bmp'));

figure
subplot(3,2,1), imshow(I1);
subplot(3,2,2), imshow(I2);
subplot(3,2,3), imshow(I3);
subplot(3,2,4), imshow(I4);
subplot(3,2,5), imshow(I5);


%Preprocess

%TopHat

%Phase 1: closing
disk = strel('disk',3,8);
disk2 = strel('disk',15);%con este mamaño de elemento estructural se consigue
%borrar del todo la matrícula en las dos últimas imágenes.

II1 = imclose(I1,disk);
II2 = imclose(I2,disk);
II3 = imclose(I3,disk);
II4 = imclose(I4,disk2);
II5 = imclose(I5,disk2);


figure
subplot(3,2,1), imshow(II1);
subplot(3,2,2), imshow(II2);
subplot(3,2,3), imshow(II3);
subplot(3,2,4), imshow(II4);
subplot(3,2,5), imshow(II5);
