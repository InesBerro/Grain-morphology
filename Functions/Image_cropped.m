function [ cropped_img ] = img_cropper(img)

% img cropper cuts the original image just above the black line
% img_cropper makes a transitory grayscales img of to find the 
% cutting line.
% The output is in the same format as the input.

    gray = im2double(rgb2gray(img));
    % first makes original image to grayscale and then transform class to
    % double precision
    a=find((mean(gray,2))<0.5);
    %%
    tf1=isempty(a);
        if tf1==0
           cropped_img = img(1:a(1)-100,:,:);  
        else     
            gray2=gray(5000:7000,:);   
            a2=find((mean(gray2,2))<0.82);
            tf2=isempty(a2);
                if  tf2==isempty(a2)
                    cropped_img = img(1:4990,:,:); 
                else
                     cropped_img = img(1:a(1)+4400,:,:);
                end
        end
        %%
 
    %crop the image just above the black line
end
