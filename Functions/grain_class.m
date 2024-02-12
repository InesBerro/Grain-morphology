function [props,props_BB]= grain_class(bin,disp,cropped)
%% to extract grain attributes 
bin_clean = (bwareafilt(bin, [2000, 40000]));
bin_clean = imclearborder(bin_clean);
props = regionprops(bin_clean, 'Area','MajorAxisLength',...
    'MinorAxisLength','Centroid','Orientation'); 
stats=struct2table(props);
props_BB=regionprops(bin_clean,'BoundingBox','Centroid');

if disp==1;
   
    for i = 1:height(stats);
        stats.deltaxMajor(i)=stats.MajorAxisLength(i)*cosd(stats.Orientation(i));
        stats.deltayMayor(i)=stats.MajorAxisLength(i)*sind(stats.Orientation(i));
        stats.x1Major(i)=stats.Centroid(i,1)-(stats.deltaxMajor(i)/2);
        stats.x2Major(i)=stats.Centroid(i,1)+(stats.deltaxMajor(i)/2);
        stats.y1Major(i)=stats.Centroid(i,2)-(stats.deltayMayor(i)/2);
        stats.y2Major(i)=stats.Centroid(i,2)+(stats.deltayMayor(i)/2);
                
    end
       % Show results in a grain image
    
    imshow(cropped);
    hold on
    
    for i=1:height(stats);
        text(stats.Centroid(i,1)+10, stats.Centroid(i,2),...
            num2str(stats.MajorAxisLength(i)))
        plot([stats.x2Major(i) stats.x1Major(i)], [stats.y1Major(i) stats.y2Major(i)])
        %rectangle('Position',props_BB(i).BoundingBox,'EdgeColor','r','LineWidth',1);
         
        
    end
    pause(4)
    
else 
end



end
%%