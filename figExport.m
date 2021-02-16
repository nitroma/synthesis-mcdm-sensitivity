function figExport(w,h,name)
fig = gcf;
fig.PaperOrientation = 'landscape';
fig.PaperSize = [w h];
fig.PaperPosition = [0 0 w h];
% fig.Renderer = 'Painters'; % for 3D plots
print(gcf, '-dpdf', [pwd '/figures/' name '.pdf']);
end