close all; clear all; clc;
format long;

% g1 adjacency matrix for fad interaction
a_start = -3;
a_end = 7;

A = [1, a_start;
        a_start, 1];

M=250;
delta2 = (a_end-a_start)/M;
delta_matrix = fliplr(eye(2))*delta2;

% initial conditions for conformists/nonconformists  
a = [10 35 ]'; 
h = [20 70 ]';
numFad = 2;

S_a = sum(a); % total population a (conformists)
S_h = sum(h); % total population h (non-conformists)

% initial condition tildes
for i=1:numFad
    a_tilde(i,1) = a(i)/S_a;
    h_tilde(i,1) = h(i)/S_h;
end

N = 2^12; % total number of steps
delta = 2^(-8); % time step
t = 0:delta:N*delta;

% model parameters
alpha = 3;
beta = 3;
gamma = 0.5;

% FE iteration

for m=1:M
    disp(m)
    
    for i=1:N
        for j=1:numFad
            a_prime = a_tilde(j,i)*(1-a_tilde(j,i))*(A(j,:)*a_tilde(:,i)+A(j,:)*h_tilde(:, i)*alpha);
            a_tilde(j,i+1) = a_tilde(j,i) + delta*a_prime;

            h_prime = h_tilde(j,i)*(1-h_tilde(j,i))*(-beta*(a_tilde(j,i))+(gamma/a_tilde(j,i))+A(j,:)*h_tilde(:,i));
            h_tilde(j,i+1) = h_tilde(j,i) + delta*h_prime;       
        end
    end
    a_final(:,:,m)=a_tilde;
    h_final(:,:,m)=h_tilde;
    
    A = A+delta_matrix;
end

set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 0.95])
for i=1:M
    plot(t, h_final(1,:,i),'.-', t, h_final(2,:,i), '.-')
    disp(i)
    ylim([-0.1, 1.1])
    
    s=sprintf("Nonconformists Both Fads, $m=%0.2f$", a_start+delta2*i);
    title(s,'interpreter','latex', 'FontSize', 20)
    %legend('Fad1', 'Fad2', 'Interpreter','latex');
    legend('Fad 1','Fad 2','Interpreter','latex')
    drawnow;
    
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
    F(i) = getframe(ax,rect);
end

vid = VideoWriter('BiggerFont-FE NonConformist both fads -3 7.avi', 'Motion JPEG AVI');
vid.FrameRate = 7;
open(vid)
writeVideo(vid, F)
close(vid)



