function timp = nn(handles)
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
[~,k]=min(z);
timp = toc(timer_cautare);
axes(handles.axes2);
imagesc(reshape(A(:,k),112,92));
set(handles.axes2,'visible','off');
axis image;
end

