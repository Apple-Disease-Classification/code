clc
clear all
close all
warning off all

%% load the data

load n1
load n2
load n3
load n4
load n5
load n6
load n7
load n8
load n9
load n10

load b1
load b2
load b3
load b4
load b5
load b6
load b7
load b8
load b9
load b10

load r1
load r2
load r3
load r4
load r5
load r6
load r7
load r8
load r9
load r10


load s1
load s2
load s3
load s4
load s5
load s6
load s7
load s8
load s9
load s10


T = [n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,r1,r2,r3,r4,r5,r6,n7,n8,n9,n10,s1,s2,s3,s4,s5,s6,n7,n8,n9,n10];
x = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3];
%% create a feed forward neural network

net3 = newff(minmax(T),[30 40 1],{'logsig','logsig','purelin'},'trainrp');
%minmax(T) : matrix of min and max values for T input vectors elements
%[30 20 1] : Size of ith layer
%{'logsig','logsig','purelin'} : Transfer function of ith layer
%'trainrp'  :  trains the network with trainrp (Use TRAINRP which is slower but more memory efficient than TRAINBFG.)
%The training function BTF can be any of the backprop training
 %    functions such as TRAINLM, TRAINBFG, TRAINRP, TRAINGD...

net3.trainParam.show = 1000;  %Epochs between displays (NaN for no displays).The default value is 25.
net3.trainParam.lr = 0.04;   %Learning rate. The default value is 0.01.
net3.trainParam.epochs = 7000; %Maximum number of epochs to train.The default value is 1000.
net3.trainParam.goal = 1e-5;  %Performance goal. The default value is 0.
%net1.trainParam.deltamax=80.0;
%net1.trainParam.delta0=1.00;

%% Train the neural network using the input,target and the created network
[net3] = train(net3,T,x);

%% save the network
save net3

%% simulate the network for a particular input
y = round(sim(net3,T))
