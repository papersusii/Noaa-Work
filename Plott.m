fclose all;
close all
% title=cell(3,1);
% title(1) = {'OneMin_2014_'};
% title(2) = {'FiveMin_2014_'};
% title(3) = {'SixtyMin_2014_'};

importtitle='SixtyMinute_2015_';
exporttitle='2015_Week_';
dirnametext='C:\Users\Ian\Documents\MATLAB\TextFiles_2015';
dirnamepic=

%set(gcf,'Visible','on');
for x=1:55
	try
		for incr=(7*(x-1)+1):(7*x)
			cd(dirnametext)
			set(gcf,'Visible','off');
			try
				cd C:\Users\Ian\Documents\MATLAB\TextFiles_2015
				myImport=importdata([importtitle num2str(incr) '.txt']);
				plot(datetime(myImport.data(:,2),myImport.data(:,3),myImport.data(:,4),myImport.data(:,5),myImport.data(:,6),zeros(length(myImport.data(:,2)),1)),myImport.data(:,7),'r');
				ylabel('Ozone ppb');
				xlabel('Date');
				hold on;
				disp([importtitle num2str(incr) '.txt SUCCESSFUL @ a=' num2str(x)]);
			catch
				close all
				warning(['Something Messed up @ a=' num2str(x)])
			end
		end
		if exist([importtitle num2str(incr) '.txt'],'file')==2
			cd C:\Users\Ian\Documents\MATLAB\Pictures_2015
			print([exporttitle num2str(x) ],'-dpng');
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


%% year
%{
for x=1:1
	try
		
		for incr=1:400
			cd C:\Users\Ian\Documents\MATLAB\Just_Work
			set(gcf,'Visible','off');
			try
				cd C:\Users\Ian\Documents\MATLAB\Just_Work
				myImport=importdata([importtitle num2str(incr) '.txt']);
				
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
				disp([importtitle num2str(incr) '.txt SUCCESSFUL @ a=' num2str(x)]);
				
			catch
				close all
				warning(['Something Messed up @ a=' num2str(x)])
				%a=a+1;
			end
			
		end
		if exist(['FiveMin_2014_' num2str(incr) '.txt'],'file')==2
			cd C:\Users\Ian\Documents\MATLAB\pictures
			%	close all
			disp(x);
			hold on;
		else
			warning('file does not exist');
		end
	catch
		%close all
		warning(['something when REALLY wrong @ x=' num2str(x) ' and @ a=' num2str(x)]);
	end
end
print(['year' num2str(x) ],'-dpng');
%}