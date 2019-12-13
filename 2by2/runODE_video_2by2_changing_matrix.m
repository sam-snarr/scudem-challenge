close all;
clear all;

N = 50;

% for some reason ode45 will only work for m in (-0.99, 0.99)
a_start = -.9;
a_end = 0.9;

A = [1, a_start;
    a_start, 1];

delta = (a_end-a_start)/N;
delta_matrix = fliplr(eye(2))*delta;

a_tilde1 = [0.6, 0.8];
a_tilde2 = [0.6, 0.8];

h_tilde1 = [0.3, 0.5];
h_tilde2 =  [0.3, 0.5];

tilde1 = [a_tilde1, h_tilde1];
tilde2 = [a_tilde2, h_tilde2];

for i=1:length(tilde1)
    tildes_matrix(:,i) = linspace(tilde1(i), tilde2(i), N)';
end

opts = odeset('RelTol',1e-6,'AbsTol',1e-6);

delta=1/2^6;
timeInterval = 0:delta:15;

set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 0.95])

for i=1:N
    disp(i)
    initConds =  tildes_matrix(i,:);
    
    [t,y] = ode45(@(t,y)scudemODEsystem2(t,y,A), timeInterval, initConds, opts);
    
    a_tilde = y(:, 1:2);
    h_tilde = y(:, 3:4);
    
    result_a(:, :, i) = a_tilde;
    result_h(:, :, i) = h_tilde;
    
    A=A+delta_matrix;
end

for i=1:N
    disp(i)
    plot(t, result_h(:, 1, i), t, result_a(:,1,i))
    ylim([-0.1, 1.1])
    s=sprintf("Conformists vs Nonconformists Fad 1, $m=%0.2f$", a_start+delta*i);
    title(s,'interpreter','latex')
    legend('Hipsters1', 'Conformists1', 'Hipsters2', 'Conformists2', 'Interpreter','latex');
    drawnow;
    
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
    F(i) = getframe(ax,rect);
end

vid = VideoWriter('scudemConformists_matrix.avi', 'Motion JPEG AVI');
vid.FrameRate = 7;
open(vid)
writeVideo(vid, F)
close(vid)
