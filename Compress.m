% Image compression funtion
function  comp_image = Compress(orig_image)
image1 = orig_image(:,:,:,1);
image2 = orig_image(:,:,:,2);
image3 = orig_image(:,:,:,3);
image4 = orig_image(:,:,:,4);

image1 = SingleCom(image1);
image2 = SingleCom(image2);
image3 = SingleCom(image3);
image4 = SingleCom(image4);

save_image = [];

save_image = cat(1, save_image, image1);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image2);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image3);
save_image = cat(1, save_image, 10002);
save_image = cat(1, save_image, image4);
save_image = cat(1, save_image, 10002);

comp_image = save_image;
