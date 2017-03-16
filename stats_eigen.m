function flag = stats_eigen(handles, A, poza, nrclasa, t)
global media_s;
global proiectie_s;
global V_s;
vec = zeros(10304, 1);
vec(:, 1) = reshape(poza, size(poza, 1) * size(poza, 2), 1);
vec = uint8(vec);
% tic
vec = vec - media_s;
pr_vec = single(vec)' * V_s;
z = [];
tag=get(get(handles.normagroup,'SelectedObject'),'Tag');
for i = 1 : size(proiectie_s, 1)
    x=proiectie_s(i, :);
    y=pr_vec;
    switch tag
        case 'norm1radiobutton', z = [z, norm(x-y,1)];
        case 'norm2radiobutton', z = [z, norm(x-y,2)];
        case 'norminfradiobutton', z = [z, norm(x-y,inf)];
        
    end
end
[~,i] = min(z);
if (t*(nrclasa-1)) < i && i <= (t*nrclasa)
    flag = true;
else
    flag = false;
end
% toc
end