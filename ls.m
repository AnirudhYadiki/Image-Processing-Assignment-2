ori_image  = double(imread('GroundTruth1_1_1.jpg'));
szo = size(ori_image);


image = imread('Blurry1_1.jpg');
sz = size(image);
imagef = fft2(image);


p = [ 0, -1, 0 ; -1, 4, -1; 0, -1, 0];
p1 = padarray(p,[sz(1)-3,sz(2)-3],'post');
p1 = fft2(p1);

kernel = imread('blur4.png');
szk = size(kernel);
kernel1 = padarray(kernel,[sz(1)-szk(1),sz(2)-szk(2)],'post');
ker = fft2(kernel1);
ker =  conj(ker)./(abs(ker).^2 + 10000000.*(abs(p1).^2) );

imagef = imagef.*ker;
new_image = abs(ifft2(imagef));
new_image = new_image.*20;

%figure
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




