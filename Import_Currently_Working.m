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
startNum = 400;
endNum = 400;
disp(['Start: ' num2str(startNum)])
disp(['End: ' num2str(endNum)])
header = 'STN YEAR  MON  DAY  HR  MIN  O3(PPB)';
%incr2 = 1;

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
            fileIsReal=1;
            structData = rmfield(importdata(titleText),'rowheaders');
            numData = structData.data;
            textData = structData.textdata;
            disp(['file ' num2str(startNum) '.dat succesful'])
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            numDataClean=numData(1:length(numData),2)+.0001;
            textData=textData(1:length(textData));
            
            avgSet=1;
            count=1;
            incr3=2;
            
            oneMinFullSet=cell((length(textData)/2)+1,1);
            
            if avgSet==1
                for count=1:(length(textData))
                    if count == 1
                        oneMinNumLine=num2str(numDataClean(1));
                        %oneMinNumLine=num2str(oneMinNumLine);
                        oneMinNumLine=oneMinNumLine(1:5);
                        oneminDateLine= char(textData(1));
                        textLine = (['350 ' oneminDateLine(1:4) '   ' oneminDateLine(6:7) '  ' oneminDateLine(9:10) '  ' oneminDateLine(12:13) '  ' oneminDateLine(15:16) '.0    ' oneMinNumLine]);
                        oneMinFullSet(1,1)=cellstr(textLine);
                    else
                        oneMinNumLine=mean(numDataClean(incr3:incr3+1));
                        oneMinNumLine=num2str(oneMinNumLine);
                        oneMinNumLine=oneMinNumLine(1:5);
                        oneminDateLine = char(textData(incr3+1));
                        textLine = (['350 ' oneminDateLine(1:4) '   ' oneminDateLine(6:7) '  ' oneminDateLine(9:10) '  ' oneminDateLine(12:13) '  ' oneminDateLine(15:16) '.0    ' oneMinNumLine]);
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
    end
end

clear ans endnum incrmnt startnum tincrmnt tincrmntstr tnumhold ttext
clear FileIsReal header incr2 structdata
toc

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