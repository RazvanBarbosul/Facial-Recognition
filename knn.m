function timp = knn(handles)
timer_cautare = tic;
global poza; global A;
vec=zeros(10304,1);
vec(:,1)=reshape(poza,size(poza,1)*size(poza,2),1);
z=[];
tag=get(get(handles.normagroup,'SelectedObject'),'Tag');
for i=1:size(A,2)
    x=A(:,i);
    y=vec;
    switch tag
        case 'norm1radiobutton', z=[z norm(x-y,1)];
        case 'norm2radiobutton', z=[z norm(x-y,2)];
        case 'norminfradiobutton', z=[z norm(x-y,inf)];
    end
end
z2=zeros(3, size(z, 2));
for i=1:size(z, 2)
    z2(:,i)=[z(i); i; ceil(i/8)]; %norma, pozitia, clasa
end
z2=sortrows(z2',1)';
list = get(handles.kval,'String');
k=str2num(list{get(handles.kval,'Value')});
disp('k')
disp(k)
z3=zeros(1, k);
for i=1:k
    z3(i)=z2(3,i);
end
disp('z3')
disp(z3)
x=unique(z3);
disp('x')
disp(x)
count=zeros(1, numel(x));
for i=1:numel(x)
    count(i)=sum(z3==x(i));
end
disp('count')
disp(count)
[el, poz]=max(count);
disp(el);
disp(poz);
clasa=x(poz);

for i=1:k
    if z2(3,i)==clasa
        disp('changed')
        poz = z2(2,i);
        break;
    end
end
timp = toc(timer_cautare);
axes(handles.axes2);
imagesc(reshape(A(:, poz),112,92));
set(handles.axes2,'visible','off');
axis image;
end

