function print_legend(segments, patterns)
    figure;
    for k = 1:length(patterns)
        subplot(4, 5, k);
        imshow(segments{patterns{k}(1)});
        title(num2str(k)); 
    end
end
