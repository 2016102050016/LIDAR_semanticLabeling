function [ roomXY,corrXY,doorXY ] = learnPoints(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

roomXY = [250 550;
          300 700;
          550 720;
          500 600;
          400 650;];
roomXY = [roomXY;
         [780 600;
          800 750;
          900 650;]];
roomXY = [roomXY;
         [1050 720;
          1150 600;]];
roomXY = [roomXY;
         [1050 500;
          1150 500;
          1100 300;]];
roomXY = [roomXY;
         [650 400;
          780 220;
          850 300;
          780 150;]];
roomXY = [roomXY;
         [400 410;
          370 410;
          400 300;]];
      
corrXY = [220 500;
          350 460;
          380 490;
          400 500;
          550 490;
          640 490;
          750 470;
          920 490;
          980 510;
          850 490;];
      
doorXY = [400 530;
          390 448;
          410 451;
          800 540;
          650 450;
          670 450;
         1000 500;
         1000 480;
         1100 534;
         1100 526;];

end

