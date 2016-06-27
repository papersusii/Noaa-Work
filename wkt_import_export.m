tic
fclose all;
close all
clear title

yearText={'2009' '2010' '2011' '2012' '2013' '2014' '2015' '2016'};
%yeardir='2009';
monthText={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12'};
dayText={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31'};
hourText={'00' '01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24'};


%direxportdata

for yearNum=1:1
	for monthNum=5:5
		cd(['C:\Users\Ian\Documents\MATLAB\' char(yearText(yearNum)) '\' char(monthText(monthNum))])
		disp(['C:\Users\Ian\Documents\MATLAB\' char(yearText(yearNum)) '\' char(monthText(monthNum))])
		for dayNum = 1:31
					cd(['C:\Users\Ian\Documents\MATLAB\' char(yearText(yearNum)) '\' char(monthText(monthNum))])
		disp(['C:\Users\Ian\Documents\MATLAB\' char(yearText(yearNum)) '\' char(monthText(monthNum))])

			disp(num2str(dayNum));
			for hourNum=1:24
				try
					rawImport=importdata(['wkt_ozo1_' char(yearText(yearNum)) '_' char(monthText(monthNum)) '_' char(dayText(dayNum)) '_' char(hourText(hourNum)) '00.dat']);
					if hourNum==1
						rawData=rawImport.data(:,2);
						rawText=rawImport.textdata(3:end,1);
					else
						rawData=[rawData;rawImport.data(:,2)];
						rawText=[rawText;rawImport.textdata(3:end,1)];
					end
				catch
					warning(['COULD NOT IMPORT wkt_ozo1_' char(yearText(yearNum)) '_' char(monthText(monthNum)) '_' char(dayText(dayNum)) '_' char(hourText(hourNum)) '00.dat']);
				end
			end
			cd(['C:\Users\Ian\Documents\MATLAB\WKT\TextFiles_' char(yearText(yearNum))]);
			%%%%%%%%%%
			numDataClean=rawData;
			numDataClean=numDataClean+.0001;
			numDataClean(numDataClean>200)=NaN;
			numDataClean(numDataClean<=5)=NaN;

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
			%%%%%%%%%%%%
			cd(['C:\Users\Ian\Documents\MATLAB\WKT\TextFiles_' char(yearText(yearNum))]);
			
			textDataEven=rawText(2:2:end,1);
			numDAvgOneMinNew=numDAvgOneMinNew+.0001;
			try
				for count=1:(length(numDAvgOneMinNew)+1)
					if count==1;
						fid=fopen(['OneMin_' char(yearText(yearNum)) '_'  num2str(dayNum) '.txt'],'w');
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
				disp('something went worng')
			end
			disp(['OneMin_'  num2str(dayNum) '.txt SUCCESSFUL']);
			fclose all;
			%%%%%%%%%%%
			
			
		end
	end
end

close all
fclose all;
time=toc;
disp('-----------------------------------');
disp(time);