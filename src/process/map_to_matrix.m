function [game_mat, patterns] = map_to_matrix(mat_size, corrs, threshold)
    game_mat = zeros(mat_size);
    patterns = {};
    
    % 优先使用相关系数高的数据进行归类
    for k = 1:length(corrs)
        % 相关系数已低于阈值，并且每一块已被检测过时，结束归类
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
    
    % 合并相同的 pattern
    for k = 1:max([patterns{:}])
        idx = find(cellfun(@(x) any(x==k), patterns));
        if length(idx) > 1
            patterns{idx(1)} = unique([patterns{idx}]);
            patterns(idx(2:end)) = [];
        end
    end
    
    % 利用新的 pattern 编号更新索引矩阵
    for k = 1:length(patterns)
       game_mat(patterns{k}) = k; 
    end
end
