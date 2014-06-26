
close all;

% Plot S = G e^(-2G)
% Poisson channel throughput
figure(1);
g = [0:0.01:2];
s = g .* e .^ (-2 * g);
plot(g,s);
xlabel('G, channel traffic');
ylabel('S, channel throughput');

print('poissonthroughput.eps');

% Slotted ALOHA
figure(2);
hold on;
sslot = g .* e .^ (-g);
plot(g,s,'b');
plot(g,sslot, 'r');
xlabel('G, channel traffic');
ylabel('S, channel throughput');

print('slottedthroughput.eps');

