function [ x ] = jpg2img( comp_image )
%��Ƶ����������
a=[
    16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 55;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99;
    ];
%��Ƶ����������
b=[17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;];

order = [1 9  2  3  10 17 25 18 11 4  5  12 19 26 33  ...
    41 34 27 20 13 6  7  14 21 28 35 42 49 57 50  ...
    43 36 29 22 15 8  16 23 30 37 44 51 58 59 52  ...
    45 38 31 24 32 39 46 53 60 61 54 47 40 48 55  ...
    62 63 56 64];
rev = order;                          % ���㷴��
for k = 1:length(order)
    rev(k) = find(order == k);
end

pos = find(comp_image == 999);
s = double(comp_image(pos+1));
xb = double(comp_image(pos+4));             % ��ĸ���
xn =  double(comp_image(pos+2));                           % ����
xm =  double(comp_image(pos+3));                           % ����
flag = comp_image(pos+5);
x = zeros(s, 1);
for i=1:pos-1
    x(i) = comp_image(i);
end
eob = max(x(:));                      % ���ؿ�β��־

z = zeros(64, xb);   k = 1;           % ���� 64 * xb �������
for j = 1:xb                          % x�е�ֵ����z�У��������eob��ת����һ��
    for i = 1:64
        if x(k) == eob
            k = k + 1;
            break;
        else
            z(i, j) = x(k);
            k = k + 1;
        end
    end
end
T=dctmtx(8);                                   %����һ��8*8��DCT�任��֤
z = z(rev, :);                                 % ��order�ָ�֮ǰ����
x = col2im(z, [8 8], [xm xn], 'distinct');     % ���ɾ���
if flag==1
    x = blkproc(x, [8 8], 'x .* P1', a);       % ������������������ֵ
else
    x = blkproc(x, [8 8], 'x .* P1', b);
end
x = blkproc(x, [8 8], 'P1 * x * P2', T', T);   % ��DCT�任
end