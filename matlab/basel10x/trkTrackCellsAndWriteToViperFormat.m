function trkTrackCellsAndWriteToViperFormat(folder, resultsFolder)


% processPlate: process one plate containing sub-directories
% 
% folder        : is the input folder
% resultsFolder : the output folder where to write the results
% Sample        : a string describing the experiment (or the plate, ex: PLATE3-G4)
% Identifier    : a string Identifier for the experiment
%
% (c) Fethallah Benmansour, fethallah@gmail.com
%
%   Written 4/07/2012


% ------------------- set the paths -----------------------
if isempty( strfind(path, [pwd '/../basel/frangi_filter_version2a']) )
    addpath([pwd '/../basel/frangi_filter_version2a']);
end
if isempty( strfind(path, [pwd '/../basel/code']) )
    addpath([pwd '/../basel/code']);
end
if isempty( strfind(path, [pwd '/../basel/gaimc']) )
    addpath([pwd '/../basel/gaimc']);
end

addpath('~/Downloads/XML/')

addpath('/home/fbenmans/src/neurons/matlab/basel10x/RegionGrowing/');

run('~/Downloads/vlfeat-0.9.14/toolbox/vl_setup');
% addpath('/home/fbenmans/src/WLV/main/');
% addpath('/home/fbenmans/src/WLV/matlab/');
% addpath(genpath('~/Downloads/MatlabFns/'));

% --------- generate list of folders to process -----------
count = 1;
listOfDirs = dir(folder);
for i = 1:length(listOfDirs)
    if listOfDirs(i).isdir && length(listOfDirs(i).name) > 2
        exp_num(count,:) = listOfDirs(i).name; %#ok<*AGROW>
        count  = count + 1;
    end
end

% ------------ process the specified folders --------------
% matlabpool local
for i = 1:size(exp_num,1)
    
%     tic
    folder_n = [folder exp_num(i,:) '/'];
    G = trkTrackCellsAndWriteToViper(folder_n, resultsFolder, exp_num(i,:));
    a = dir([resultsFolder  exp_num(i,:) '.mat']);
%     matFileName = a.name;
%     disp(matFileName);
%     if( exist([resultsFolder matFileName], 'file') > 0)
%         R = load([resultsFolder matFileName]);
%         R = trkPostProcessing(R, G); %#ok
%         save([resultsFolder matFileName], '-struct', 'R');
%     end
    
%     toc
    disp('');
    disp('=============================================================')
    disp('');
end

%matlabpool close



% kill the matlab pool
%matlabpool close force