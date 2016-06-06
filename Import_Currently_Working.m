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
clc
tic
startnum = 1;
endnum = 1;
disp(['Start: ' num2str(startnum)]) 
disp(['End: ' num2str(endnum)])
header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)'

for startnum = startnum:endnum
    if startnum ~= 40
        if numel(num2str(startnum)) == 1;
            tnumhold = num2str(startnum);
            tincrmntstr = ['00' tnumhold];
        end
        if numel(num2str(startnum)) == 2;
            tnumhold = num2str(startnum);
            tincrmntstr = ['0' tnumhold];
        end
        if numel(num2str(startnum)) == 3;
            tincrmntstr = num2str(startnum);
        end
        ttext = ['BAO_OZ3_2014' tincrmntstr '.dat'];
        if exist(ttext,'file') == 2
            FileIsReal=1;
            structdata = importdata(ttext);
            structdata = rmfield(structdata,'rowheaders');
            numdata = structdata.data;
            textdata = structdata.textdata;
            disp(['file ' num2str(startnum) '.dat succesful'])
            
            %
            
            
            %
        else
            warning(['FILE ' ttext ' DOES NOT EXIST'])
            FileIsReal=0;
        end
        
    end
end

clear ans endnum incrmnt startnum tincrmnt tincrmntstr tnumhold ttext
toc