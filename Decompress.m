% Image decompression funtion
function reco_image = Decompress(comp_image)

% Initialization
% �ҵ����Ų�ͬͼ�����ڵ�λ�ã����ҷ������
for i=1:4
    clear temp_image
    
    pos = find(comp_image == 10002);
    switch i
        case 1
            temp_image = comp_image(1: pos(1));
        otherwise
            temp_image = comp_image(pos(i-1)+1:pos(i));
    end
   
    
    pos = find(temp_image == 10001);
    
    % ��Y��U��V�ֱ����
    comp_image_Y = temp_image(1:pos(1));
    comp_image_U = temp_image(pos(1)+1:pos(2));
    comp_image_V = temp_image(pos(2)+1:pos(3));
    
    % ���ý�ѹ������
    orig_image_Y = jpg2img(comp_image_Y);
    orig_image_U =  jpg2img(comp_image_U);
    orig_image_V =  jpg2img(comp_image_V);
    
    % ��ԭ��RGBͼ��
    RI=orig_image_Y-0.001*orig_image_U+1.402*orig_image_V;
    GI=orig_image_Y-0.344*orig_image_U-0.714*orig_image_V;
    BI=orig_image_Y+1.772*orig_image_U+0.001*orig_image_V;
    
    RGBI=cat(3,RI,GI,BI);
    RGBI=uint8(RGBI);
    
    save_image(:,:,:,i) = double(RGBI);
end
reco_image = save_image;
