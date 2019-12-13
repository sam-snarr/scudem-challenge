close all
clear all

A = [1,-0.3;
    -0.3,1];

a_tilde1 = [0.01, 1];
a_tilde2 = [1.0, 0.1];

h_tilde1 = [1.0, 0.1];
h_tilde2 = [0.01, 1];

N = 200;

tilde1 = [a_tilde1, h_tilde1];
tilde2 = [a_tilde2, h_tilde2];

for i=1:length(tilde1)
    tildes_matrix(:,i) = linspace(tilde1(i), tilde2(i), N)';
end

opts = odeset('RelTol',1e-6,'AbsTol',1e-6);

delta=1/2^6;
timeInterval = 0:delta:15;

set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])

for i=1:N
    disp(i)
    initConds =  tildes_matrix(i,:);
    
    [t,y] = ode45(@(t,y)scudemODEsystem2(t,y,A), timeInterval, initConds, opts);
    
    a_tilde = y(:, 1:2);
    h_tilde = y(:, 3:4);
    
    result_a(:, :, i) = a_tilde;
    result_h(:, :, i) = h_tilde;
end

for i=1:N
    disp(i)
    plot(t, result_h(:, :, i), '.-')
    ylim([-0.1, 1.1])
    title('Conformists')
    legend('Fad 1', 'Fad 2', 'Interpreter','latex');
    drawnow;
    
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
    F(i) = getframe(ax,rect);
end

vid = VideoWriter('scudemConformists.avi', 'Motion JPEG AVI');
vid.FrameRate = 7;
open(vid)
writeVideo(vid, F)
close(vid)
