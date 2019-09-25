function show_matches(segments, corrs, offset)
    figure;
    for k = 1:5
        idx = k+offset;
        subplot(5, 4, 4*(k-1)+1);
        imshow(segments{corrs(idx, 2)});
        ylabel(['r=', num2str(corrs(idx, 1), 4)]);
        title(['index: ', num2str(corrs(idx, 2))]); 
        subplot(5, 4, 4*(k-1)+2);
        imshow(segments{corrs(idx, 3)});
        title(['index: ', num2str(corrs(idx, 3))]); 
    end
    
    for k = 6:10
        idx = k+offset;
        subplot(5, 4, 4*(k-6)+3);
        imshow(segments{corrs(idx, 2)});
        ylabel(['r=', num2str(corrs(idx, 1), 4)]);
        title(['index: ', num2str(corrs(idx, 2))]); 
        subplot(5, 4, 4*(k-6)+4);
        imshow(segments{corrs(idx, 3)});
        title(['index: ', num2str(corrs(idx, 3))]); 
    end
end