close all; clear all; clc;
format long;

% g1 adjacency matrix for fad interaction
A = [1,-0.3,-0.3,-0.3;
    -0.3,1,-0.3,-0.3;
    -0.3,-0.3,1,-0.3;
    -0.3,-0.3,-0.3,1];

% % g2
% A = [1 -0.5 0 0;
%      -0.5 1 0 0;
%      0 0 1 -0.3;
%      0 0 -0.3 1];
% % g3
% A = [1 0.3 0 0;
%      0.3 1 -1 0;
%      0 -1 1 0.3;
%      0 0 0.3 1 ];

% initial conditions for conformists/nonconformists  
a = [10 35 41 60]'; 
h = [20 70 18 50]';
numFad = 4;

S_a = sum(a); % total population a (conformists)
S_h = sum(h); % total population h (non-conformists)

% initial condition tildes
for i=1:numFad
    a_tilde(i,1) = a(i)/S_a;
    h_tilde(i,1) = h(i)/S_h;
end

N = 2^21; % total number of steps
delta = 2^(-10); % time step
t = 0:delta:N*delta;

% model parameters
alpha = 3;
beta = 3;
gamma = 0.5;

% FE iteration
for i=1:N
    if mod(i, 10000) == 0
        fprintf('%i / %i\n', i, N)
    end
    for j=1:numFad
        a_prime = a_tilde(j,i)*(1-a_tilde(j,i))*(A(j,:)*a_tilde(:,i)+A(j,:)*h_tilde(:, i)*alpha);
        a(j,i+1) = a(j,i) + delta*a_prime;
        
        h_prime = h_tilde(j,i)*(1-h_tilde(j,i))*(-beta*(a_tilde(j,i))+(gamma/a_tilde(j,i))+A(j,:)*h_tilde(:,i));
        h(j,i+1) = h(j,i) + delta*h_prime;       
    end
    a_tilde(:,i+1) = a(:,i+1)/S_a;
    h_tilde(:,i+1)=h(:,i+1)/S_h;
end

% normalize the time vector
t = t./max(t);

disp('calculation done, plotting ... ')

% plot of conformists over time
figure(1) 
plot(t, a_tilde', '.-')
l = legend('Fad 1', 'Fad 2', 'Fad 3', 'Fad 4', 'Interpreter','latex');
l.FontSize=10;
h = title('Conformist''s Fad Trends - $G_1$', 'Interpreter','latex');
h.FontSize=15;

% plot of non-conformists over time
figure(2)
plot(t, h_tilde', '.-')
l = legend('Fad 1', 'Fad 2', 'Fad 3', 'Fad 4', 'Interpreter','latex');
l.FontSize=10;
h = title('Non-Conformist''s Fad Trends - $G_1$', 'Interpreter','latex');
h.FontSize=15;

