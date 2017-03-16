function varargout = proiect(varargin)
% PROIECT MATLAB code for proiect.fig
%      PROIECT, by itself, creates a new PROIECT or raises the existing
%      singleton*.
%
%      H = PROIECT returns the handle to a new PROIECT or the handle to
%      the existing singleton*.
%
%      PROIECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROIECT.M with the given input arguments.
%
%      PROIECT('Property','Value',...) creates a new PROIECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proiect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proiect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proiect

% Last Modified by GUIDE v2.5 01-Jan-2017 13:26:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proiect_OpeningFcn, ...
                   'gui_OutputFcn',  @proiect_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before proiect is made visible.
function proiect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proiect (see VARARGIN)

% Choose default command line output for proiect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proiect wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc
set(handles.normagroup,'SelectedObject',handles.norm2radiobutton);
xlabel(handles.axes4, 'Nr. poze training');
ylabel(handles.axes4, 'Rata de recunoastere (%)');

xlabel(handles.axes5, 'Nr. poze training');
ylabel(handles.axes5, 'Timp executie (ms)');

xlabel(handles.axes6, 'Nr. poze training');
ylabel(handles.axes6, 'Timp preprocesare (s)');
global A;
A=load_database(handles, false, 0);
global isselected;
isselected = false;


% --- Outputs from this function are returned to the command line.
function varargout = proiect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenudb.
function popupmenudb_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenudb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenudb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenudb
clear_selected_image(handles);
clear_stats(handles);
reloadUI(handles);
global A;
A=load_database(handles, false, 0);
reloadEigen(handles);

function reloadUI(handles)
if get(handles.popupmenudb, 'Value') == 1
    set(handles.persoanacifrapopupmenu,'String',{1:40});
else
    set(handles.persoanacifrapopupmenu,'String',{0:9});
end
set(handles.persoanacifrapopupmenu, 'Value', 1);
set(handles.variantapopupmenu,'String',{get(handles.popupmenutraining,'Value')+5:10});
set(handles.variantapopupmenu, 'Value', 1);

% --- Executes during object creation, after setting all properties.
function popupmenudb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenudb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% Populare initiala a listei
set(hObject,'String',{'ORL (faces)';'CTOVD (numbers)'});


% --- Executes on selection change in popupmenutraining.
function popupmenutraining_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenutraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenutraining contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenutraining
reloadUI(handles);
global A;
A=load_database(handles, false, 0);
reloadEigen(handles)


% --- Executes during object creation, after setting all properties.
function popupmenutraining_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenutraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% Populare initiala a listei
set(hObject,'String',{5:9});
set(hObject,'Value',4);


% --- Executes on button press in cautapushbutton.
function cautapushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cautapushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isselected;
if isselected == true
    switch get(get(handles.algoritmgroup,'SelectedObject'),'Tag')
        case 'nnradiobutton',  timp = nn(handles);
        case 'knnradiobutton', timp = knn(handles);
        case 'eigenradiobutton', timp = eigen(handles);
        otherwise, timp = 0;
    end
else
    warndlg('Selectati o imagine inainte de a efectua cautarea!', 'Atentie');
end


% --- Executes on selection change in persoanacifrapopupmenu.
function persoanacifrapopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to persoanacifrapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns persoanacifrapopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from persoanacifrapopupmenu


% --- Executes during object creation, after setting all properties.
function persoanacifrapopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to persoanacifrapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{1:40});


% --- Executes on selection change in variantapopupmenu.
function variantapopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to variantapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns variantapopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from variantapopupmenu


% --- Executes during object creation, after setting all properties.
function variantapopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variantapopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{9:10});


% --- Executes on button press in selectpushbutton.
function selectpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to selectpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isselected;
global poza;
if get(handles.popupmenudb, 'Value') == 1
    cd('ORL');
    list = get(handles.persoanacifrapopupmenu,'String');
    cd(strcat('s', list{get(handles.persoanacifrapopupmenu,'Value')}));
else
    cd('CTOVD');
    list = get(handles.persoanacifrapopupmenu,'String');
    cd(strcat('cifra', list{get(handles.persoanacifrapopupmenu,'Value')}));
end
listvarianta = get(handles.variantapopupmenu,'String');
poza=imread(strcat(listvarianta{get(handles.variantapopupmenu,'Value')}, '.pgm'));
axes(handles.axes1);
cla
colormap(gray);
imagesc(poza);
set(handles.axes1,'visible','off');
axis image;
grid off;
cd ..\..;
isselected = true;



% --- Executes when selected object is changed in algoritmgroup.
function algoritmgroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in algoritmgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_stats(handles);
switch get(get(handles.algoritmgroup,'SelectedObject'),'Tag')
    case 'knnradiobutton',  set(handles.kval,'Enable','on');
    otherwise, set(handles.kval,'Enable','off');
end
reloadEigen(handles);

function reloadEigen(handles)
switch get(get(handles.algoritmgroup,'SelectedObject'),'Tag')
    case 'eigenradiobutton',  
        eigen_preprocesare(handles);
end


% --- Executes during object creation, after setting all properties.
function normagroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normagroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in kval.
function kval_Callback(hObject, eventdata, handles)
% hObject    handle to kval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kval contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kval


% --- Executes during object creation, after setting all properties.
function kval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {3:9});


% --- Executes on button press in clearpushbutton.
function clearpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clearpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_result_image(handles);

function clear_selected_image(handles)
global isselected;
cla(handles.axes1);
isselected = false;
clear_result_image(handles)

function clear_result_image(handles)
cla(handles.axes2);


% --- Executes on button press in genereazastatisticipushbutton.
function genereazastatisticipushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to genereazastatisticipushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stats(handles);

function clear_stats(handles)
cla(handles.axes4);
cla(handles.axes5);
cla(handles.axes6);


% --- Executes when selected object is changed in normagroup.
function normagroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in normagroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_stats(handles);
