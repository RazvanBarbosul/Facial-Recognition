function eigen_preprocesare(handles)
global A;
global media;
global proiectie;
global V;
[n m] = size(A);
% tic
% Se calculeaza vectorul medie
media = uint8(mean(A,2));
O = uint8(ones(1,m));
% Se scade vectorul medie din toti vectorii
Ab = uint8(A) - uint8(single(media)* single(O));
% Se calculeaza matricea de covarianta
L = single(Ab)' * single(Ab);
% Se salveaza vectorii proprii in variabila V
[V,D] = eig(L);
% V = vectori proprii
% D = valori proprii
V = single(Ab) * V;
[x y] = size(V);
if y > 50
    N = 50; % Lucrez cu 50 de vectori proprii
else
    N = y;
end
V = V(:, end:-1:end-(N-1)); % Citeste ultimii 50 vect. proprii din matrice
proiectie = zeros(m,N);
for i=1:m
	proiectie(i,:) = single(Ab(:,i))'*V;
end
% toc
end

