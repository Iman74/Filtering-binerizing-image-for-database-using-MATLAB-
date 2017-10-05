clc
clear
ImageNum=47;
orgimage=cell([1,ImageNum]);
grayimage=cell([1,ImageNum]);
%%%%%%%%%%%%%%%%%%%%%%%read images%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
for i=1:ImageNum
   address = sprintf('raw\\Croped\\%d.bmp',i);
   orgimage{i}=imread(address);
end
% for i=121:ImageNum
%    address = sprintf('pics\\pic (%d).png',i-120);
%    orgimage{i}=imread(address);
% end
disp 'image loaded ...';
%%
%%%%%%%%%%%%%%%%%%%%%%%filtering images%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

for i=1:ImageNum
   grayimage{i}=rgb2gray(orgimage{i});
   grayimage1{i}=grayimage{i}>110;
end

disp 'image garye done .';
%%
for i=1:ImageNum
address = sprintf('raw\\Graypics\\pic (%d).jpg',i);
imwrite(grayimage1{i},address);
end
disp '... graye image saved';

%%
NoNoise=cell([1,ImageNum]);
for i=1:ImageNum
   NoNoise{i}=medfilt2(grayimage{i});
end
disp 'Gray NoNoiseing image done .';
%%
for i=1:ImageNum
address = sprintf('raw\\Graypics\\NoNoisedpics\\pic (%d).jpg',i);
imwrite(NoNoise{i},address);
end

disp '... Gray NoNoised image saved';
%%

BW=cell([1,ImageNum]);
for i=1:ImageNum
   level = graythresh(grayimage{i});
   BW{i}=imbinarize(grayimage{i},level);
end
disp 'binerizing image done .';

%%
for i=1:ImageNum
address = sprintf('raw\\binerizedpics\\pic (%d).jpg',i);
imwrite(BW{i},address);
end

disp '... binerized image saved';
%%
BNoNoise=cell([1,ImageNum]);
for i=1:ImageNum
   BNoNoise{i}=medfilt2(BW{i});
end
disp 'binerized NoNoiseing image done .';
%%
for i=1:ImageNum
address = sprintf('raw\\binerizedpics\\NoNoisedpics\\pic (%d).jpg',i);
imwrite(BNoNoise{i},address);
end

disp '... binerized NoNoised image saved';



%%
DR=cell([1,ImageNum]);
pixnum =25;
for i=1:ImageNum
   DR{i}=bwareaopen(BNoNoise{i},pixnum);
end
disp 'binerized Dotremoving image done .';
%%
for i=1:ImageNum
address = sprintf('raw\\binerizedpics\\DotRemoved\\pic (%d).jpg',i);
imwrite(DR{i},address);
end

disp '... binerized Dotremoved image saved';
imshow(DR{17})