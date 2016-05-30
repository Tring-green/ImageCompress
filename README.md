# ImageCompress

##JPEG压缩的实现（代码部分来自网络）
###已经实现的方法
* RGB转YUV
* DCT变换
* 量化
* ZIG-ZAG扫描和游程编码

###文件以及作用
* main.m：主函数（自己实现）
* Compress.m：压缩函数（自己实现）
* Decompress.m：解压缩函数（自己实现）
* CalMSE.m：计算MSE函数
* Compratio.m：计算压缩比函数
* img2jpg.m：原图转JPG函数（自己实现）
* jpg2img.m：JPG转原图函数（自己实现）
* SingleCom.m：处理单独的RGB图像函数，包括图像转换、DCT变换和量化（自己实现）
