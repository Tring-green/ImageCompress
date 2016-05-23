% Main function of the final project
close all;
clear all;

% Read the original images to the matrix orig_image;
clear orig_image;
clear temp_image;
temp_image = imread('image1.bmp');
orig_image(:,:,:,1) = double(temp_image(:,:,:,1));
clear temp_image;
temp_image = imread('image2.bmp');
orig_image(:,:,:,2) = double(temp_image(:,:,:,1));
clear temp_image;
temp_image = imread('image3.bmp');
orig_image(:,:,:,3) = double(temp_image(:,:,:,1));
clear temp_image;
temp_image = imread('image4.bmp');
orig_image(:,:,:,4) = double(temp_image(:,:,:,1));

% Image compression
% You are required to implement this part
% Note: The components of comp_image should be integers
starttime = cputime;
clear comp_image;
comp_image = Compress(orig_image);

% Image decompression
% You are required to implement this part
% Note: The components of reco_image shoud be integers
%       The size of the reco_image should be same with the orig_image
clear reco_image;
reco_image = Decompress(round(comp_image));
runtime = cputime - starttime;

% Check the size of the recovered image
clear sizevector1;
clear sizevector2;
sizevector1 = size(orig_image);
sizevector2 = size(reco_image);
if sizevector1==sizevector2
    
    % Calculate the compression ratio
    comp_image = double(comp_image);
    comp_ratio = Compratio(orig_image, round(comp_image));
    % Calculate the distortion of the recovered images using Mean Square Error
    reco_image = double(reco_image);
    MSE = CalMSE(orig_image, round(reco_image));
    % Display the original image and recovered image
    figure(1);
    subplot(2,2,1);
    clear disp_image;
    disp_image = orig_image(:,:,:,1);
    imdisplay(disp_image);
    title('Original Image 1');
    subplot(2,2,2);
    clear disp_image;
    disp_image = reco_image(:,:,:,1);
    imdisplay(disp_image);
    title('Recovered Image 1');
    subplot(2,2,3);
    clear disp_image;
    disp_image = orig_image(:,:,:,2);
    imdisplay(disp_image);
    title('Original Image 2');
    subplot(2,2,4);
    clear disp_image;
    disp_image = reco_image(:,:,:,2);
    imdisplay(disp_image);
    title('Recovered Image 2');
    
    figure(2);
    subplot(2,2,1);
    clear disp_image;
    disp_image = orig_image(:,:,:,3);
    imdisplay(disp_image);
    title('Original Image 3');
    subplot(2,2,2);
    clear disp_image;
    disp_image = reco_image(:,:,:,3);
    imdisplay(disp_image);
    title('Recovered Image 3');
    subplot(2,2,3);
    clear disp_image;
    disp_image = orig_image(:,:,:,4);
    imdisplay(disp_image);
    title('Original Image 4');
    subplot(2,2,4);
    clear disp_image;
    disp_image = reco_image(:,:,:,4);
    imdisplay(disp_image);
    title('Recovered Image 4');
      
    % Output the performance
    ratiomesg = sprintf('The compression ratio is = %6.2f\n', comp_ratio);
    disp(ratiomesg );
    distortionmesg = sprintf('The MSE is = %6.2f\n', MSE);
    disp(distortionmesg );
    timemesg = sprintf('The running time is = %6.2f\n', runtime);
    disp(timemesg );     
else
    disp('The size of the recovered image is not correct');
end

