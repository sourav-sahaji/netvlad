setup;

% ---------- Use/test our networks

% Load our network
netID= 'vd16_pitts30k_conv5_3_vlad_preL2_intra_white';
paths= localPaths();
load( sprintf('%s%s.mat', paths.ourCNNs, netID), 'net' );
net= relja_simplenn_tidy(net);

%%%% Chane 1, 2, 3, 4 before running any code --- or generalize the code


%%%%%% 1 %%%%%%
% dataPath = '../../current/data/oxford/2014-12-09-13-21-02/stereo/left_rect/';
dataPath = '../../current/data/oxford/2015-02-03-08-45-10/stereo/left_rect/';

%%%%%% 2 %%%%%%
% fileId = fopen('../../current/data/oxford/2014-12-09-13-21-02/s-sampledImageNames.txt');
fileId = fopen('../../current/data/oxford/2015-02-03-08-45-10/s-sampledImageNames.txt');

fileNames = textscan(fileId,'%s');
fileNames = fileNames{1,1};

dataSize = length(fileNames);
allFeats = zeros(dataSize,4096);
for i = 1:dataSize
    im = imread(strcat(dataPath,fileNames{i,1}));
    %%%%%% 3 %%%%%%
    im = im(1:799,:,:);
    feat = computeRepresentation(net, im,'useGPU',false);
    allFeats(i,:) = feat';
    i
end
%%%%%% 4 %%%%%%
dlmwrite('./output/outFileWinter.txt',allFeats,'delimiter',' ');
