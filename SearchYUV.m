function target_image = SearchYUV(image, which, flag)
if(flag == 1)
    beg1 = find(image==which-flag);
    end1 = find(image==which-flag-1);
    temp_image = zeros(end1-beg1, 1);
end
