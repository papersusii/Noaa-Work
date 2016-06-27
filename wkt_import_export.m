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
		for dayNum = 1:1
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
		end
	end
end

close all
fclose all;
time=toc;
disp('-----------------------------------');
disp(time);