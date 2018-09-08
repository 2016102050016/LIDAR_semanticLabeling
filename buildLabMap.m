function [ map ] = buildLabMap(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Line extreme points stored as:
%[xa1 ya1 xa2 ya2;
% xb1 yb1 xb2 yb2]; and so on

boundary = [   0    0    0  580;
               0  580 1000  580;
            1000  580 1000    0;
            1000    0  600    0;
             600    0  600 -100;
             600 -100  400 -100;
             400 -100  400    0;
             400    0    0    0;];
         
walls =    [   0  250  180  250;
             220  250  400  250;
             400  250  400    0;
             400  250  440  250;
             480  250  800  250;
             800  250  800    0;
             800  250  800  270;
             800  310  800  330;
             800  330  800  580;
             800  330  620  330;
             580  330  400  330;
             400  330  400  580;
             400  330  220  330;
             180  330    0  330;
             800  330  880  330;
             920  330 1000  330;];
         
doors =    [ 180  240  180  260;
             220  240  220  260;
             180  320  180  340;
             220  320  220  340;
             440  240  440  260;
             480  240  480  260;
             620  320  620  340;
             580  320  580  340;
             790  270  810  270;
             790  310  810  310;
             880  340  880  320;
             920  340  920  320;];
         
map = [boundary; walls; doors];
map = map + 200;

axis ([0 1400 0 900]);
N = size(map,1);
n = 1;
while (n < N+1)
   x1 = map(n,1);
   x2 = map(n,3);
   x_line = [x1 x2];
   
   y1 = map(n,2);
   y2 = map(n,4);
   y_line = [y1 y2];
   
   L = line(x_line,y_line);
   set(L,'lineWidth',1,'Color','black');
   hold on;
   
   n = n+1;
end     

end

