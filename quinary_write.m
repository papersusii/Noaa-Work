%{
Simply put your  into the ftexteild 
str=double('THIS IS YOUR TEXT');
and hit run selection or cntr+enter.

itll come up and save an image as
asdfasdf.png
%}

cd C:\Users\Ian\Documents\MATLAB
%key is a 1x5 double of numbers less then 150 or so
%they key is what people transmit secretly beforehand in person
%and then they send the picture message over the internet.
%i have provided you with a picture and the code-figure it out m8
key=[10 20 30 40 50];

title = 'quinary';
dist=3;






close all;


%str=double('I was once trapped in a muffin,yet i wanted to go and tricycle so bad that all the halloween set my pants on fire, where my cousin was bald and had a chicken body ,he ran in circles around my shoulder while i did bite off rabbet heads smear the blood on him and start chanting things while standing on a banana and screeching like a slaughtered pig, those bloody animals will never stop moving there lawn even in the winter solicitous contest, we would have to drive motorcycles underwater to keep the watches afloat,but while we did that little did we know that a evil pair of sunglasses was sticking down at our fire,and sending trickling coats to our dismay. I gust wanted to jump without limitations.i like my dog eat an anchor, i cant help the can not to do today,but in the world we only kill our lamas to sleep in my doughnut bar with some cyclers eating my shoe. my pants that halloween set on fire burned my legs to a crisp witch set dogs out to find me, i had escaped from jail. My prision mates were embodied souls in witch the hot dog director sucked out there brains and fed them to us again and again. this is in witch we do not everyone but we nothing our escape route. In not sure that anyone will ever understand that the mouse will always shoot hazers at us because we are simple . So the chicken bodies prision mate tackled the hot dog vampire and shouted: all more and all none winch means he wanted abeam care for his pet mutants son in law to go to saturn and burn halloween and Christmas embodiments in one extra large sieving of nachos. Meanwhile my great graft aunt was finding some live lobster hats to eat a giant battle axe showed up and cut the bread for my neighbors house. I wanted too shot him to and he was they guy on my shoulder as well,and the battle between hot dog and chicken had begun when i was in the way. we din''t listen. and my head was severed by the vampire hotdog, so i flew around my body spurting vomit through my cut esophagus. and my head floated and shot sunglasses and halloween out of its eyes and mouth. While i was doming that christmas and the axe and the choking chicken met up and planned how to destroy the try cling coats witch indeed had latex gloves on there heads. their path to victory was short a suddenly christmas met fourth of nachos and set the sky ablaze it was my dog. My pants are still burned to a crisp with then i captured the giant sunglasses and squeezed them into my next cup of joe,which then i did not know was my best friend joe jot grinded into coffee beans beans are yum and i was drinking him write now. little do i need to understand clll that i and we have said and done over the past A50,000,000,000.095986450 years that i have been in jail and that i want a lawyer because halloween died at Christmases hands and my chicken prision mate ate himself,i am again alone in this word for i ate Christmas and the axe, so i flew into my dog the last time i ever will again that i ever wanted too.');
str=double('This is where the text goes to be encoded.');

colormap winter;
bin=dec2base(str, 5, dist);
%x=1;
finbin='';
tmp=cellstr(bin);
for x=1:length(tmp);
	
	holder=tmp(x,1);
	holder=char(holder);
	finbin=[finbin holder];
end
% disp(bin);
x=1;
c=1;
v=1;
ch=1;
leng=length(finbin);

for ch= 1:(leng/dist)
	for x=1:dist
		
		cher=finbin(v);
		v=v+1;
		if cher=='0'
			h(c,x)=key(1);
		end
		if cher=='1'
			h(c,x)=key(2);
		end
		
		if cher=='2'
			h(c,x)=key(3);
		end
		if cher=='3'
			h(c,x)=key(4);
		end
		if cher=='4'
			h(c,x)=key(5);
		end
		x=x+1;
	end
	if x>=dist
		x=1;
		c=c+1;
	end
	if c>length(str)
		c=1;
	end
end

im = image(h);
imwrite(h,winter,[title '.png']);

clearvars -except dist finbin
clear all