function [ x ] = jpg2img( comp_image )
%低频分量量化表
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
%高频分量量化表
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
rev = order;                          % 计算反序
for k = 1:length(order)
    rev(k) = find(order == k);
end

pos = find(comp_image == 999);
s = double(comp_image(pos+1));
xb = double(comp_image(pos+4));             % 块的个数
xn =  double(comp_image(pos+2));                           % 列数
xm =  double(comp_image(pos+3));                           % 行数
flag = comp_image(pos+5);
x = zeros(s, 1);
for i=1:pos-1
    x(i) = comp_image(i);
end
eob = max(x(:));                      % 返回块尾标志

z = zeros(64, xb);   k = 1;           % 生成 64 * xb 的零矩阵
for j = 1:xb                          % x中的值放入z中，如果遇到eob就转入下一列
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
T=dctmtx(8);                                   %产生一个8*8的DCT变换举证
z = z(rev, :);                                 % 按order恢复之前排列
x = col2im(z, [8 8], [xm xn], 'distinct');     % 生成矩阵
if flag==1
    x = blkproc(x, [8 8], 'x .* P1', a);       % 反量化，乘量化表的值
else
    x = blkproc(x, [8 8], 'x .* P1', b);
end
x = blkproc(x, [8 8], 'P1 * x * P2', T', T);   % 反DCT变换
end