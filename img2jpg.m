function save = img2jpg( x,flag )
[xm, xn] = size(x);
%z���Ͷ�ȡ����˳���
order = [1 9  2  3  10 17 25 18 11 4  5  12 19 26 33  ...
    41 34 27 20 13 6  7  14 21 28 35 42 49 57 50  ...
    43 36 29 22 15 8  16 23 30 37 44 51 58 59 52  ...
    45 38 31 24 32 39 46 53 60 61 54 47 40 48 55  ...
    62 63 56 64];

y = im2col(x, [8 8], 'distinct');  % ��8x8 �Ŀ�ת��Ϊ��
xb = size(y, 2);                   % �ֿ���
y = y(order, :);                   % ����order��˳����������

eob = max(y(:)) + 1;               % ���ÿ�β������־
count = 0;

rdc = zeros(xb, 1);   % ����dc���γ̱����о���
rdc = [y(1,1)];
biggest = y(1,1);
rac = [];   % ����ac���γ̱������
zcount = 0;
for j = 1:xb                       % ÿ�δ���һ����
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

% rdc����ֱ��������rac������������
result = cat(1, rac, rdc);

% % ����һά����
trans = double([10000 uint16(xn) uint16(xm) flag 10001]');
result = cat(1, result, trans);
save = result;
end