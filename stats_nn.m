function flag = stats_nn(handles, A, poza, nrclasa, t)
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
if (t*(nrclasa-1)) < k && k <= (t*nrclasa)
    flag = true;
else
    flag = false;
end
end