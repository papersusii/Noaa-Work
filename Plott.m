fclose all;
close all
%set(gcf,'Visible','on');
for x=1:55
 	try
	
	for incr=(7*(x-1)+1):(7*x)
		cd C:\Users\Ian\Documents\MATLAB\Just_Work
		set(gcf,'Visible','off');
		try
			cd C:\Users\Ian\Documents\MATLAB\Just_Work
			myImport=importdata(['SixtyMinute_2014_' num2str(incr) '.txt']);
			
			clear Y M D H l MI S time data
			Y = myImport.data(:,2);
			M = myImport.data(:,3);
			D = myImport.data(:,4);
			H = myImport.data(:,5);
			l = length(Y);
			MI = myImport.data(:,6);
			S(l,1) = 0;
			time = datetime(Y,M,D,H,MI,S);
			data = myImport.data(:,7);
			% data(data>65)=NaN;
			plot(time,data,'r');
			ylabel('Ozone ppb');
			xlabel('Date');
			hold on;
			disp(['OneMin_2014_' num2str(incr) '.txt SUCCESSFUL @ a=' num2str(x)]);
			
		catch
			close all
			warning(['Something Messed up @ a=' num2str(x)])
			%a=a+1;
		end

	end
	if exist(['SixtyMinute_2014_' num2str(incr) '.txt'],'file')==2
	cd C:\Users\Ian\Documents\MATLAB\pictures
	print(['SIXTYPlot_' num2str(x) ],'-dpng');
	close all
	disp(x);
	hold off;
	else
		warning('file does not exist');
	end
	catch
		close all
		warning(['something when REALLY wrong @ x=' num2str(x) ' and @ a=' num2str(x)]);
	end
end