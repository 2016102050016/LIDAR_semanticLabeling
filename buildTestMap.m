function [ map ] = buildTestMap(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Line extreme points stored as:
%[xa1 ya1 xa2 ya2;
% xb1 yb1 xb2 yb2]; and so on

boundary = [   0    0    0 1160;
               0 1160 1400 1160;
            1400 1160 1400   80;
            1400   80 1200   80;
            1160   80 1040   80;
            1000   80  800   80;
             800   80  800   60;
             800   20  800    0;
             800    0    0    0;];
         
walls =    [   0   80  360   80;
             400   80  800   80;
             800   80  800  410;
             800  380  400  380;
             360  380  240  380;
             200  380    0  380;
             300   80  300  210;
             300  250  300  710;
             800  450  800  960;
             800  480  500  480;
             500  480  500  580;
               0  580  200  580;
             240  580  360  580;
             400  580  800  580;
             300  750  300 1080;
             800 1000  800 1100;
             800 1140  800 1160;
               0 1080  200 1080;
             240 1080  800 1080;
             300  880  380  880;
             420  880 1160  880;
            1200  880 1400  880;];
         
doors =    [ 790   20  810   20;
             790   60  810   60;
             790  410  810  410;
             790  450  810  450;
             790  960  810  960;
             790 1000  810 1000;
             790 1100  810 1100;
             790 1140  810 1140;
             290  210  310  210;
             290  250  310  250;
             290  710  310  710;
             290  750  310  750;
             200  370  200  390;
             240  370  240  390;
             200  570  200  590;
             240  570  240  590;
             200 1070  200 1090;
             240 1070  240 1090;
             360   70  360   90;
             400   70  400   90;
             360  370  360  390;
             400  370  400  390;
             360  570  360  590;
             400  570  400  590;
             380  870  380  890;
             420  870  420  890;
            1160  870 1160  890;
            1200  870 1200  890;
            1160   70 1160   90;
            1200   70 1200   90;
            1040   70 1040   90;
            1000   70 1000   90;];
         
map = [boundary; walls; doors];
map = map + 210;

axis ([0 1800 0 1600]);
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
patch([500 800 800 500]+210,[480 480 580 580]+210,'k');hold on;
end

