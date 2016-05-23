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

size1 = size(image1);
size2 = size(image2);
size3 = size(image3);
size4 = size(image4);

sizeall = [size1(1) size2(1) size3(1) size4(1)];
sizemax = max(sizeall);

clear temparr;
clear smallarr;
clear bigarr;
temparr = zeros(sizemax, sizemax, 3);
for k=1:3
    smallarr = temparr(:,:,k);
    bigarr = image1(:,:,k);
    for i=1:size1(1)*size1(1)
        smallarr(i) = bigarr(i);
    end
    temparr(:,:,k) = smallarr;
end
image1 = temparr;

clear temparr;
clear smallarr;
clear bigarr;
temparr = zeros(sizemax, sizemax, 3);
for k=1:3
    smallarr = temparr(:,:,k);
    bigarr = image2(:,:,k);
    for i=1:size2(1)*size2(1)
        smallarr(i) = bigarr(i);
    end
    temparr(:,:,k) = smallarr;
end
image2 = temparr;

clear temparr;
clear smallarr;
clear bigarr;
temparr = zeros(sizemax, sizemax, 3);
for k=1:3
    smallarr = temparr(:,:,k);
    bigarr = image3(:,:,k);
    for i=1:size3(1)*size3(1)
        smallarr(i) = bigarr(i);
    end
    temparr(:,:,k) = smallarr;
end
image3 = temparr;

clear temparr;
clear smallarr;
clear bigarr;
temparr = zeros(sizemax, sizemax, 3);
for k=1:3
    smallarr = temparr(:,:,k);
    bigarr = image4(:,:,k);
    for i=1:size4(1)*size4(1)
        smallarr(i) = bigarr(i);
    end
    temparr(:,:,k) = smallarr;
end
image4 = temparr;

temp_image(:,:,:,1) = image1;
temp_image(:,:,:,2) = image2;
temp_image(:,:,:,3) = image3;
temp_image(:,:,:,4) = image4;

comp_image = temp_image;
