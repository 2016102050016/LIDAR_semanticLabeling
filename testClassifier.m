function [  ] = testClassifier(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

close all
% Training Map and Points
figure('Name','New Map: Classification Results','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]),
subplot(1,2,1), hold on;
map = buildTestMap();

load('model1.mat')
load('model2.mat')
path = pathPoints();

for i = 1:size(path,1)
    % Test data
    testdata = featureGenerator(path(i,:),map);

    % Classify the testdata with the trained model
    testclass = adaboost('apply',testdata(:,3:end),model1);
    room = testdata(testclass == -1,:);

    testdata = testdata(testclass == 1,:);
    testclass = adaboost('apply',testdata(:,3:end),model2);
    corr = testdata(testclass == -1,:);
    door = testdata(testclass == 1,:);

    % Show result
    subplot(1,2,2), hold on;
    buildTestMap();
    subplot(1,2,2), hold on; title('Classification');
    plot(room(:,1),room(:,2),'b.','MarkerSize',20); hold on
    plot(corr(:,1),corr(:,2),'r.','MarkerSize',20); hold on
    plot(door(:,1),door(:,2),'g.','MarkerSize',20); hold on
    pause(0.00000001)
end
end

