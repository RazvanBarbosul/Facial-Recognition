function stats(handles)
x=[];
y_ratarec=[];
y_query=[];
y_preproc=[];
btn_algoritm = get(get(handles.algoritmgroup,'SelectedObject'),'Tag');
for t = 5:9
    m = msgbox(strcat('Se genereaza statisticile (', num2str(t), '/', num2str(9), ')'), 'modal');
    count = 0;
    totalcount = 0;
    query_tmp=[];
    x = [x t];
    A = load_database(handles, true, t);
    if strcmp(btn_algoritm, 'eigenradiobutton')
        y_preproc = [y_preproc stats_eigen_preprocesare(A)];
    end
    if get(handles.popupmenudb, 'Value') == 1
        cd('ORL');
        for i=1:40
            cd(strcat('s', num2str(i)));
            [count, totalcount, query_tmp] = read_class_pictures(handles,A,i,t,count,totalcount,btn_algoritm, query_tmp);
            cd ..;
        end
    else
        cd('CTOVD');
        for i=0:9
            cd(strcat('cifra', num2str(i)));
            [count, totalcount, query_tmp] = read_class_pictures(handles,A,i,t,count,totalcount,btn_algoritm, query_tmp);
            cd ..;
        end
    end
    cd ..;
    y_ratarec = [y_ratarec ((count*100)/totalcount)];
    y_query = [y_query mean(query_tmp)];
end
delete(m);

%Axes4
plot(handles.axes4, x, y_ratarec);
set(handles.axes4, 'Xlim', [5 9]);
set(handles.axes4, 'Ylim', [0 100]);
xlabel(handles.axes4, 'Nr. poze training');
ylabel(handles.axes4, 'Rata de recunoastere (%)');
set(handles.axes4, 'XTick', [5,6,7,8,9]);
set(handles.axes4, 'YTick', [0,20,40,60,80,100]);
set(handles.axes4, 'XGrid', 'On');
set(handles.axes4, 'YGrid', 'On');

%Axes5
plot(handles.axes5, x, y_query);
set(handles.axes5, 'Xlim', [5 9]);
xlabel(handles.axes5, 'Nr. poze training');
ylabel(handles.axes5, 'Timp executie (ms)');
set(handles.axes5, 'XTick', [5,6,7,8,9]);
set(handles.axes5, 'XGrid', 'On');
set(handles.axes5, 'YGrid', 'On');

%Axes6
if strcmp(btn_algoritm, 'eigenradiobutton')
    plot(handles.axes6, x, y_preproc);
    set(handles.axes6, 'Xlim', [5 9]);
    xlabel(handles.axes6, 'Nr. poze training');
    ylabel(handles.axes6, 'Timp preprocesare (s)');
    set(handles.axes6, 'XTick', [5,6,7,8,9]);
    set(handles.axes6, 'XGrid', 'On');
    set(handles.axes6, 'YGrid', 'On');
end
end

function [count, totalcount, query_tmp] = read_class_pictures(handles,A,i,t,count,totalcount,btn_algoritm, query_tmp)
for k=(t+1):10
    poza = imread(strcat(num2str(k), '.pgm'));
    timer_query = tic;
    switch btn_algoritm
        case 'nnradiobutton',
            if stats_nn(handles, A, poza, i, t)==true
                count = count + 1;
            end
        case 'knnradiobutton'
            if stats_knn(handles, A, poza, i, t)==true
                count = count + 1;
            end
        case 'eigenradiobutton'
            if stats_eigen(handles, A, poza, i, t)==true
                count = count + 1;
            end
    end
    query_tmp=[query_tmp toc(timer_query)*1000];
    totalcount = totalcount + 1;
end
end

