function play_simulation(img, segment_locs, game_mat)
    addpath('../linkgame');
    steps = omg(game_mat);
    figure;
    ax_game = subplot('Position', [0.05 0.05 0.78 0.9])
    imshow(img);
    hold on;
    ax_pair1 = subplot('Position', [0.85 0.25 0.1 0.2])
    ax_pair2 = subplot('Position', [0.85 0.55 0.1 0.2])
    
    for k = 1:steps(1)
       locs1 = segment_locs{steps(4*k-2), steps(4*k-1)};
       locs2 = segment_locs{steps(4*k), steps(4*k+1)};
       axes(ax_pair1);
       imshow(img(locs1(2):locs1(2)+locs1(4)-1, ...
           locs1(1):locs1(1)+locs1(3)-1));
       axes(ax_pair2);
       imshow(img(locs2(2):locs2(2)+locs2(4)-1, ...
           locs2(1):locs2(1)+locs2(3)-1));
       axes(ax_game);
       rectangle('Position', locs1, 'EdgeColor','r', 'LineWidth', 2);
       rectangle('Position', locs2, 'EdgeColor','r', 'LineWidth', 2);
       pause(1);
       rectangle('Position', locs1, 'FaceColor','k', 'LineWidth', 2);
       rectangle('Position', locs2, 'FaceColor','k', 'LineWidth', 2);
       pause(0.5);
    end      
end