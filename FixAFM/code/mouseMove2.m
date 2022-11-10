function C = mouseMove2 (object, eventdata)
global data;
global width;
C = get (gca, 'CurrentPoint');
% title(gca, ['(X,Y) = (',num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
axesHandlesToChildObjects = findobj(gca, 'Type', 'rectangle');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end	
[numRows,numCols] = size(data);
pos = [round(C(1,1)),round(C(1,2))];
if pos(1) < numRows-width/2 && pos(2) < numCols-width/2
    if pos(1) > width/2 && pos(2) > width/2
        coords = [pos(1)-width/2,pos(2)-width/2,width,width];
        r = rectangle('Position',coords);
        r.FaceColor = 'white';
        r.FaceColor(4) = 0.5;
    end
end