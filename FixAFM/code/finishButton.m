function B = finishButton (object, eventdata)
    global data;
    global spectra;
    global fileName;
    B = get (gca, 'CurrentPoint');
    h = gcf;
    close(h);
%     if mean(data) ~= 0
%         data = data - mean(data);
%     end

    
  Selected_feature_type = input('Are features positive or negative? 0-Positive, 1-Negative');
    if Selected_feature_type == 0
        data = data - min(min(data));
    else
        data = data - max(max(data));
    end
  Selected_mesh_switch=input('If you want to rescale the mesh 0-Yes, 1-No: ');
  Selected_mesh_mode=input('What mesh mode you want for mesh in fig1, 1-autumn, 2-copper, 3-hot and 4-default: ');
   
  if Selected_mesh_switch==0
    
  Selected_x_max=input('Please input the x end point you want for the mesh (e.g. 10 for 10 um):');
  Selected_y_max=input('Please input the y end point you want for the mesh (e.g. 10 for 10 um):');
  Selected_Z_range=input('Please input the z dimension you want to crop for the mesh (e.g: [50 500]):');
   
  figure(1)
  mesh(linspace(0,Selected_x_max,512),linspace(0,Selected_y_max,512),spectra)
  xlabel('\mu m')
  ylabel('\mu m')
  zlabel('um')
  
  if Selected_mesh_mode==1;colormap autumn;end
  if Selected_mesh_mode==2;colormap copper;end
  if Selected_mesh_mode==3;colormap hot;end
  if Selected_mesh_mode==4;colormap default;end
  Selected_scale_mode=input('Do you want to change the scale interval? 0-Yes, 1-No: ');
  c=colorbar;
   xlabel('\mu m')
  ylabel('\mu m')
  zlabel('nm')
  zlim(Selected_Z_range)
  title('Before Step Removal')
  c.Label.String = 'Height (nm)';
  
  if Selected_scale_mode==0
  Selected_scale_range=input('Please input the interval you want for the sclar bar(e.g: [50 500]):');
  caxis(Selected_scale_range)
  end
  
  figure(2)
  mesh(linspace(0,Selected_x_max,512),linspace(0,Selected_y_max,512),data)
  xlabel('\mu m')
  ylabel('\mu m')
  zlabel('nm')
  if Selected_mesh_mode==1;colormap autumn; end
  if Selected_mesh_mode==2;colormap copper; end
  if Selected_mesh_mode==3;colormap hot; end
  if Selected_mesh_mode==4;colormap default; end
  
  c=colorbar;
  c.Label.String = 'Height (nm)';
  xlabel('\mu m')
  ylabel('\mu m')
  zlabel('nm')
  zlim(Selected_Z_range)
  title('After Step Removal')
  if Selected_scale_mode==0
  caxis(Selected_scale_range)
  end
  end
  
  if Selected_mesh_switch==1
   
  figure(1)    
  mesh(spectra)
  xlabel('number of pixels')
  ylabel('number of pixels')
  zlabel('nm')
  if Selected_mesh_mode==1;colormap autumn;end
  if Selected_mesh_mode==2;colormap copper;end
  if Selected_mesh_mode==3;colormap hot;end
   
  disp('----------------------------------------------------------------')  
  Selected_scale_mode=input('Do you want to change the scale interval? 0-Yes, 1-No: ');
  c=colorbar;
  title('Before Step Removal')
  c.Label.String = 'Height (nm)';
  
  if Selected_scale_mode==0
  Selected_scale_range=input('Please input the interval you want for the sclar bar  for fig1(e.g: [50 500]):');
  
  caxis(Selected_scale_range)
  end
  
  figure(2)
  mesh(data)
  xlabel('number of pixels')
  ylabel('number of pixels')
  zlabel('nm')
  
  if Selected_mesh_mode==1;colormap autumn;end
  if Selected_mesh_mode==2;colormap copper;end
  if Selected_mesh_mode==3;colormap hot;end
  c=colorbar; 
  c.Label.String = 'Height (nm)';
  title('After Step Removal')
  if Selected_scale_mode==0
  caxis(Selected_scale_range)
  end 
  end
  
% Ask for user evaluation of the flattening process:
   
  Eval_signal=input('Are you happy with the Reduction? 0-Yes, 1-No:');
   
% Save the reduced data once user confirmed:
 
  if Eval_signal==0
      %fileame_new=strtok(fileName,'.xlsx');    
      %filename_new=strcat(fileame_new,'_reduced');

    % Customize the format of files to save, either excel or mat:
      fclose all;
      %save(filename_new,'data');  
      noExt = split(fileName,'.');
      newFile = strcat(char(noExt(1,1)), '_REDUCED.xlsx');
      xlswrite(newFile,data,1,'A1');
  end
    
end