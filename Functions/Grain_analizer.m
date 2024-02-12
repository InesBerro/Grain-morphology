% Oat Grain Analizer
%% SET DIRECTORIES 

% Select directory upper level directory where your folders are 
myDir= uigetdir(pwd,'Select the root folder where your images are');
% Select directory where the functions are
myFun=uigetdir(pwd,'Select the folder where your functions are');
% navigate to that directory
cd(myDir)
% make a struct with subfolder names (skip row 1 and 2)
D = dir;
% Set as true you want to see the cropped img + conv hull 
% only recomended for small number of images
disp = false;

%%  
% Multiples folder structure: go 1) Masterlist.
% Single folder: go 2)  

%% 1) CREATES A MASTERLIST

j=0;
for i =1:length(D)
    currD = D(i).name;
    myFiles = dir(fullfile(D(i).name,'*.tif'));
    
    for k=1:length(myFiles);
       j=j+1;
       main(j).path=myFiles(k).folder;
       main(j).name=myFiles(k).name;
    
    end
end
clear currD D i j k myFiles

%% 2) When you don't have multiple directories 
i=0;
for k = 1:length(D)
    i=i+1;
    main(i).path = D(k).folder;
    main(i).name = D(k).name;
    
end
clear  i k D

%%
% To convert table to cell array
main=(table2cell(struct2table(main)));
cd(myFun);
combined = {};
%%
for i=3:length(main); 
   
    Filename = char(main(i,2)); % get image name
    fullFilenane = fullfile(char(main(i,1)),Filename); % get full path
   %[img] = imread(fullFilenane);

    cropped=img_cropper(img); % crop
    bin=make_binary(cropped); % make binary
    main_grain_results(i).filename=char(main(i,2));
    main_grain_results(i).folder=char(main(i,1));
    main_grain_results(i).datetime=char(datetime('now'));
    temp_grain=grain_class(bin,disp,cropped);
    [~,BB]=grain_class(bin,disp,cropped);
    
    
    main_grain_results(i).total_grain_area_px=sum(bin,'all');
   
    main_grain_results(i).total_grain_area_cm2=((sum(bin,'all'))*1.7640e-05);
    main_grain_results(i).avg_grain_area_px=mean([temp_grain.Area]);
    
    
    main_grain_results(i).avg_grain_area_cm2=(mean([temp_grain.Area]))*1.7640e-05;
    main_grain_results(i).avg_grain_lenght_px=mean([temp_grain.MajorAxisLength]);
    main_grain_results(i).avg_grain_lenght_cm=mean([temp_grain.MajorAxisLength])*0.0042;
    main_grain_results(i).avg_grain_width_px=mean([temp_grain.MinorAxisLength]);
    main_grain_results(i).avg_grain_width_cm=mean([temp_grain.MinorAxisLength])*0.0042;
    
    
    %%  Now The full dataset  

    for j=1:length(temp_grain)
        temp_grain(j).image=char(main(i,2));
        temp_grain(j).grain_number=j;
    end    
%%    
if i==1 
     combined=temp_grain;
else 
    combined = vertcat(combined,temp_grain);
end
end


%%
results_by_grain=cell2mat(combined)

clear temp_grain cropped combined img 
writetable(struct2table(main_grain_results),'Grains_ave.csv','Delimiter',',');
writetable(struct2table(results_by_grain),'Grains_By_grain_.csv','Delimiter',',');


