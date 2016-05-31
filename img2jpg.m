function save = img2jpg( x,flag )
[xm, xn] = size(x);
%z字型读取数据顺序表
order = [1 9  2  3  10 17 25 18 11 4  5  12 19 26 33  ...
    41 34 27 20 13 6  7  14 21 28 35 42 49 57 50  ...
    43 36 29 22 15 8  16 23 30 37 44 51 58 59 52  ...
    45 38 31 24 32 39 46 53 60 61 54 47 40 48 55  ...
    62 63 56 64];

y = im2col(x, [8 8], 'distinct');  % 将8x8 的块转化为列
xb = size(y, 2);                   % 分块数
y = y(order, :);                   % 按照order的顺序排列数据

eob = max(y(:)) + 1;               % 设置块尾结束标志
count = 0;

rdc = zeros(xb, 1);   % 生成dc的游程编码列矩阵
rdc = [y(1,1)];
biggest = y(1,1);
rac = [];   % 生成ac的游程编码矩阵
zcount = 0;
for j = 1:xb                       % 每次处理一个块
    for k=2:64
        if(y(k,j)==0)
            zcount = zcount + 1;
        else
            rac = [rac zcount y(k,j)];
            zcount=0;
        end
    end
    if(j>1)
        rdc(j,1) = y(1,j) - biggest;
    end
    zcount = 0;
    rac = [rac zcount 0];
end
rac = [rac 9999 xb];
rac = rac.';

% rdc保存直流分量，rac保留交流分量
result = cat(1, rac, rdc);

% % 生成一维矩阵
trans = double([10000 uint16(xn) uint16(xm) flag 10001]');
result = cat(1, result, trans);
save = result;
end