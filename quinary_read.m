
cd C:\Users\Ian\Documents\MATLAB
key=[10 20 30 40 50];




title = 'quinary';
dist=3;

image=imread([title '.png']);

key=key-1;

binhold='';
x=1;
c=1;
b=1;
leng=length(image);

for b = 1:length(image)
	for x=1:dist
		hexhold=image(c,x);
		if hexhold==key(1)
			binhold=[binhold '0'];
		end
		if hexhold==key(2)
			binhold=[binhold '1'];
		end
	
		if hexhold==key(3)
			binhold=[binhold '2'];
		end
		if hexhold==key(4)
			binhold=[binhold '3'];
		end
		if hexhold==key(5)
			binhold=[binhold '4'];
		end
	end
	if x>=dist
		x=x+1;
		c=c+1;
	end
% 	if c>=leng
% % 		c=1;
% 	end
end

clearvars -except binhold dist

string='';
bhold='';
x=1;
c=1;
count=0;

for c=1:(length(binhold)/dist)
	for x=1:dist
		bthold=binhold(x+count);
		bhold=[bhold bthold];
	end

	asciihold=base2dec(bhold, 5);
	letter=char(asciihold);
	string=[string letter];
	
	if x>=dist
		x=1;
		count=count+dist;
		clear bthold asciihold letter
		bhold='';
	end
	
end

disp(string);

clearvars -except string binhold dist
clear all