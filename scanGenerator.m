function [ scan ] = scanGenerator( x_bot,y_bot,map )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

R_max = 1000;
phi = 0;
del_phi = 30;

R = R_max*ones( (360/del_phi) ,1 );
index = 1;
while(phi < 360)
   x_max = x_bot + R_max*cosd(phi);
   y_max = y_bot + R_max*sind(phi);
   
   laserX = [x_bot x_max+0.001*randi(10,1)];
   laserY = [y_bot y_max+0.001*randi(10,1)];
   
   lineNum = 1;
   while (lineNum < (size(map,1) + 1))
       lineX = [map(lineNum,1)+0.001*randi(10,1) map(lineNum,3)];
       lineY = [map(lineNum,2)+0.001*randi(10,1) map(lineNum,4)];
       
       [intersect, r] = laserIntersect(lineX,lineY,laserX,laserY);
       if (intersect)
          if (r < R(index)) 
              R(index) = r;
          end
       end       
       lineNum = lineNum + 1;
   end  
   
   %Visualization
   x_scan = x_bot + R(index)*cosd(phi);
   y_scan = y_bot + R(index)*sind(phi);
   drawX = [x_bot x_scan];
   drawY = [y_bot y_scan];
   beam = line(drawX,drawY);
   set(beam,'lineWidth',0.5,'Color','yellow');
   hold on;
   %pause(0.000001)
   
   phi = phi + del_phi; 
   index = index + 1;
end

%plot(x_bot,y_bot,'b.','MarkerSize',20);

%Generated scan in [angle range] format
PHI = 0:del_phi:(360 - del_phi);
scan = [PHI' R];

end

function [intersect, r] = laserIntersect(lineX,lineY,laserX,laserY)

%fit linear polynomial
p_line = polyfit(lineX,lineY,1);
p_laser = polyfit(laserX,laserY,1);
%calculate intersection
x_intersect = fzero(@(x) polyval(p_line-p_laser,x),3);
y_intersect = polyval(p_line,x_intersect);

r = ((x_intersect - laserX(1))^2 + (y_intersect - laserY(1))^2)^0.5;

if (x_intersect >= min(lineX) && x_intersect <= max(lineX) && y_intersect >= min(lineY) && y_intersect <= max(lineY))
    if (x_intersect >= min(laserX) && x_intersect <= max(laserX) && y_intersect >= min(laserY) && y_intersect <= max(laserY))
       intersect = 1;       
    else
        intersect = 0;
    end
else
    intersect = 0;
end

end