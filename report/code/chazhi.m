xy=[0 	10 	15 	20 	25 	30 	35 	40 	45 	50 	55 	60 	65 	70 	75 	80 	85 	90 	95 	100 
0.00013 	0.00025 	0.00085 	0.00180 	0.00289 	0.00425 	0.00582 	0.00782 	0.00984 	0.01207 	0.01447 	0.01704 	0.01979 	0.02269 	0.02575 	0.02898 	0.03236 	0.03590 	0.03958 	0.04342 
];
xi=0:1:80;
yi=interp1(xy(1,:),xy(2,:),xi,'spline');
plot(xi,yi)
load waterchanshu
waterchanshu=[waterchanshu,yi'];
save waterchanshu