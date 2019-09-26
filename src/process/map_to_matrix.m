function [game_mat, patterns] = map_to_matrix(mat_size, corrs, threshold)
    game_mat = zeros(mat_size);
    patterns = {};
    
    % ����ʹ�����ϵ���ߵ����ݽ��й���
    for k = 1:length(corrs)
        % ���ϵ���ѵ�����ֵ������ÿһ���ѱ�����ʱ����������
        if corrs(k,1) < threshold && all(game_mat(:))
            break; 
        end
        
        p1 = corrs(k, 2);
        p2 = corrs(k, 3);
        mapped = false;
        
        for m = 1:length(patterns)
            if any(patterns{m} == p1)
                game_mat(p2) = m;
                patterns{m}(end+1) = p2;
                mapped = true;
                break;
            elseif any(patterns{m} == p2)
                game_mat(p1) = m;
                patterns{m}(end+1) = p1;
                mapped = true;
                break;
            end
        end
        
        if ~mapped
           patterns{end+1} = [p1, p2];
           game_mat(p1) = length(patterns);
           game_mat(p2) = length(patterns);  
        end
    end
    
    % �ϲ���ͬ�� pattern
    for k = 1:max([patterns{:}])
        idx = find(cellfun(@(x) any(x==k), patterns));
        if length(idx) > 1
            patterns{idx(1)} = unique([patterns{idx}]);
            patterns(idx(2:end)) = [];
        end
    end
    
    % �����µ� pattern ��Ÿ�����������
    for k = 1:length(patterns)
       game_mat(patterns{k}) = k; 
    end
end
