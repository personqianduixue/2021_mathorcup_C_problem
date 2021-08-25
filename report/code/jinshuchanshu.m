clc
jinshuchan = [6379	10	51	57	0.85
77606	17	65	87	0.23
149852	28	125	143	0.07
5436	29	122	144	0.63
50130	16	122	132	0.06
16997	28	97	136	0.29
];
save jinshuchan
guiyijinshuchan = [];
[x,y] = size(jinshuchan);
for i = 1:y
    lie = jinshuchan(:,i)./sum(jinshuchan(:,i));
    guiyijinshuchan = [guiyijinshuchan,lie];
end
guiyijinshuchan
jiage = 1./guiyijinshuchan(:,1);
jiage = jiage./sum(jiage);

yali = guiyijinshuchan(:,2)+guiyijinshuchan(:,3)+guiyijinshuchan(:,4);
yali = yali./sum(yali);

kangfushi = 1./guiyijinshuchan(:,5);
kangfushi = kangfushi./sum(kangfushi);

guiyi = [jiage,yali,kangfushi]
save guiyi
% for i = 1:y
%     lie = zscore(jinshuchan(:,i));
%     guiyijinshuchan = [guiyijinshuchan,lie];
% end
% guiyijinshuchan