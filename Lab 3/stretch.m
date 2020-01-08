    function y = stretch(a,depth)

% stretch(a,depth) - produces a matrix with identical rows, with depth rows.

global y 

y = zeros(depth,length(a));

for i = 1:depth
    y(i,:) = a;
end