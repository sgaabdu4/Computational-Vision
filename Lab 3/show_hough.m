function h = show_hough(edge_image,A,threshold,originX,originY,angle_step,length_step,min_length);

% edge_image = original edge image
% A = Hough Image
% originX,Y = origins of edge_image
% angle step, length step and min_length same as myhough
% part of computational vision, UoB, as adapted from J Wyatt 2011

max_length = -min_length;

% first of all create a vector that includes possible line angles (in degrees)
phi = 0+angle_step:angle_step:180; % angle of normal to line against x axis

% then lengths of normal to line
w = min_length:length_step:max_length;
w = w - min_length+1;

%once we've got A let's threshold it
% This is threshold of number of votes
B = A>threshold;
%i and j are the indices of the phi and w vectors
[p,rho] = find(B);

phi=p*angle_step;
r = rho*length_step + min_length-1;

ourcos = cosd(phi);
oursin = sind(phi);

h=figure();
show_image(edge_image)
hold on

xmin=1-originX;
xmax=size(edge_image,2)-originX;

ymin=1-originY;
ymax=size(edge_image,1)-originY;

% for each line
for i=1:length(phi)

   x1 = xmin;
   y1 = get_y_point(phi(i),r(i),x1,ymin,ymax);%(r(i) - x1*cosd(phi(i)))/sind(phi(i));
   
   if (y1>ymax)
       y1 = ymax;
       x1 = (r(i)-y1*sind(phi(i)))/cosd(phi(i));
   elseif (y1<ymin)
       y1 = ymin;
       x1 = (r(i)-y1*sind(phi(i)))/cosd(phi(i));
   end
   
   x2 = xmax;
   y2 = get_y_point(phi(i),r(i),x2,ymin,ymax);%(r(i) - x2*cosd(phi(i)))/sind(phi(i));   
      
   if (y2>ymax)
       y2 = ymax;
       x2 = (r(i)-y2*sind(phi(i)))/cosd(phi(i));
   elseif (y2<ymin)
       y2 = ymin;
       x2 = (r(i)-y2*sind(phi(i)))/cosd(phi(i));
   end 

   line(originX+[x1 x2]',originY+[y1 y2]');

end


function x = get_x_point(phi,r,y,xmin,xmax);

if cosd(phi) == 0 
    x = r-y*sind(phi);
    if x <  0 
        x =xmin-1;
    else
        x = xmax+1;
    end
else
    x=(r-y*sind(phi))/cosd(phi);
end


function y = get_y_point(phi,r,x,ymin,ymax);

if sind(phi) == 0 
    y = r-x*cosd(phi);
    if y < 0 
        y = ymin-1;
    else
        y = ymax+1;
    end
else
    y=(r-x*cosd(phi))/sind(phi);
end

