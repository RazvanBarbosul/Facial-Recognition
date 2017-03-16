function timp = stats_eigen_preprocesare(A)
global media_s;
global proiectie_s;
global V_s;
[n m] = size(A);
timer_preproc = tic;
media_s = uint8(mean(A,2));
O = uint8(ones(1,m));
Ab = uint8(A) - uint8(single(media_s)* single(O));
L = single(Ab)' * single(Ab);
[V_s,~] = eig(L);
V_s = single(Ab) * V_s;
[x y] = size(V_s);
if y > 50
    N = 50; % Lucrez cu 50 de vectori proprii
else
    N = y;
end
V_s = V_s(:, end:-1:end-(N-1));
proiectie_s = zeros(m,N);
for i=1:m
	proiectie_s(i,:) = single(Ab(:,i))'*V_s;
end
timp = toc(timer_preproc);
end