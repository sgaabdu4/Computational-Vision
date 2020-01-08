function A = myhough(edge_image,threshold,mode);

% A = myhough(edge_image,threshold,mode) --- hough transform, mode is
% 'fast' or 'slow', fast may require too much memory on larger images
% part of computational vision, UoB, as adapted from J Wyatt 2011

% set your angle and step distance
angle_step = 1;
length_step = 1;

% find min and max, depending on input image size
min_length = -(max(size(edge_image)));
max_length = -min_length;

% first of all create a vector that includes possible line angles (in degrees)
phi = 0+angle_step:angle_step:180; % angle of normal to line against x axis

% then lengths of normal to line
w = min_length:length_step:max_length;
w = w - min_length+1;

% phi and w define the Hough space
% our accumulator array for the hough space
A = zeros(length(phi),length(w));

% put the origin in the centre of the image
% note in Lectures, we had origin in top right hand side!
origin = round(size(edge_image)./2);
originY = origin(1);
originX= origin(2);

% find the non-zero points, i.e. find the edges!
% X and Y give index to image where we have a non-zero
[Y,X] = find(edge_image);

% Calculate the sin and cos of each angle
ourcos = cosd(phi);
oursin = sind(phi);
p = phi/angle_step;

% Calculate the distance from each edge point (X, Y) to origin
R=round((Y-originY)*oursin + (X-originX)*ourcos);
Rho = ceil((R-min_length+1)/length_step);

%this code is faster still but requires too much memory for large pictures
if mode=='fast'
    P = stretch(p,size(Rho,1));
    A = accumarray([reshape(P,prod(size(Rho)),1), reshape(Rho,prod(size(Rho)),1)],1,[length(phi) length(w)]);
else
    %this code is slower, but runs on larger images 
    for k=1:size(Rho,1)
        A(sub2ind(size(A),p,Rho(k,:))) = A(sub2ind(size(A),p,Rho(k,:)))+ 1;
    end
end

% this is an older version of the code, a little slower still
% for every x,y coordinate
%for k=1:size(X,1)
%        r=round((Y(k)-originY)*oursin + (X(k)-originX)*ourcos);     
%        rho = ceil((r-min_length+1)/length_step);
%        A(sub2ind(size(A),p,rho)) = A(sub2ind(size(A),p,rho))+ 1;       
%end

h = show_hough(edge_image,A,threshold,originX,originY,angle_step,length_step,min_length);

