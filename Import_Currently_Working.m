%{
raw:
"2014-01-01 00:00:00",3617737,42.33333,28,753.3,18.875,808.1333,0,73226.56,1
"yyyy-mm-dd hh:mm:ss",xxxxxxx,####,####,###,#
%}
clc

startnum = 1
tincrmnt = startnum;
incrmnt = startnum;
ttext = '';
for incrmnt = startnum:365
    if incrmnt ~= 40
        if numel(num2str(tincrmnt)) == 1;
            tnumhold = num2str(tincrmnt);
            tincrmntstr = ['00' tnumhold];
        end
        if numel(num2str(tincrmnt)) == 2;
            tnumhold = num2str(tincrmnt);
            tincrmntstr = ['0' tnumhold];
        end
        if numel(num2str(tincrmnt)) == 3;
            %    tnumhold = num2str(tincrmnt);
            %    tincrmntstr = ['' tnumhold];
            tincrmntstr = num2str(tincrmnt);
        end
        
        ttext = ['BAO_OZ3_2014' tincrmntstr '.dat'];
        
        if exist(ttext) == 2
            structdata = importdata(ttext);
            structdata = rmfield(structdata,'rowheaders'); %controversial and unused
            numdata = structdata.data;
            structtext = structdata.textdata;
            disp(['file ' num2str(incrmnt) '.dat succesful'])
        end
        if exist(ttext) == 0
            warning(['FILE ' ttext ' DOES NOT EXIST'])
        end
    end
    tincrmnt = tincrmnt+1;
end