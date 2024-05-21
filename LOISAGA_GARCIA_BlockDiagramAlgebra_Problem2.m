%Clear
clear
clc
close all

%Loisaga, Dean Abraham M. | Garcia, Rod Allen
%% Problem Number 2
%% Define Block Diagram and Reduce

% G1(s) = 1/s^2
G1_num = 1;
G1_den = [1 0 0];
G1 = tf(G1_num,G1_den);

% G2(s) = 1/(s+1)
G2_num = 1;
G2_den = [1 1];
G2 = tf(G2_num,G2_den);

% G3(s) = 1/s
G3_num = 1;
G3_den = [1 0];
G3 = tf(G3_num,G3_den);

% G4(s) = 1/(2s)
G4_num = 1;
G4_den = [2 0];
G4 = tf(G4_num,G4_den);

% H1(s) = 1/s
H1_num = 1;
H1_den = [1 0];
H1 = tf(H1_num,H1_den);

% H2(s) = 1/(s-1)
H2_num = 1;
H2_den = [1 -1];
H2 = tf(H2_num,H2_den);

% H3(s) = 1/(s-2)
H3_num = 1;
H3_den = [1 -2];
H3 = tf(H3_num,H3_den);

%% Relocating H3 branch, Reduce G4, H3 block
% H3 and G4 becomes series
TF_1_num = conv(G4_num,H3_num);
TF_1_den = conv(G4_den,H3_den);
TF_1 = tf(TF_1_num,TF_1_den)

%% Reduce G3, G4H3 block - parallel
G3G4H3_num = conv(TF_1_num,G3_num);
G3G4H3_den = conv(TF_1_den,G3_den);

TF_2_den_sum = [2 -4 0 1]

TF_2_num = conv(G3G4H3_den,G3_num); 
TF_2_den = conv(TF_2_den_sum,G3_den);
TF_2 = tf (TF_2_num,TF_2_den)

%% Reduce G2, G3/(1+G3G4H3) block - series
TF_3_num = conv(G2_num,TF_2_num);
TF_3_den = conv(G2_den,TF_2_den);
TF_3 = tf(TF_3_num,TF_3_den)

%% Reduce (G2G3)/(1+G3G4H3), H2 block - parallel
G2G3_num = conv(G2_num,G3_num);
G2G3_den = conv(G2_den,G3_den);

G2G3H2_num = conv(G2G3_num,H2_num);
G2G3H2_den = conv(G2G3_den,H2_den);

TF_4_den_sum = [2 -4 -2 7 -4 -1 0]

TF_4_num = conv(TF_3_num,G2G3H2_den);
TF_4_den = conv(G2G3_den,TF_4_den_sum);
TF_4 = tf(TF_4_num,TF_4_den)

%% Reduce G1, G2G3/(1+G3G4H3+G2G3H2), G4 block - series
G1G4_num = conv(G2_num,G4_num);
G1G4_den = conv(G2_den,G4_den);

TF_5_num = conv(G1G4_num,TF_4_num);
TF_5_den = conv(G1G4_den,TF_4_den);
TF_5 = tf (TF_5_num, TF_5_den)

%% Reduce (G1G2G3G4)/(1+G3G4H3+G2G3H2), H1 block - parallel
G1G2G3G4_num = conv(G2G3_num,G1G4_num);
G1G2G3G4_den = conv(G2G3_den,G1G4_den);

G1G2G3G4H1_num = conv(G1G2G3G4_num,H1_num);
G1G2G3G4H1_den = conv(G1G2G3G4_den,H1_den);

TF_6_den_sum = [4 0 -16 -2 16 -2 -16 -4 4 0 0 0]

TF_6_num = conv(TF_5_num,G1G2G3G4H1_den);
TF_6_den = conv(G1G2G3G4_den,TF_6_den_sum);
TF_6 = tf (TF_6_num, TF_6_den)

step(TF_6,0:0.1:20)