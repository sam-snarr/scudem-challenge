

a = [10 35 41 60]; 
h = [20 70 18 50];

a_tilde = a/sum(a);
h_tilde = h/sum(h);

initConds = [a_tilde,h_tilde];

opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
timeInterval = [0 15];

[t,y] = ode45(@scudemODEsystem, timeInterval, initConds, opts);

a_tilde = y(:, 1:4);
h_tilde = y(:, 5:8);

%t = t./max(t); % normalize the time vector

% plot of conformists over time
figure(1) 
plot(t, a_tilde, '.-')
l = legend('Fad 1', 'Fad 2', 'Fad 3', 'Fad 4', 'Interpreter','latex');
l.FontSize=10;
h = title('Conformist''s Fad Trends - $G_1$', 'Interpreter','latex');
h.FontSize=15;

% plot of non-conformists over time
figure(2)
plot(t, h_tilde, '.-')
l = legend('Fad 1', 'Fad 2', 'Fad 3', 'Fad 4', 'Interpreter','latex');
l.FontSize=10;
h = title('Non-Conformist''s Fad Trends - $G_1$', 'Interpreter','latex');
h.FontSize=15;