close all
clear all

a_tilde1 = [0.01, 0.5, 0.8, 0.4];
a_tilde2 = [1.0, 0.2, 0.1, 0.9];

h_tilde1 = [1.0, 0.2, 0.1, 0.7];
h_tilde2 = [0.01, 0.8, 0.9, 0.2];

N = 200;

tilde1 = [a_tilde1, h_tilde1];
tilde2 = [a_tilde2, h_tilde2];

for i=1:length(tilde1)
    a_tildes_matrix(:,i) = linspace(tilde1(i), tilde2(i), N)';
end

opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
timeInterval = 0:0.01:15;

set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1])

for i=1:N
    disp(i)
    initConds =  a_tildes_matrix(i,:);
    
    [t,y] = ode45(@scudemODEsystem, timeInterval, initConds, opts);
    
    a_tilde = y(:, 1:4);
    h_tilde = y(:, 5:8);
    
    result_a(:, :, i) = a_tilde;
    result_h(:, :, i) = h_tilde;
end

for i=1:N
    disp(i)
    plot(t, result_h(:, :, i), '.-')
    ylim([-0.1, 1.1])
    title('Hipsters')
    legend('Fad 1', 'Fad 2', 'Fad 3', 'Fad 4', 'Interpreter','latex');
    drawnow;
    
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
    F(i) = getframe(ax,rect);
end

vid = VideoWriter('scudemHipster2.avi', 'Motion JPEG AVI');
vid.FrameRate = 15;
open(vid)
writeVideo(vid, F)
close(vid)
