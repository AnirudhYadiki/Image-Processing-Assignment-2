ori_image  = double(imread('GroundTruth1_1_1.jpg'));
szo = size(ori_image);


image = imread('Blurry1_1.jpg');
sz = size(image);
imagef = fft2(image);


kernel = imread('blur4.png');
szk = size(kernel);
kernel1 = padarray(kernel,[sz(1)-szk(1),sz(2)-szk(2)],'post');
ker = fft2(kernel1);
ker =  conj(ker)./(abs(ker).^2 + 5000000);

imagef = imagef.*ker;
new_image = abs(ifft2(imagef)).*20;
% figure
imshow(new_image)
imwrite(new_image,'debl.jpg');
ori_image = ori_image./max(max(ori_image));
new_image = new_image./max(max(new_image));
SSIM = ssim(new_image , ori_image)
MSE = (new_image-ori_image).^2;
mse = mean(mean(mean(MSE)));
if mse == 0
  PSNR = 100
else
  PSNR = 20*log10(255/sqrt(mse))
end




