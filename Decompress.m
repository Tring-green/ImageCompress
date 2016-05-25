% Image decompression funtion
function reco_image = Decompress(comp_image)

% Initialization
for i=1:4
    clear temp_image
    temp_image = comp_image(:,:,:,i);
    
    comp_image_Y = temp_image(:,:,1);
    comp_image_U = temp_image(:,:,2);
    comp_image_V = temp_image(:,:,3);
    
    
    orig_image_Y = jpg2img(comp_image_Y);
    orig_image_U =  jpg2img(comp_image_U);
    orig_image_V =  jpg2img(comp_image_V);
    
    RI=orig_image_Y-0.001*orig_image_U+1.402*orig_image_V;
    GI=orig_image_Y-0.344*orig_image_U-0.714*orig_image_V;
    BI=orig_image_Y+1.772*orig_image_U+0.001*orig_image_V;
    
    RGBI=cat(3,RI,GI,BI);
    RGBI=uint8(RGBI);
    
    save_image(:,:,:,i) = double(RGBI);
end
reco_image = save_image;
