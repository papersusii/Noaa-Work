
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
endNum = 401;


startNumForCalc=startNum;
%avgSet=1;
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
			tableData=readtable(titleText);
			tableData.Properties.VariableNames = {'date' 'two' 'ozone' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten'};
			
			numData = tableData.ozone;
			textData = tableData.date;
			%x=1;
			if iscell(numData)== 1;
				
				numData=cell2table(numData);
				numDataClean = zeros(height(numData),1);
				
				for x = 1:height(numData)
					findNan=char(numData.numData(x,1));
					
					if ((findNan(1) ~= 'N' ) && (findNan(1) ~= '-')) == 1
						%numDataClean(x,1)=str2num(char(numData.numData(x,1)));
						numDataClean(x,1)=str2double(char(numData.numData(x,1)));
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
			numDataClean=numDataClean+.0001; %might me unnecisary but idk so im leaving it
			numDataClean(numDataClean>200)=NaN;
			numDataClean(numDataClean<1)=NaN;
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			
			%disp(['FILE ' num2str(startNum) '.dat SUCCESSFUL'])
			clear numDataOdd numData Even numDataHold x
			numDataOdd=numDataClean(1:2:end,1);
			numDataEven=numDataClean(2:2:end,1);
			%x=1;
			%try
			if length(numDataOdd) > length(numDataEven) == 1
				numDataEven(length(numDataOdd),1)=NaN;
			else
				numDataOdd(length(numDataEven),1)=NaN;
			end
			
			numDAvgOneMin=zeros([length(numDataOdd),1]);
			for x=1:length(numDataOdd)
				%	if (((x == 1) == 1) || ((x==2) ==1)) ~= 1 %why do I have this?
				numDataHold(1)=numDataOdd(x);
				numDataHold(2)=numDataEven(x);
				if ((isnan(numDataHold(1)) == 1) && (isnan(numDataHold(2)) == 1)) == 1
					numDAvgOneMin(x)=NaN;
				elseif xor(isnan(numDataHold(1)),isnan(numDataHold(2))) == 1
					if isnan(numDataHold(1)) == 0
						numDAvgOneMin(x)=numDataHold(1);
					else
						numDAvgOneMin(x)=numDataHold(2);
					end
				else
					numDAvgOneMin(x)=(sum(numDataHold(~isnan(numDataHold)))/2);
				end
			end
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			
			%oneMinFullSet=cell(length(numDAvgOneMin),1);
			textDataEven=textData(2:2:end,1);
			
			for count=1:length(numDAvgOneMin+1)
				if count==1;
					fid=fopen(['MyFile_'  num2str(startNum) '.txt'],'w');
					header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
					fprintf(fid, [ header '\n']);
					
				else
					numDataText=num2str(numDAvgOneMin(count-1));
					textDatLine=char(textDataEven(count-1));
					%numDataText=num2str(numDataText);
					if numel(numDataText) == 8 %100
						numDataText=numDataText(1:6);
						
						textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0   ' numDataText]);
						fprintf(fid, [ textLine '\n']);
						
					elseif numel(numDataText) == 7 %10
						numDataText=numDataText(1:5);
						textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0    ' numDataText]);
						fprintf(fid, [ textLine '\n']);
						
					elseif 	numel(numDataText) == 6 %1
						numDataText=numDataText(1:4);
						textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0     ' numDataText]);
						fprintf(fid, [ textLine '\n']);
						
					else
						warning(['Inputing NaN for line ' num2str(count)]);
						textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0      NaN']);
						fprintf(fid, [ textLine '\n']);
					end
					
				end
			end
			disp(['MyFile_'  num2str(startNum) '.txt SUCCESSFUL']);
			fclose(fid);
			
		else
			warning([ titleText  ' DOES NOT EXIST'])
			%fileIsReal=0;
		end
	else
		% disp(['FILE ' num2str(startNum) '.dat DOES NOT EXIST']);
	end
end


time=toc;
disp('----------------------------');

if time < 60
disp([ num2str(time) ' seconds elapsed']);
else
disp([num2str(time/60) ' minutes elapsed']);
end

if endNum-startNumForCalc ~= 0
	disp([ num2str((abs((time/(endNum-startNumForCalc))))) ' seconds/file']);

else
	disp([ num2str(time) ' seconds/file']);
end


fclose all;

clear structData

clear tableData  numDataOdd numDataHold numDataEven numDataClean
clear avgSet count endNum fileIsReal header incr3 oneMinDateLine oneMinNumLine startnum textIncrString textLine titleText
clear startNum y.qyBgmx.pDrne
clear time startNumForCalc numData textNumberHold x findNan
clear fid numDataText numDAvgOneMin oneMinFullSet textData textDataEven textDatLine time

