ori_image  = imread('GroundTruth1_1_1.jpg');

image = imread('Blurry1_1.jpg');
sz = size(image);
r_i = image(:,:,1);
g_i = image(:,:,2);
b_i = image(:,:,3);

R_i = fft2(r_i);
G_i = fft2(g_i);
B_i = fft2(b_i);

kernel = imread('blur4.png');
szk = size(kernel);
kernel1 = padarray(kernel,[sz(1)-szk(1),sz(2)-szk(2)],'post');
ker = fft2(kernel1);
ker = ker./max(max(ker));


x = (1:1:sz(1))';
y = 1:1:sz(1);
window = 1 + (x.^2 +y.^2)/500^2;
ker = ker.*window;


R_i = R_i./ker;
G_i = G_i./ker;
B_i = B_i./ker;

new_image = zeros(800,800,3);
r_i = abs(ifft2(R_i));
g_i = abs(ifft2(G_i));
b_i = abs(ifft2(B_i));

new_image(:,:,1) = r_i; 
new_image(:,:,2) = g_i;
new_image(:,:,3) = b_i;

new_image = uint8(new_image);
imshow(new_image)
imwrite(new_image,'debl.jpg');
SSIM = ssim(new_image , ori_image)
MSE = (new_image-ori_image).^2;
mse = mean(mean(mean(MSE)));
if mse == 0
  PSNR = 100
else
  PSNR = 20*log10(255/sqrt(mse))
end
