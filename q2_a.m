%% Question 2 (a)
fs = 8192;

n = 0:999;

% Frequencies from Table 1
frq = [
    0.7217, 1.0247;
    0.5346, 0.9273;
    0.5346, 1.0247;
    0.5346, 1.1328;
    0.5906, 0.9273;
    0.5906, 1.0247;
    0.5906, 1.1328;
    0.6535, 0.9273;
    0.6535, 1.0247;
    0.6535, 1.1328
];

digits = ones(10, 1000);

% Signals for digits 0 to 9
for i = 1:10
    % row and column freq's
    omega_r = frq(i, 1);
    omega_c = frq(i, 2);
    % combination of two sinusoid
    digits(i, :) = sin(omega_r*n) + sin(omega_c*n);
end
d0 = digits(1, :);
d1 = digits(2, :);
d2 = digits(3, :);
d3 = digits(4, :);
d4 = digits(5, :);
d5 = digits(6, :);
d6 = digits(7, :);
d7 = digits(8, :);
d8 = digits(9, :);
d9 = digits(10, :);
% sound for d2
% sound(d2, fs);

%% Question 2 (b)
Fs = 8192;              
T = 1/Fs;
L = 1000;
t = (0:L-1)*T;
omega = 2*pi*(1/2048)*(0:2047);

tiledlayout(2,1);
nexttile
Y_d2 = fftshift(fft(d2, 2048));
plot(-pi:(2*pi/2048):pi-(2*pi/2048), abs(Y_d2),"LineWidth",3)
title("Complex Magnitude of fft Spectrum of d_2")
xlabel("f (\omega)")
ylabel("|fft(X)|")
xlim([-1.5 1.5])

nexttile
Y_d9 = fftshift(fft(d9, 2048));
plot(-pi:(2*pi/2048):pi-(2*pi/2048), abs(Y_d9),"LineWidth",3)
title("Complex Magnitude of fft Spectrum of d_9")
xlabel("f (\omega)")
ylabel("|fft(X)|")
xlim([-1.5 1.5])

%% Question 2 (c)
space = zeros(1, 100);
% 7 digits --> 303 68 34
phone = [d3 space d0 space d3 space d6 space d8 space d3 space d4];
sound(phone, fs)

%% Question 2 (d) - x_1
touch = load("touch.mat");
x1 = touch.x1;
x2 = touch.x2;
% for x1
% separate the signal into 7 digits
x1digs = zeros(7, 1000);
start = 1;
for i=1:7
    x1digs(i, :) = x1(start : start+999);
    start = start + 1100;
end

for r = 1:7
    subplot(3,3,r);
    sig = x1digs(r, :);
    Y_sig = fftshift(fft(sig, 2048));
    plot(-pi:(2*pi/2048):pi-(2*pi/2048), abs(Y_sig),"LineWidth",3)
    title("Mag. of fft of tone " + r)
    xlabel("f (\omega)")
    ylabel("|fft(X)|")
    xlim([-1.5 1.5])
end

%phone number 491 58 77

%% Question 2 (d) - x_2
% separate the signal into 7 digits
x2digs = zeros(7, 1000);
start = 1;
for i=1:7
    x2digs(i, :) = x2(start : start+999);
    start = start + 1100;
end

for r = 1:7
    subplot(3,3,r);
    sig = x2digs(r, :);
    Y_sig = fftshift(fft(sig, 2048));
    plot(-pi:(2*pi/2048):pi-(2*pi/2048), abs(Y_sig),"LineWidth",3)
    title("Mag. of fft of tone " + r)
    xlabel("f (\omega)")
    ylabel("|fft(X)|")
    xlim([-1.5 1.5])
end

%phone number 253 10 00

%% Question 2 (e)

x_1_phone_no = ttdecode(frq, x1)
x_2_phone_no = ttdecode(frq, x2)

%% Question 2 (f)

% Question about index 1101

hardx1 = touch.hardx1;
hardx2 = touch.hardx2;

hardx_1_phone_no_ = ttdecode_hard(frq, hardx1)
hardx_2_phone_no = ttdecode_hard(frq, hardx2)
