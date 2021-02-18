function clusters = n_clusters(window, n_sample)
%     Computes the number of blobs that make up the search window.
    pts = datasample(window,n_sample,'Replace',false);
    pairs = nchoosek(pts, 2);
    distances = sort(abs(pairs(:,1)-pairs(:,2)));
    distr = zeros(1,100);
    for i=1:length(distr)
        distr(i) = length(distances((i-1)/2<distances & distances<i/2));
    end
    c=1;
    for i=2:length(distr)
        if distr(i-1) == 0 && distr(i) >0
            c = c + 1;
        end
    end
    clusters = round(0.5*(sqrt(8*c-7)+1));
end