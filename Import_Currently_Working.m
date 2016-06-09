%{
A  = '350 2014    1   1   0   0.0    40.39'
header1 = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
fid=fopen('MyFile.txt','w');
fprintf(fid, [ header1 '\n']);
fprintf(fid, [ A '\n']);
fclose(fid);
STN YEAR  MON  DAY  HR  MIN  O3(PPB)
350 2014    1   1   0   0.0    40.39
%}
%{
Things you MIGHT need to do before using:

You MUST change directories to the one that has your text file in it.
%{
run

>> cd C:\Users\xxx\Documents\MATLAB

where everything after "cd " is the path to your FOLDER with all the files
inside of it. This is absolutely necissary
%}

Turn off a specific warning (like 'variable names were modified...')
%{
to turn ofh the header that says "variable names were modified to make them valid matlab identifiers"
just run the command that issues a warning, then directly after run

tableData=readtable('BAO_OZ3_2014001.dat'); %Don't use this if you have a different error
[a, MSGID] = lastwarn();
warning('off', MSGID)

You can then delete MSGID and a. Be warned, I don't know how
to turn the warning back on (although it's proably pretty simple) so
if you need those in the future, I wouldn't do this.

This also works for any other warnings
%}
%}

clear all
clc
tic
startNum = 1;
endNum = 52;
disp(['Start: ' num2str(startNum)])
disp(['End: ' num2str(endNum)])
% header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)'; %DO NOT DELETE PLEASE
%incr2 = 1;

%tableData=readtable(titleText);
for startNum = startNum:endNum
    if startNum ~= 40
        if numel(num2str(startNum)) == 1;
            textNumberHold = num2str(startNum);
            textIncrString = ['00' textNumberHold];
        end
        if numel(num2str(startNum)) == 2;
            textNumberHold = num2str(startNum);
            textIncrString = ['0' textNumberHold];
        end
        if numel(num2str(startNum)) == 3;
            textIncrString = num2str(startNum);
        end
        
        titleText = ['BAO_OZ3_2014' textIncrString '.dat'];
        if exist(titleText,'file') == 2
            % fileIsReal=1; %DO NOT DELETE PLEASE
            % structData = rmfield(importdata(titleText),'rowheaders'); %unnecisary           

            tableData=readtable(titleText);
            tableData.Properties.VariableNames = {'date' 'two' 'ozone' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten'};
            [a, MSGID] = lastwarn();
            %disp(['FILE ' num2str(startNum) '.dat IMPORTED'])
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %{
numData = tableData.ozone;
textData = tableData.date;

x=1
numData=cell2table(numData);
for x = 1:height(numData)
%     findNan = strfind(char(numData.numData(x)),'NAN')
%     findNeg = strfind(char(numData.numData(x)),'-')
%     if findNan ~= 1
%
    findNan=char(numData.numData(x,1));
    
    if ((findNan(1) ~= 'N' ) && (findNan(1) ~= '-')) == 1
        numDataClean(x,1)=str2num(char(numData.numData(x,1)));
    else
        numDataClean(x)=NaN;
        warning(['invalid @ ' num2str(x) ' (+1 for .dat)']);
    end
end
            
            %
            numDataClean=numData(1:length(numData),2)+.0001;
            textData=textData(1:length(textData));
            
            %}
            
            numData = tableData.ozone;
            textData = tableData.date;
            x=1;
            if iscell(numData)== 1;
                
                numData=cell2table(numData);
                numDataClean = zeros(height(numData),1);
                
                for x = 1:height(numData)
                    findNan=char(numData.numData(x,1));
                    
                    if ((findNan(1) ~= 'N' ) && (findNan(1) ~= '-')) == 1
                        numDataClean(x,1)=str2num(char(numData.numData(x,1)));
                    else
                        numDataClean(x,1)=NaN;
                        %warning(['FILE ' textIncrString ' at ' num2str(x)]);
                        %warning(['invalid @ ' num2str(x) ' (+1 for .dat)']);
                    end
                end
            else
                numDataClean=numData;
                for x = 1:length(numData)
                    if ((isnan(numData(x,1)) ~= 1) && (sign(numData(x,1)) ~= -1)) == 1
                        
                    else
                        numDataClean(x,1)=NaN;
                        
                        %warning(['FILE ' textIncrString ' at ' num2str(x)]);
                        % warning(['invalid @ ' num2str(x) ' (+1 for .dat)']);
                    end
                end
            end
            numDataClean=numDataClean+.0001;
            
            disp(['FILE ' num2str(startNum) '.dat SUCCESSFUL'])
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %{
            avgSet=1;
            count=1;
            incr3=2;
            
            oneMinFullSet=cell(((length(textData))/2+1))
            if avgSet==1
                for count=1:(length(textData))
                    if count == 1
                        oneMinNumLine=num2str(numDataClean(1));
                        %oneMinNumLine=num2str(oneMinNumLine);
                        oneMinNumLine=oneMinNumLine(1:5);
                        oneMinDateLine= char(textData(1));
                        textLine = (['350 ' oneMinDateLine(1:4) '   ' oneMinDateLine(6:7) '  ' oneMinDateLine(9:10) '  ' oneMinDateLine(12:13) '  ' oneMinDateLine(15:16) '.0    ' oneMinNumLine]);
                        oneMinFullSet(1,1)=cellstr(textLine);
                    else
                        oneMinNumLine=mean(numDataClean(incr3:incr3+1));
                        oneMinNumLine=num2str(oneMinNumLine);
                        oneMinNumLine=oneMinNumLine(1:5);
                        oneMinDateLine = char(textData(incr3+1));
                        textLine = (['350 ' oneMinDateLine(1:4) '   ' oneMinDateLine(6:7) '  ' oneMinDateLine(9:10) '  ' oneMinDateLine(12:13) '  ' oneMinDateLine(15:16) '.0    ' oneMinNumLine]);
                        incr3=incr3+2;
                        oneMinFullSet(count,1)=cellstr(textLine);
                        if (length(textData) <= (incr3)) ==1 %For the record, I have no idea how this works or
                            %why it works so well, but it does so just keep
                            %it here and don't touch it. thx
                            break
                        end
                    end
                end
            end
            %}
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %{
            A  = '350 2014    1   1   0   0.0    40.39'
            header1 = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
            fid=fopen('MyFile.txt','w');
            fprintf(fid, [ header1 '\n']);
            fprintf(fid, [ A '\n']);
            fclose(fid);
            STN YEAR  MON  DAY  HR  MIN  O3(PPB)
            350 2014    1   1   0   0.0    40.39
            %}
        else
            warning(['FILE ' titleText ' DOES NOT EXIST'])
            fileIsReal=0;
        end
    else
       % disp(['FILE ' num2str(startNum) '.dat DOES NOT EXIST']);
    end
end
clear structData

% clear avgSet count endNum fileIsReal header incr3 oneMinDateLine oneMinNumLine startnum textIncrString textLine titleText
% clear startNum y.qyBgmx.pDrne

time=toc;
disp([ num2str(time) ' seconds total']);
disp([ (num2str(endNum/time)) ' seconds average per file.']);

%{
if avgset==1
    for count = 1:1 %length(textdata);
        a=num2str(numdataClean(count));
        a=a(1:5);
        OneMinDateLine = char(textdata(count));
        textline = (['350 ' OneMinDateLine(1:4) '   ' OneMinDateLine(6:7) '  ' OneMinDateLine(9:10) '  ' OneMinDateLine(12:13) '  ' OneMinDateLine(15:16) '.0    ' a]);
    end
end
%}