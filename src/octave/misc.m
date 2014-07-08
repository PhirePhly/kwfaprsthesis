% Kenneth Finnegan, 2014
% Octave code to generate figures for MS Thesis

close all;

% Basic 3002 trunk phone line
figure(1);
xpts3002 = [300 500 500 2500 2500 3000 3000 2500 2500 500 500 300];
ypts3002 = [3 3 2 2 3 3 -12 -12 -8 -8 -12 -12];
fill(xpts3002, ypts3002, [0.7; 0.7; 0.7])
xlabel('Audio Frequency [Hertz]');
ylabel('Allowable Relative Magnitude [dB, 1004Hz]');
axis([0 3200 -13 4]);
set(gca, 'xtick', [300 500 1004 1200 2200 2500 3000]);
set(gca, 'ytick', [-12 -8 0 2 3]);
grid on;

print('3002.eps');

% SmartBeacon Intervals

low_speed = 5;
high_speed = 60;
upper_speed = 70;
slow_beacon_int = 1800;
fast_beacon_int = 180;
turn_min = 30;
turn_slope = 255;

figure(2);
speed = [0.1:0.1:upper_speed];

for i = 1:size(speed)(2)
	beacon_int(i) = fast_beacon_int * high_speed / speed(i);
	if (speed(i) < low_speed)
		beacon_int(i) = slow_beacon_int;
	elseif (speed(i) > high_speed)
		beacon_int(i) = fast_beacon_int;
	endif
endfor

plot(speed,beacon_int);
axis([0 upper_speed 0 2200]);
xlabel('Tracker Velocity [MPH]');
ylabel('Beacon Interval [seconds]');
grid on;

print('smartvelocity.eps');

figure(3);
turn_speed = [low_speed:0.1:upper_speed];
turn_thresh = turn_min + turn_slope ./ turn_speed;
plot(turn_speed,turn_thresh);
axis([0 upper_speed 0 90]);
xlabel('Tracker Velocity [MPH]');
ylabel('Heading Change Threshold [degrees]');
set(gca, 'ytick', [0 10 20 30 40 50 60 70 80 90]);
grid on;

print('smartcorner.eps');


figure(4);
Fullaudio = wavread('AA.wav');
Aaudio = Fullaudio(5916:6283);
bitnum=-0.5:1200/44100:11;
plot(bitnum(1:368),Aaudio);
axis ([0 9 -0.8 0.8]);
xlabel('Symbol Period');
ylabel('Signal Magnitude');
set(gca, 'xtick', [1 2 3 4 5 6 7 8]);
grid on;

print('bell202A.eps');
