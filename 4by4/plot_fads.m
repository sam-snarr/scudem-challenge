figure
plot(t,a_tilde(1,:),'.-')
hold on
plot(t,h_tilde(1,:),'.-')
l = legend('Conformists', 'Non-conformists', 'Interpreter','latex');
h = title('Fad 1 - $G_3$', 'Interpreter','latex');
l.FontSize = 10;
h.FontSize = 15;

figure
plot(t,a_tilde(2,:),'.-')
hold on
plot(t,h_tilde(2,:),'.-')
l = legend('Conformists', 'Non-conformists', 'Interpreter','latex');
h = title('Fad 2 - $G_3$', 'Interpreter','latex');
l.FontSize = 10;
h.FontSize = 15;

figure
plot(t,a_tilde(3,:),'.-')
hold on
plot(t,h_tilde(3,:),'.-')
l = legend('Conformists', 'Non-conformists', 'Interpreter','latex');
h = title('Fad 3 - $G_3$', 'Interpreter','latex');
l.FontSize = 10;
h.FontSize = 15;

figure
plot(t,a_tilde(4,:),'.-')
hold on
plot(t,h_tilde(4,:),'.-')
l = legend('Conformists', 'Non-conformists', 'Interpreter','latex');
h = title('Fad 4 - $G_3$', 'Interpreter','latex');
l.FontSize = 10;
h.FontSize = 15;