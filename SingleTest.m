function  comp_image = SingleTest(orig_image, which)
[m,n,l] = size(orig_image);
%将RGB色度空间转化为YCbCr空间
X = reshape(orig_image(:),m*n,3);clear RGB;
X=double(X);
Y = 0.229*X(:,1)+0.587*X(:,2)+0.114*X(:,3);
Cb =-0.1687*X(:,1)-0.3313*X(:,2)+0.5*X(:,3)+128;
Cr = 0.5*X(:,1)-0.4187*X(:,2)-0.0813*X(:,3)+128;
Y=reshape(Y,m,n);
Cb=reshape(Cb,m,n);
Cr=reshape(Cr,m,n);clear X
%DCT变换
DCT_Y=blkproc(Y-128,[8 8],@dct2);clear Y;%亮度分量减去128后做DCT，为了减小直流分量系数
DCT_Cb=blkproc(Cb,[8 8],@dct2);clear Cb;
DCT_Cr=blkproc(Cr,[8 8],@dct2);clear Cr;
%量化
Q1=[16 11 10 16 24 40 51 61;%亮度分量的量化加权矩阵
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

Q2=[17 18 24 47 66 99 99 99;%色差分量的量化加权矩阵
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99];

DCT_Y=blkproc(DCT_Y,[8 8],'x./P1',Q1);
DCT_Y=int8(DCT_Y);
DCT_Cb=blkproc(DCT_Cb,[8 8],'x./P1',Q2);
DCT_Cb=int8(DCT_Cb);
DCT_Cr=blkproc(DCT_Cr,[8 8],'x./P1',Q2);
DCT_Cr=int8(DCT_Cr);

comp_image_Y=img2jpg(DCT_Y,1,0);
comp_image_U=img2jpg(DCT_Cb,2,0);
comp_image_V=img2jpg(DCT_Cr,3,0);


if numel(comp_image_Y)>=numel(comp_image_U)
    if numel(comp_image_Y)>=numel(comp_image_V)
        sizer = size(comp_image_Y);
    else
        sizer = size(comp_image_V);
    end
else
    if numel(comp_image_U)>=numel(comp_image_V)
        sizer = size(comp_image_U);
    else
        sizer = size(comp_image_V);
    end
end


clear temparr;
temparr = zeros(sizer(1));
for i=1:numel(comp_image_Y)
    temparr(i) = comp_image_Y(i);
end
comp_image_Y = temparr;

clear temparr;
temparr = zeros(sizer(1));
for i=1:numel(comp_image_U)
    temparr(i) = comp_image_U(i);
end
comp_image_U = temparr;

clear temparr;
temparr = zeros(sizer(1));
for i=1:numel(comp_image_V)
    temparr(i) = comp_image_V(i);
end
comp_image_V = temparr;

last_image = zeros(numel(comp_image_Y) +numel(comp_image_U) +numel(comp_image_V)+3,1);

for i=1:numel(comp_image_Y)
    last_image(i) = comp_image_Y(i);
end
last_image(i+1) = which-1;

for i=numel(comp_image_Y)+2:numel(comp_image_Y)+2+numel(comp_image_U)
    last_image(i) = comp_image_U(i);
end
last_image(i+1) = which-2;

for i=numel(comp_image_Y) +numel(comp_image_U)+3:numel(comp_image_Y) +numel(comp_image_U)+3+numel(comp_image_V)
    last_image(i) = comp_image_V(i);
end
last_image(i+1) = which-3;
comp_image = last_image
