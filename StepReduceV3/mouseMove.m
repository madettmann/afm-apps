function C = mouseMove (object, eventdata)

C = get (gca, 'CurrentPoint');
% title(gca, ['(X,Y) = (',num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
axesHandlesToChildObjects = findobj(gca, 'Type', 'line');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end	
if round(C(1,2)) < 512
    if round(C(1,2)) > 0
        hline = refline(gca, [0,round(C(1,2))]);
        hline.LineWidth = 10;
        hline.Color = 'white';
        hline.Color(4) = 0.5;
    end
end

