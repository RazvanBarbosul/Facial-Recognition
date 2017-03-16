function timp = eigen(handles)
timer_cautare = tic;
global poza;
global media;
global proiectie;
global A;
global V;
vec = zeros(10304, 1);
vec(:, 1) = reshape(poza, size(poza, 1) * size(poza, 2), 1);
vec = uint8(vec);
% tic
vec = vec - media;
pr_vec = single(vec)' * V;
z = [];
tag=get(get(handles.normagroup,'SelectedObject'),'Tag');
for i = 1 : size(proiectie, 1)
    x=proiectie(i, :);
    y=pr_vec;
    switch tag
        case 'norm1radiobutton', z = [z, norm(x-y,1)];
        case 'norm2radiobutton', z = [z, norm(x-y,2)];
        case 'norminfradiobutton', z = [z, norm(x-y,inf)];
    end
end
[~,i] = min(z);
timp = toc(timer_cautare);
axes(handles.axes2)
imagesc(reshape(A(:, i), 112, 92));
set(handles.axes2,'visible','off');
axis image;
% toc
end

