%function out=load_database(nrpozetraining, valbazadedate)
function out=load_database(handles, stats, training)
%declaram variabilele locale
done_ORL = 1;
persistent w_ORL;

done_CTOVD = 1;
persistent w_CTOVD;

if stats
    nrpozetraining = training;
else
    nrpozetraining = get(handles.popupmenutraining, 'Value');
end
valbazadedate = get(handles.popupmenudb, 'Value');

switch valbazadedate
    case 1, 
        if done_ORL==1 && done_CTOVD==1
            disp('Loading ORL dataset...')
            if stats == false
                m = msgbox('Loading ORL dataset...', 'modal');
            end
            done_ORL=0;
            % A=matricea baza de date, arg1=rezolutia unei poze, arg2=numarul de poze din baza de date
            A=zeros(10304,nrpozetraining*40);
            cd('ORL');
            for i=1:40
                % schimb folderul curent cu cel al persoanei ’si’
                cd(strcat('s',num2str(i)));
                for j=1:nrpozetraining
                    a=imread(strcat(num2str(j),'.pgm'));
                    A(:,(i-1)*nrpozetraining+j)=reshape(a,size(a,1)*size(a,2),1);
                end
                %revenim in folderul initial
                cd ..;
            end
            cd ..;
            w_ORL=A;
            disp('Loaded ORL dataset!')
            if stats == false
                delete(m);
            end
        end
        done_ORL=1;
        out = w_ORL;
    case 2, 
        if done_ORL==1 && done_CTOVD==1
            disp('Loading CTOVD dataset...')
            if stats == false
                m = msgbox('Loading CTOVD dataset...', 'modal');
            end
            done_CTOVD=0;
            % A=matricea baza de date, arg1=rezolutia unei poze, arg2=numarul de poze din baza de date
            A=zeros(10304,nrpozetraining*10);
            cd('CTOVD');
            for i=0:9
                % schimb folderul curent cu cel al cifrei ’cifrai’
                cd(strcat('cifra',num2str(i)));
                for j=1:nrpozetraining
                    a=imread(strcat(num2str(j),'.pgm'));
                    A(:,(i)*nrpozetraining+j)=reshape(a,size(a,1)*size(a,2),1);
                end
                %revenim in folderul initial
                cd ..;
            end
            cd ..;
            w_CTOVD=A;
            disp('Loaded CTOVD dataset!')
            if stats == false
                delete(m);
            end
        end
        done_CTOVD=1;
        out = w_CTOVD;
end