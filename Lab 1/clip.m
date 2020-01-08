function [x,y] = clip(x,y);

% [x,y] = clip(x,y) --- clips the edge from the matrices x and y after
% convolution so that the matching parts are left. This assumes you use
% conv2 with the 'valid' option.

% x will be deeper than y so we have to clip top and bottom
xdiff=(size(x,1)-size(y,1))./2;
% y will be wider than x so we have to clip each side of y
ydiff=(size(y,2)-size(x,2))./2;

x = x(xdiff+1:(size(x,1)-xdiff),:);
y = y(:,ydiff+1:(size(y,2)-ydiff));