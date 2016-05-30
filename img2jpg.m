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
    i = max(find(y(:, j)));         % �ҵ����һ������Ԫ��
    if isempty(i)
        i = 0;
    end
    p = count + 1;
    q = p + i;
    r(p:q) = [y(1:i, j); eob];      % ����������־
    count = count + i + 1;          % ����
end
rac = [rac 9999 xb];
rac = rac.';

% rdc����ֱ��������rac������������
result = cat(1, rac, rdc);
% �����г̱��룬����9999���з���
acbefore = find(result == 9999);
recxb = result(acbefore+1);
rec = zeros(64, recxb);
ki = 2;
kj = 1;
rec(1, 1) = result(acbefore + 2);
for i=1:(acbefore-1)/2+1
    j=2*i-1;
    if(j<acbefore)
        ra = result(j,1);
        rb = result(j+1,1);
        if(ra == rb && ra == 0)
            if(kj == recxb)
                break;
            end
            kj = kj+1;
            ki = 2;
            rec(1, kj) = result(acbefore+2)+result(acbefore+kj+1) ;   
        else
            for kk=1:ra
                rec(ki, kj) = 0;
                ki = ki + 1;
            end
            rec(ki, kj) = rb;
            ki = ki + 1;
        end
    end
end
% ����һά����
trans = double([10000 uint16(xn) uint16(xm) flag 10001]');
result = cat(1, result, trans);
save = result;
end