function filter_2d = filter_high_pass(order, freq)
    % ��ͨ�˲����� order ��ҪΪż������������������ fir1 �Ĺ���� 1.
    if mod(order, 2)
        order = order+1;
    end
    % ����һά��ͨ�˲���
    filter_1d = fir1(order, freq, 'high');
    mid = order/2+1;
    d_square_max = (mid-1)^2;
    
    % ����ת��һά�˲����������ά��ͨ
    filter_2d = zeros(order+1, order+1);
    for x = 1:order+1
       for y = 1:order+1
           d_square = (x-mid)^2+(y-mid)^2;
           if d_square <= d_square_max
               filter_2d(x, y) = filter_1d(mid-round(sqrt(d_square)));
           end
       end
    end
end