# Grain-morphology
This repository contains all the functions to analyze grain images and extract grain morphology traits in MATLAB software.
The Grain_function folder contains three functions for analyzing panicle images.
•	Grain_Analyzer.m: to execute the entire pipeline.
•	Image_cropped.m: crop the image and keep the panicle part, removing QR-code and scale reference.
•	make_binary.m: to transform the image into a binary matrix (0 and 1).
•	grain_class.m: to extract the grain attributes.

# Inputs 
Functions were written to process grain images that contain a black line that separates the grains and the images information (QR-code and scale reference). All the functions consider the image size proportions. The example image is a 7019 by 5100 pixels size image. Cropped and binary images are 5123 by 5100 pixels.
Grain analyzer asked to indicate the images and functions directories.

# Functions and traits
Custom MATLAB (R2023a) scrips were developed to measure and evaluate image grain morphology properties. A pipeline was created to crop images at the reference line (Image_cropped.m), binarize the images, and remove their background (make_binary.m).
grain traits were obtained in pixels and scaled to metric units.
•	Grain area (cm2) was calculated as the pixel area of the grain expressed in cm2.
•	Grain length (cm) was calculated as the grain major axis length. 
•	Grain width (cm) was calculated as the grain minor axis length. 

# Output
Two CSV files are saved in the working directory: one with grains attributes by grain and other with the number of grains the trait image averages.
Grain_Analyzer.m allows printing a figure with the binary image, the convex hull, and grain length and width colored.
