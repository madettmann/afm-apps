function setWidth(source,event)
global width;

width = round(source.Value);
width = width + mod(width,2);
end
