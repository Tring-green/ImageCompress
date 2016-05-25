close all;
clear all;

clear orig_image;

starttime = cputime;

orig_image = double(imread('image3.bmp'));

temp_image = double(orig_image);
figure(1);
subplot(2,2,1);
imdisplay(orig_image)
o_y = orig_image(:,:,1);
[m,n,l] = size(orig_image);
%将RGB色度空间转化为YCbCr空间
RGB=orig_image;
clear orig_image
%下面是对 RGB 三个分量进行分离 
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);
%RGB->YUV 
Y=0.299*double(R)+0.587*double(G)+0.114*double(B);   
[xm, xn] = size(Y); 
U=-0.169*double(R)-0.3316*double(G)+0.5*double(B);
V=0.5*double(R)-0.4186*double(G)-0.0813*double(B);
clear R
clear G
clear B
T=dctmtx(8);
%进行 DCT 变换 BY BU BV 是 double 类型
BY=blkproc(Y,[8 8],'P1*x*P2',T,T'); 
BU=blkproc(U,[8 8],'P1*x*P2',T,T'); 
BV=blkproc(V,[8 8],'P1*x*P2',T,T');     %低频分量量化表

clear Y
clear U
clear V

a=[
16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 55;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77; 
24 35 55 64 81 104 113 92;                         
49     64 78 87 103 121 120 101;                     
72 92 95 98 112 100 103 99;
]; %高频分量量化表
b=[17 18 24 47 99 99 99 99; 
18 21 26 66 99 99 99 99; 
24 26 56 99 99 99 99 99; 
47 66 99 99 99 99 99 99; 
99 99 99 99 99 99 99 99; 
99 99 99 99 99 99 99 99; 
99 99 99 99 99     99 99 99; 
99 99 99 99 99 99 99 99;];
%使用量化表对三个分量进行量化 
BY2=blkproc(BY,[8 8],'round(x./P1)',a); 
BU2=blkproc(BU,[8 8],'round(x./    P1)',b); 
BV2=blkproc(BV,[8 8],'round(x./P1)',b);
clear BY
clear BU
clear BV

comp_image_Y=img2jpg(BY2,1);         
comp_image_U=img2jpg(BU2,2);                     
comp_image_V=img2jpg(BV2,3);

comp_Y_U = cat(1, comp_image_Y, comp_image_U);
comp_image = cat(1, comp_Y_U, comp_image_V);

pos = find(comp_image == 10001);

comp_image_Y = comp_image(1:pos(1));
comp_image_U = comp_image(pos(1)+1:pos(2));
comp_image_V = comp_image(pos(2)+1:pos(3));

orig_image_Y = jpg2img(comp_image_Y);
orig_image_U = jpg2img(comp_image_U);
orig_image_V = jpg2img(comp_image_V);

RI=orig_image_Y-0.001*orig_image_U+1.402*orig_image_V; 
GI=orig_image_Y-0.344*orig_image_U-0.714*orig_image_V; 
BI=orig_image_Y+1.772*orig_image_U+0.001*orig_image_V;

RGBI=cat(3,RI,GI,BI);
RGBI=uint8(RGBI);
reco_image = RGBI;

orig_image = reco_image;

subplot(2,2,2);
imdisplay(orig_image(:,:,:,1))
runtime = cputime - starttime;

comp_image = double(comp_image);

comp_ratio = Compratio(temp_image, comp_image);
ratiomesg = sprintf('The compression ratio is = %6.2f\n', comp_ratio);
disp(ratiomesg );
orig_image = double(orig_image);
MSE = CalMSE(temp_image, round(orig_image));
distortionmesg = sprintf('The MSE is = %6.2f\n', MSE);
disp(distortionmesg );
timemesg = sprintf('The running time is = %6.2f\n', runtime);
disp(timemesg );
