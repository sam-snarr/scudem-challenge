

function system = scudemODEsystem2(t,y,A)

% g1 adjacency matrix for fad interaction

alpha = 3;
beta = 3;
gamma = 0.5;

L=length(A);

a_vector = y(1:L);
h_vector = y(L+1:2*L);

system = [
    
y(1)*(1-y(1))*(A(1,:)*a_vector + alpha*A(1,:)*h_vector);
y(2)*(1-y(2))*(A(2,:)*a_vector + alpha*A(2,:)*h_vector);


y(3)*(1-y(3))*(-beta*y(1)+gamma/y(1)+A(1,:)*h_vector);
y(4)*(1-y(4))*(-beta*y(2)+gamma/y(2)+A(2,:)*h_vector);

];