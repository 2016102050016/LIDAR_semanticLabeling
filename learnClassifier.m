function [] = learnClassifier()
close all
clear all

% Training Map and Points
figure('Name','Learning Strong Classifier','NumberTitle','off'),
subplot(2,2,1), hold on;
map = buildLabMap();
[roomXY,corrXY,doorXY] = learnPoints();
subplot(2,2,1), hold on; title('Training Map & Points');
plot(roomXY(:,1),roomXY(:,2),'b.'); hold on
plot(corrXY(:,1),corrXY(:,2),'r.'); hold on
plot(doorXY(:,1),doorXY(:,2),'g.'); hold on

examplePoints = [roomXY;corrXY;doorXY];
datafeatures = featureGenerator(examplePoints,map);
dataclass(1:size(roomXY,1)) = -1;
dataclass((size(roomXY,1)+1):size(examplePoints,1)) = 1;

%Use Adaboost to make a classifier
[classestimate,model1]=adaboost('train',datafeatures(:,3:end),dataclass,50);
room = datafeatures(classestimate == -1, 1:2);

datafeatures = datafeatures(classestimate == 1,:);
dataclass = [];
dataclass(1:size(corrXY,1)) = -1;
dataclass((size(corrXY,1)+1):(size(corrXY,1) + size(doorXY,1))) = 1;
[classestimate,model2] = adaboost('train',datafeatures(:,3:end),dataclass,50);
corr = datafeatures(classestimate == -1, 1:2);
door = datafeatures(classestimate == 1, 1:2);

save('model1','model1')
save('model2','model2')

subplot(2,2,2), hold on;
buildLabMap();
subplot(2,2,2), hold on; title('Adaboost Classified Training Points');
plot(room(:,1),room(:,2),'b.'); hold on
plot(corr(:,1),corr(:,2),'r.'); hold on
plot(door(:,1),door(:,2),'g.'); hold on
end