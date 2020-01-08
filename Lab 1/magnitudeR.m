% function m = magnitude(x,y)
% m = sqrt(x.^2 + y.^2);
% end

function r = magnitude(Rx,Ry)
r = sqrt(Rx.^2 + Ry.^2);

% shakey = read_image('','shakey.150.gif');
% load sobel
% x = convn(shakey, sobelX, 'same');
% y = convn(shakey, sobelY, 'same');
% m = magnitude(x,y);
% show_image(m)
% show_image(m>40)