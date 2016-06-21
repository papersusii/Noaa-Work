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
run the code below where cd D:\xxxx is the path to a file similar to the
ones that were causing the warnings. readtable('xxx') where xxx is the full
filename of the file. copy and paste into command window and hit enter.

cd C:\Users\Ian\Documents\MATLAB
tableData=readtable('bao_o3_300m_min_01_2014.dat'); %Don't use this if you have a different error
[a, MSGID] = lastwarn();
warning('off', MSGID)
clear tableData a MSGID

Be warned, I don't know how
to turn the warning back on (although it's proably pretty simple) so
if you need those in the future, I wouldn't do this.
This also works for any other warnings
%}
%}
clc
tic
startNum = 1;
endNum = 1;
startNumForCalc=startNum;
disp(['Start: ' num2str(startNum)])
disp(['End: ' num2str(endNum)])
for startNum = startNum:endNum
	if startNum ~= 40 %idk why but something was wrong with file 40 so
		if numel(num2str(startNum)) == 1;
			titleText = ['BAO_OZ3_201400' num2str(startNum) '.dat'];
		end
		if numel(num2str(startNum)) == 2;
			titleText = ['BAO_OZ3_20140' num2str(startNum) '.dat'];
		end
		if numel(num2str(startNum)) == 3;
			titleText = ['BAO_OZ3_2014' num2str(startNum) '.dat'];
		end
		%disp(['Analyzing file ' titleText ' for import...']); %this adds to the authenticity a little bit
		for count=1:4  %If for some reason you wan the program to take longer than it needs to, simply put a different number in for '4'.
			%pause(rand); %pauses for a random interval between 0 and 1 second. It looks more realistic, because the dots will appear at different intervals and it looks like the computer is thinking about something
			%pause(.25);  %this will display a '...' every quarter second. Looks okay and you can calculate just how much time the loop will take
			%disp('...'); %you have to uncomment this for it to work
		end

		cd C:\Users\Ian\Documents\MATLAB\DATA_RAW %file path to where the raw data is
		if exist(titleText,'file') == 2
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Imports Data and Cleans it Up
			tableData=readtable(titleText);
			tableData.Properties.VariableNames = {'date' 'two' 'ozone' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten'};
			numData = tableData.ozone;
			textData = tableData.date;
			if iscell(numData)== 1;
				numData=cell2table(numData);
				numDataClean = zeros(height(numData),1);
				for count = 1:height(numData)
					findNan=char(numData.numData(count,1));
					if ((findNan(1) ~= 'N' ) && (findNan(1) ~= '-')) == 1
						numDataClean(count,1)=str2double(char(numData.numData(count,1)));
					else
						numDataClean(count,1)=NaN;
					end
				end
			else
				numDataClean=numData;
				for count = 1:length(numData)
					if ((isnan(numData(count,1)) ~= 1) && (sign(numData(count,1)) ~= -1)) == 1
					else
						numDataClean(count,1)=NaN;
					end
				end
			end
			numDataClean=numDataClean+.0001;
			numDataClean(numDataClean>200)=NaN;
			numDataClean(numDataClean<.001)=NaN;
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Average for 2 min
			try
				for count=1:length(numDataClean)
					if count==1
						numDataHold=numDataClean(1:2,1);
						numDAvgOneMinNew(1,1)=(sum(numDataHold(~isnan(numDataHold)))/(sum(not(isnan(numDataClean(1:2,1))))));
					else
						numDataHold=numDataClean(((count-1)*2+1):((count)*2),1);
						numDAvgOneMinNew(count,1)=(sum(numDataHold(~isnan(numDataHold)))/(sum(not(isnan(numDataClean(((count-1)*2+1):((count)*2),1))))));
					end
				end
			catch
				numDataHold=numDataClean(((count-1)*2+1):end,1);
				numDAvgOneMinNew(count,1)=(sum(numDataHold(~isnan(numDataHold)))/(sum(not(isnan(numDataClean(((count-1)*2+1):end,1))))));
			end
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Average for 5 min
			try
				for count=1:length(numDAvgOneMinNew)					
					numDataHold=numDAvgOneMinNew(((count-1)*5+1):((count)*5),1);
					numDAvgFiveMinNew(count,1)=(sum(numDataHold(~isnan(numDataHold))))/(sum(not(isnan(numDataHold))));
				end
			catch
			end
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Avg for 60 Min
			try
				for count=1:length(numDAvgOneMinNew)
					numDataHold=numDAvgOneMinNew(((count-1)*60+1):((count)*60),1);
					numDAvgSixtyMinNew(count,1)=(sum(numDataHold(~isnan(numDataHold))))/(sum(not(isnan(numDataHold))));				
				end
			catch
			end
			%%%%%%%%%%%%%%%%%%%%%%Convert, Combine, And print 2 minute Data
			cd C:\Users\Ian\Documents\MATLAB\Just_Work %path to where you want the files to go
			textDataEven=textData(2:2:end,1);
			numDAvgOneMinNew=numDAvgOneMinNew+.0001;
			try
				for count=1:(length(numDAvgOneMinNew)+1)
					if count==1;
						fid=fopen(['OneMin_2014_'  num2str(startNum) '.txt'],'w');
						header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
						fprintf(fid, [ header '\n']);
					else
						numDataText=num2str(numDAvgOneMinNew(count-1));
						textDatLine=char(textDataEven(count-1));
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
							%warning(['Inputing NaN for line ' num2str(count)]); %this line is unnecissary but will make the program look cooler
							textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0      NaN']);
							fprintf(fid, [ textLine '\n']);
						end
					end
				end
			catch
			end
			disp(['OneMin_'  num2str(startNum) '.txt SUCCESSFUL']);
			fclose(fid);
			
			%%%%%%%%%%%%%%%%%%%%%%%%%Convert, Combine, and Print 5 min Data
			textDataFive=textData(1:10:end,1);
			for count=1:length(textDataFive)
				holdout=char(textDataFive(count,1));
				holdout=holdout(1:17);
				holdout=[holdout '00'];
				textDataFive(count,1)=cellstr(holdout);
			end
			numDAvgFiveMinNew=numDAvgFiveMinNew+.0001;
			try
				for count=1:(length(numDAvgFiveMinNew)+1)
					if count==1;
						fid=fopen(['FiveMin_2014_'  num2str(startNum) '.txt'],'w');
						header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
						fprintf(fid, [ header '\n']);
					else
						numDataText=num2str(numDAvgFiveMinNew(count-1));
						textDatLine=char(textDataFive(count-1));
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
							%warning(['Inputing NaN for line ' num2str(count)]); %this line is unnecissary but will make the program look cooler
							textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0      NaN']);
							fprintf(fid, [ textLine '\n']);
						end
					end
				end
			catch
			end
			disp(['FiveMin_'  num2str(startNum) '.txt SUCCESSFUL']);
			fclose(fid);
			
			%%%%%%%%%%%%%%%%%%%%%Convert, Combine, and print 60 minute data
			textDataFive=textData(1:120:end,1);
			for count=1:length(textDataFive)
				holdout=char(textDataFive(count,1));
				holdout=holdout(1:17);
				holdout=[holdout '00'];
				textDataFive(count,1)=cellstr(holdout);
			end
			for count=1:length(numDAvgSixtyMinNew)
				holdit=numDAvgSixtyMinNew(count);
				holdit=num2str(holdit);
				if holdit(end) ~= '9'
					numDAvgSixtyMinNew(count)=numDAvgSixtyMinNew(count)+.0001;
				else
					%warning(['Hourly NaN inputed @ file ' num2str(startNum) 'on line' ]) %I have no idea why this exists, It doens't input a nan, this entire section actually exists to STOP nans from being inputted. weird.
				end
			end
			try
				for count=1:(length(numDAvgSixtyMinNew)+1)
					if count==1;
						fid=fopen(['SixtyMinute_2014_'  num2str(startNum) '.txt'],'w');
						header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
						fprintf(fid, [ header '\n']);
					else
						numDataText=num2str(numDAvgSixtyMinNew(count-1));
						textDatLine=char(textDataFive(count-1));
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
							%warning(['Inputing NaN for line ' num2str(count)]); %this line is unnecissary but will make the program look cooler
							textLine=(['350 ' textDatLine(1:4) '   ' textDatLine(6:7) '  ' textDatLine(9:10) '  ' textDatLine(12:13) '  ' textDatLine(15:16) '.0      NaN']);
							fprintf(fid, [ textLine '\n']);
						end %this is an end function and it ends the function. It is for the functino to stop so that it will stop
						
					end
				end
			catch
			end
			disp(['SixtyMin_'  num2str(startNum) '.txt SUCCESSFUL']);
			fclose(fid);
			
		else
			warning([ titleText  ' DOES NOT EXIST'])
		end
	else
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
clear findNan a ans count endNum fid header holdit holdout numData numDataClean numDataHold numDataText numDAvgFiveMinNew numDAvgOneMinNew numDAvgSixtyMinNew startNum startNumForCalc tableData textData textDataEven textDataFive textDatLine textLine time titleText