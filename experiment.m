I1 = rgb2gray(imread('matricula (1).jpg'));
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
% disk = strel('disk',3,8);
% disk2 = strel('disk',15);%con este mamaño de elemento estructural se consigue
% %borrar del todo la matrícula en las dos últimas imágenes.
% 
% II1 = imclose(I1,disk);
% II2 = imclose(I2,disk);
% II3 = imclose(I3,disk);
% II4 = imclose(I4,disk2);
% II5 = imclose(I5,disk2);
% 
% 
% figure
% subplot(3,2,1), imshow(II1);
% subplot(3,2,2), imshow(II2);
% subplot(3,2,3), imshow(II3);
% subplot(3,2,4), imshow(II4);
% subplot(3,2,5), imshow(II5);

%%
%uso de la familia de funciones hough para detectar las lineas principales
eI1 = edge(I1);
[h,theta,rho] = hough(eI1);
peaks = houghpeaks(h,180);
lines = houghlines(I1,theta,rho,peaks);

lines = houghlines(eI1,theta,rho,peaks);
figure, imshow(eI1), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%%
%uso de la familia de funciones hough con preprocesamiento de imágenes
%imclose

diskSize = ceil(max(size(I1))/min(size(I1)));
disk = strel('disk',diskSize);
cI1 = imclose(I1,disk);
imshow(cI1);


ecI1 = edge(cI1);
[h,theta,rho] = hough(ecI1);
peaks = houghpeaks(h,180);
lines = houghlines(ecI1,theta,rho,peaks);

figure, imshow(ecI1), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


%%
% detección de líneas paralelas
[h,theta,rho] = hough(eI1);
paralelIndexes = houghparallel(theta,2);

%tomar los índices que nos importan
paralelUniqueIndexes = unique([paralelIndexes(:,1);paralelIndexes(:,2)]);