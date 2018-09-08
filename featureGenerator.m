function [datafeatures] = featureGenerator(examplePoints,map)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

Nf = 10; %No. of features used
datafeatures = zeros(size(examplePoints,1),Nf);
for i = 1:size(examplePoints,1)
    phiR  = scanGenerator(examplePoints(i,1),examplePoints(i,2),map);
    Nb = size(phiR,1); %No. of laser beams
    
    %Coordinates of point (Not features)
    datafeatures(i,1) = examplePoints(i,1);
    datafeatures(i,2) = examplePoints(i,2);
    %%
    %Simple Features Extracted from Laser Beams
    
    %Average difference between the length of two consecutive beams
    temp = 0;
    for j = 1:(Nb - 1)
       temp = temp + abs(phiR(j,2) - phiR(j+1,2)); 
    end
    temp = temp + abs(phiR(Nb,2) - phiR(1,2));
    datafeatures(i,3) = temp/Nb;
    
    %Standard deviation of the difference between the length of consecutive beams
    temp1 = datafeatures(i,3);
    temp = 0;
    for j = 1:(Nb - 1)
       temp = temp + (abs(phiR(j,2) - phiR(j+1,2)) - temp1)^2; 
    end
    temp = temp + (abs(phiR(Nb,2) - phiR(1,2)) - temp1)^2; 
    datafeatures(i,4) = (temp/(Nb - 1))^0.5;
    
    %Average beam length
    temp = 0;
    for j = 1:Nb
       temp = temp + phiR(j,2); 
    end
    datafeatures(i,5) = temp/Nb;
    
    %Standard Deviation of the Beam Length
    temp1 = datafeatures(i,5);
    temp = 0;
    for j = 1:Nb
       temp = temp + (phiR(j,2) - temp1)^2; 
    end
    datafeatures(i,6) = (temp/(Nb - 1))^0.5;
    
    %Average Difference Between the Length of Consecutive Beams
    %Considering Max-Range
    temp = 0;
    for j = 1:(Nb - 1)
        d1 = phiR(j,2);
        d2 = phiR(j+1,2);
        thresh = 300;
        if d1 > thresh
            d1 = thresh;
        end
        if d2 > thresh
            d2 = thresh;
        end
        temp = temp + abs(d1 - d2); 
    end
    d1 = phiR(Nb,2);
    d2 = phiR(1,2);
    thresh = 300;
    if d1 > thresh
        d1 = thresh;
    end
    if d2 > thresh
        d2 = thresh;
    end
    temp = temp + abs(d1 - d2); 
    datafeatures(i,7) = temp/Nb;
    
    %Standard Deviation of the Difference Between the Length of
    %Two Consecutive Beams Considering Max-Range
    temp1 = datafeatures(i,7);
    temp = 0;
    for j = 1:(Nb - 1)
        d1 = phiR(j,2);
        d2 = phiR(j+1,2);
        thresh = 300;
        if d1 > thresh
            d1 = thresh;
        end
        if d2 > thresh
            d2 = thresh;
        end
        temp = temp + (abs(d1 - d2) - temp1)^2; 
    end
    d1 = phiR(Nb,2);
    d2 = phiR(1,2);
    thresh = 300;
    if d1 > thresh
        d1 = thresh;
    end
    if d2 > thresh
        d2 = thresh;
    end
    temp = temp + (abs(d1 - d2) - temp1)^2; 
    datafeatures(i,8) =( temp/(Nb - 1))^0.5;
    
    %Number of Gaps
    temp = 0;
    thresh = 150;
    for j = 1:(Nb - 1)
       g = 0;
       if abs(phiR(j,2) - phiR(j+1,2)) > thresh
          g = 1; 
       end
       temp = temp + g; 
    end
    if abs(phiR(Nb,2) - phiR(1,2)) > thresh
        temp = temp + 1;
    end
    datafeatures(i,9) = temp;
    
    %Euclidean Distance Between the Two Points Corresponding to
    %Two Consecutive Global Minima
    min1 = 99999;
    min2 = 99999;
    for j = 1:Nb
        if phiR(j,2) < min1
           min1 = phiR(j,2);
           min1j = j;
        end
    end
    for j = 1:Nb
        if ((phiR(j,2) < min2) && (j ~= min1j))
           min2 = phiR(j,2);
           min2j = j;
        end
    end
    p1x = examplePoints(i,1) + phiR(min1j,2)*cosd(phiR(min1j,1));
    p1y = examplePoints(i,2) + phiR(min1j,2)*sind(phiR(min1j,1));
    p2x = examplePoints(i,1) + phiR(min2j,2)*cosd(phiR(min2j,1));
    p2y = examplePoints(i,2) + phiR(min2j,2)*sind(phiR(min2j,1));
    datafeatures(i,10) = ((p1x - p2x)^2 + (p1y - p2y)^2)^0.5;
    
    %Angular Distance Between the Two Points Corresponding
    %to Two Consecutive Global Minima
    datafeatures(i,11) = abs(phiR(min1j,1) - phiR(min2j,1));
    
    %Average of the Relation Between Two Consecutive Beams
    temp = 0;
    for j = 1:(Nb - 1)
       temp = temp + abs(phiR(j,2)/phiR(j+1,2)); 
    end
    temp = temp + abs(phiR(Nb,2)/phiR(1,2));
    datafeatures(i,12) = temp/Nb;
    
    %Standard Deviation of the Relation Between the Length of Two
    %Consecutive Beams
    temp1 = datafeatures(i,12);
    temp = 0;
    for j = 1:(Nb - 1)
       temp = temp + (abs(phiR(j,2)/phiR(j+1,2)) - temp1)^2; 
    end
    temp = temp + (abs(phiR(Nb,2)/phiR(1,2)) - temp1)^2; 
    datafeatures(i,13) = (temp/(Nb - 1))^0.5;
    
    %Average of Normalized Beam Length
    dmax = -1;    
    for j = 1:Nb
        if phiR(j,2) > dmax
           dmax = phiR(j,2);
        end
    end
    temp = 0;
    for j = 1:Nb
       temp = temp + (phiR(j,2)/dmax); 
    end
    datafeatures(i,14) = temp/Nb;
    
    %Standard Deviation of Normalized Beam Length
    temp1 = datafeatures(i,14);
    temp = 0;
    for j = 1:Nb
       temp = temp + ((phiR(j,2)/dmax) - temp1)^2; 
    end
    datafeatures(i,15) = (temp/(Nb - 1))^0.5;
    
    %Number of Relative Gaps
    temp = 0;
    thresh = 3;
    for j = 1:(Nb - 1)
       g = 0;
       if abs(phiR(j,2)/phiR(j+1,2)) > thresh
          g = 1; 
       end
       temp = temp + g; 
    end
    if abs(phiR(Nb,2)/phiR(1,2)) > thresh
        temp = temp + 1;
    end
    datafeatures(i,16) = temp;
    
    %Kurtosis
    dbar = datafeatures(i,5);
    dsd = datafeatures(i,6);
    temp = 0;
    for j = 1:Nb
       temp = temp + (phiR(j,2) - dbar)^4; 
    end
    datafeatures(i,17) = (temp/(Nb*(dsd)^4)) - 3;
    
    %%
    %Simple Features Extracted from a Polygon Approximation
    V = zeros(Nb + 1,2); %V are vertices of Polygon P 
    for j = 1:Nb
       V(j,1) = examplePoints(i,1) + phiR(j,2)*cosd(phiR(j,1));
       V(j,2) = examplePoints(i,2) + phiR(j,2)*sind(phiR(j,1));
    end
    V(Nb + 1,1) = V(1,1);
    V(Nb + 1,2) = V(1,2);
    
    %Area of P
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( V(j,1)*V(j+1,2) + V(j+1,1)*V(j,2) );
    end
    datafeatures(i,18) = temp/2;
    
    %Perimeter of P
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( (V(j,1) - V(j+1,1))^2 + (V(j,2) - V(j+1,2))^2 )^0.5;
    end
    datafeatures(i,19) = temp;
    
    %Mean Distance Between the Centroid and the Shape Boundary
    area = datafeatures(i,18);
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( V(j,1) + V(j+1,1) )*( V(j,1)*V(j+1,2) - V(j+1,1)*V(j,2) );
    end
    cx = (1/(6*area))*temp;
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( V(j,2) + V(j+1,2) )*( V(j,1)*V(j+1,2) - V(j+1,1)*V(j,2) );
    end
    cy = (1/(6*area))*temp;
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( (V(j,1) - cx)^2 + (V(j,2) - cy)^2 )^0.5;
    end
    datafeatures(i,20) = temp/Nb;
    
    %Standard Deviation of the Distances Between the Centroid and
    %the Shape Boundary
    temp1 = datafeatures(i,20);
    temp = 0;
    for j = 1:Nb
        temp  = temp + ( ( (V(j,1) - cx)^2 + (V(j,2) - cy)^2 )^0.5 - temp1 );
    end
    datafeatures(i,21) = temp/Nb;
    
    %Form Factor of P
    peri = datafeatures(i,19);
    datafeatures(i,22) = 4*3.14*area/((peri)^0.5);
    
    %Circularity of P
    datafeatures(i,23) = (peri^2)/area;
    
    %Normalized Circularity of P
    datafeatures(i,24) = 4*3.14*area/((peri)^2);
    
    %Average Normalized Distance Between the Centroid and the
    %Shape Boundary
    temp = 0;
    dmax = -1;
    for j = 1:Nb
        if ((((V(j,1) - cx)^2 + (V(j,2) - cy)^2)^0.5)) > dmax
           dmax = ((((V(j,1) - cx)^2 + (V(j,2) - cy)^2)^0.5));
        end
    end
    for j = 1:Nb
        temp  = temp + ((((V(j,1) - cx)^2 + (V(j,2) - cy)^2)^0.5))/dmax;
    end
    datafeatures(i,25) = temp/Nb;
    
    %Standard Deviation of the Normalized Distances Between the
    %Centroid and the Shape Boundary
    temp1 = datafeatures(i,25);
    temp = 0;
    for j = 1:Nb
        temp  = temp + ((((((V(j,1) - cx)^2 + (V(j,2) - cy)^2)^0.5))/dmax) - temp1)^2;
    end
    datafeatures(i,26) = (temp/Nb)^0.5;
    
    %Invariant Moments of P
    [mu11,eta11] = centralMoment(1,1,V);
    [mu20,eta20] = centralMoment(2,0,V);
    [mu02,eta02] = centralMoment(0,2,V);
    [~,eta30] = centralMoment(3,0,V);
    [~,eta03] = centralMoment(0,3,V);
    [~,eta21] = centralMoment(2,1,V);
    [~,eta12] = centralMoment(1,2,V);
    
    %Seven invariant moments with respect translation, rotation and scale
    datafeatures(i,27) = eta20 + eta02;
    datafeatures(i,28) = (eta20 - eta02)^2 + 4*(eta11^2);
    datafeatures(i,29) = (eta30 - 3*eta12)^2 + (3*eta21 - eta03)^2;
    datafeatures(i,30) = (eta30 + eta12)^2 + (eta21 + eta03)^2;
    datafeatures(i,31) = (eta30 - 3*eta12)*(eta30 + eta12)*((eta30 + eta12)^2 - 3*(eta21 + eta03)^2) + (3*eta21 - eta03)*(eta21 + eta03)*(3*(eta30 - eta12)^2 - (eta21 + eta03)^2);
    datafeatures(i,32) = (eta20 - eta02)*((eta30 + eta12)^2 - (eta21 + eta03)^2) + 4*eta11*(eta30 + eta12)*(eta21 + eta03);
    datafeatures(i,33) = (3*eta21 - eta03)*(eta30 - eta12)*((eta30 - eta12)^2 - 3*(eta21 + eta03)^2) + (3*eta12 - eta30)*(eta21 + eta03)*(3*(eta30 + eta12)^2 - (eta21 + eta03)^2);
 
    %Normalized Feature of Compactness of P
    datafeatures(i,34) = area/(mu20 + mu02);
    
    %Normalized Feature of Eccentricity of P
    datafeatures(i,34) = (((mu20 + mu02)^2 + 4*mu11^2)^0.5)/(mu20 + mu02);   
end
end
%%
function [muIJ,etaIJ] = centralMoment(i,j,V)
Nb = size(V,1) - 1;
xbar = mean(V(1:end-1,1));
ybar = mean(V(1:end-1,2));
temp = 0;
for m = 1:Nb
   for n = 1:Nb
      temp = temp + ( (V(m,1) - xbar)^i )*( (V(n,2) - ybar)^j ); 
   end
end
muIJ = temp;
gamma = ((i + j)/2) + 1;
etaIJ = muIJ/(Nb^(2*gamma));
end