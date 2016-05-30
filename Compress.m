% Image compression funtion
function  comp_image = Compress(orig_image)

% 将四个不同的图像抽取出来
image1 = orig_image(:,:,:,1);
image2 = orig_image(:,:,:,2);
image3 = orig_image(:,:,:,3);
image4 = orig_image(:,:,:,4);

% 分别对四个图像进行压缩
image1 = SingleCom(image1);
image2 = SingleCom(image2);
image3 = SingleCom(image3);
image4 = SingleCom(image4);

save_image = [];

% 将四个图像进行连接，并用10002进行区分
save_image = cat(1, save_image, image1);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image2);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image3);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image4);
save_image = cat(1, save_image, 10002);

comp_image = save_image;
