function plot_results(L, Spectrum, Spectrum_temp, window)
%     Plots Spectrum, newly found points and search window during
%     computation.
    cast(Spectrum, 'like', 1+1i);
    cast(Spectrum_temp, 'like', 1+1i);
    plot(Spectrum,'.','MarkerEdgeColor',[0.2 0.2 0.9], 'MarkerSize',5);
    xlim([min(real(L(:))) max(real(L(:)))]);
    ylim([min(imag(L(:))) max(imag(L(:)))]);
    hold on
    scatter(real(window(:)), imag(window(:)),'filled','SizeData',1);
    plot(Spectrum_temp,'.','MarkerEdgeColor',[0 0 0], 'MarkerSize',5);
    alpha(0.2)
    hold off
    getframe;
    pause(0.001)
end
