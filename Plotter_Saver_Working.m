incr=1;

%myImport=importdata(['MyFile_' num2str(incr) '.txt']);
myImport=importdata('bao_o3_300m_min_01_2014.dat');

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
data(data>65)=NaN;
plot(time,data);         
ylabel('Ozone ppb');
hold on;
% x = x + 1;
disp('plot 2011 succsessful');
print('processed_1','-dpng');
close all

for incr=1:31
myImport=importdata(['MyFile_' num2str(incr) '.txt']);

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
data(data>65)=NaN;
plot(time,data,'r');         
ylabel('Ozone ppb');
hold on;
% x = x + 1;
disp('plot 2011 succsessful');

end
print('processed_2','-dpng');
close all
%%
incr=incr+1;
myImport=importdata(['MyFile_' num2str(incr) '.txt']);

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
data(data>65)=NaN;
plot(time,data);         
ylabel('Ozone ppb');
hold on;
% x = x + 1;
disp('plot 2011 succsessful');