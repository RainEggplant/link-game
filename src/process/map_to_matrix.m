function [game_mat, patterns] = map_to_matrix(mat_size, corrs)
    game_mat = zeros(mat_size);
    patterns = {};
    
    % 优先使用相关系数高的数据进行归类
    for k = 1:length(corrs)
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
        
        % 每一块均已归类，即可结束
        if all(game_mat(:))
            break; 
        end
    end
    
    % 合并相同的 pattern
    for k = 1:max([patterns{:}])
        contains_k = [cellfun(@(x) any(x==k), patterns)];
        if any(contains_k)
            idx = find(contains_k);
            patterns{idx(1)} = unique([patterns{idx}]);
            patterns(idx(2:end)) = [];
            game_mat(patterns{idx(1)}) = idx(1);
        end
    end
end
