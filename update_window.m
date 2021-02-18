function [window, clusters_old] = update_window(window_old, clusters_old, Spectrum_temp, Spectrum_temp_old, L, h_L, n_sample, r)
%     Updates the search window foe zeros when theta changes
    if isempty(Spectrum_temp)
        window = L(box(L, bdry_pts(Spectrum_temp_old, h_L), r));
    else
        window = L(box(L, bdry_pts(Spectrum_temp, h_L), r));
        clusters = n_clusters(window, n_sample);
        if clusters<clusters_old
            window = L(box(L, bdry_pts(window_old, h_L), r));
        end
        clusters_old = clusters;
    end
end