% Clear
clear
clc
close  all

%% Define G1, G2, G3, H1, H2 and H3

G1_num = [0 1];
G1_den = [1 0 0];
G1 = tf (G1_num, G1_den)

G2_num = [0 1];
G2_den = [1 1];
G2 = tf (G2_num, G2_den)

G3_num = [0 1];
G3_den = [1 0];
G3 = tf (G3_num, G3_den)

H1_num = [0 1];
H1_den = [1 0];
H1 = tf (H1_num, H1_den)

H2_num = [0 1];
H2_den = [1 -1];
H2 = tf (H2_num, H2_den)

H3_num = [0 1];
H3_den = [1 -2];
H3 = tf (H3_num, H3_den)


%% Block Diagram Reduction
% For G3 and H3

G3H3_num = conv(G3_num,H3_num)
G3H3_den = conv(G3_den,H3_den)

TF3_num = conv(G3H3_num, G3H3_den)
TF3_den_sum = [1 -2 1]
TF3_den = conv (G3_den, TF3_den_sum)
TF3 = tf (TF3_num, TF3_den)

% For 1/G2 branch
G2_branch_num = [1 2]
TFBR_num =  conv (G2_branch_num, G2_den)
TFBR_den = conv (G2_num,G2_den)
TFBR = tf (TFBR_num, TFBR_den)

% For G2 and H2
G2H2_num = conv (G2_num,H2_num)
G2H2_den = conv (G2_den, H2_den)

TF2_num = conv (G2H2_num, G2H2_den)
TF2_num_sum = [1 0 0]
TF2_den  = conv (G2_den, TF2_num_sum)
TF2 = tf (TF2_num, TF2_den)

% For G1 and TF2
TF1_num = conv (G1_num, TF2_num)
TF1_den = conv (G1_den, TF2_den)
TF1 = tf (TF1_num, TF1_den)

% For TF3 and TFBR
TF3TBR_num = conv (TF3_num, TFBR_num)
TF3TBR_den = conv (TF3_den, TFBR_den)
TF3TBR = tf (TF3TBR_num, TF3TBR_den)

% For TF1 and H1
TF1H1_num = conv (TF1_num, H1_num)
TF1H1_den = conv (TF1_den,H1_den)
TF4_num = conv (TF1_num, TF1H1_den)
TF4_sum = [ 1 1 0 0 1 0 -1]
TF4_den = conv (TF1_den, TF4_sum)
TF4 = tf (TF4_num, TF4_den)

% Final Reduced Block Diagram
TF_Final_num = conv (TF4_num, TF3TBR_num)
TF_Final_den = conv (TF4_den, TF3TBR_den)
TF = tf (TF_Final_num, TF_Final_den)

% Step Response
step (TF, 0:0.1:20)

