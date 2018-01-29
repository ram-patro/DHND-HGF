function varargout = demo_1(varargin)
% DEMO_1 MATLAB code for demo_1.fig
%      DEMO_1, by itself, creates a new DEMO_1 or raises the existing
%      singleton*.
%
%      H = DEMO_1 returns the handle to a new DEMO_1 or the handle to
%      the existing singleton*.
%
%      DEMO_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO_1.M with the given input arguments.
%
%      DEMO_1('Property','Value',...) creates a new DEMO_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demo_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demo_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demo_1

% Last Modified by GUIDE v2.5 14-Aug-2017 00:40:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demo_1_OpeningFcn, ...
                   'gui_OutputFcn',  @demo_1_OutputFcn, ...
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


% --- Executes just before demo_1 is made visible.
function demo_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demo_1 (see VARARGIN)

% Choose default command line output for demo_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demo_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demo_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_p_Callback(hObject, eventdata, handles)
% hObject    handle to slider_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.p=get(hObject,'Value')*0.9;
set(handles.text_p, 'String', strcat('p=',num2str(handles.p)));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.p=get(hObject,'Value')*0.9;
guidata(hObject,handles);

% --- Executes on button press in select_image.
function select_image_Callback(hObject, eventdata, handles)
% hObject    handle to select_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.filename,pathname] = uigetfile({'*.png';'*.jpg';'*.bmp'},'File Selector');
handles.S = imread(strcat(pathname, handles.filename));
axes(handles.axes1);
imshow(handles.S);title('input image S');
guidata(hObject,handles);

% --- Executes on slider movement.
function slider_m_Callback(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.m=round(get(hObject,'Value')*120);
set(handles.text_m, 'String', strcat('m=',num2str(handles.m)));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.m=round(get(hObject,'Value')*120);
guidata(hObject,handles);

% --- Executes on button press in add_noise.
function add_noise_Callback(hObject, eventdata, handles)
% hObject    handle to add_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X=noise_model(handles.S,[0 handles.m],[255-handles.m 255],handles.p/2,handles.p/2);
axes(handles.axes2);
imshow(handles.X);title('Noisy image X');
axes(handles.axes3);
h1=plot(imhist(handles.S),'LineWidth',2);hold on;h2=plot(imhist(handles.X),'r','LineWidth',2);legend([h1,h2],'original','noised');axis([0 256 0 max([imhist(handles.X);imhist(handles.S)])]);title('Histogram');hold off;
axes(handles.axes6);
handles.M=ground_truth_extract(handles.S,handles.X);
imshow(~handles.M);title('ground truth M = S # X')
guidata(hObject,handles);

% --- Executes on slider movement.
function slider_u_Callback(hObject, eventdata, handles)
% hObject    handle to slider_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.u=round(get(hObject,'Value')*14)+1;
handles.ft=fuzzy_membership(handles.u);
set(handles.text_u, 'String', strcat('u=',num2str(handles.u)));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_u_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.u=round(get(hObject,'Value')*14)+1;
handles.ft=fuzzy_membership(handles.u);
guidata(hObject,handles);


% --- Executes on button press in Fuzzy.
function Fuzzy_Callback(hObject, eventdata, handles)
% hObject    handle to Fuzzy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4);
plot(-handles.u:handles.u,handles.ft,'LineWidth',2);legend('ft');title('Membership');grid on;axis([-15 15 0 15]);
guidata(hObject,handles);


% --- Executes on button press in ND.
function ND_Callback(hObject, eventdata, handles)
% hObject    handle to ND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.N,handles.N1,handles.N2,handles.nh,handles.nhd,handles.b1,handles.b2]=noise_extract_proposed(handles.X,handles.ft);
axes(handles.axes7);imshow(~handles.N1);title('Noise mask 1 :: N1');
axes(handles.axes14);
max_limit=max([handles.nh;handles.nhd']);
min_limit=min([handles.nh;handles.nhd']);
h1=plot(handles.nh,'LineWidth',2);hold on;h2=plot(handles.nhd,'r','LineWidth',2);h3=plot(handles.b1,0,'y*','LineWidth',5);h4=plot(handles.b2,0,'g*','LineWidth',5);legend([h1,h2,h3,h4],'nh','nh''','b1','b2');axis([0 256 min_limit max_limit]);title({'Noise Histogram','& Derivative'});hold off;
axes(handles.axes8);imshow(~handles.N2);title('Noise mask 2 :: N2');
axes(handles.axes9);imshow(~handles.N);title('Final mask :: N');
axes(handles.axes10);imshow(handles.N~=handles.M);title('Deviation :: N # M');
axes(handles.axes3);
max_limit=max([imhist(handles.X);imhist(handles.S)]);
h1=plot(imhist(handles.S),'LineWidth',2);hold on;h2=plot(imhist(handles.X),'r','LineWidth',2);h3=stem(handles.b1,max_limit,'y','LineWidth',1);h4=stem(handles.b2,max_limit,'g','LineWidth',1);legend([h1,h2,h3,h4],'input','noised','b1','b2');axis([0 256 0 max_limit]);title('Histogram');hold off;
[handles.accuracy,handles.FA,handles.MD]=performance_measure_noise_detection(handles.M,handles.N1);
set(handles.text_N1FA, 'String',num2str(handles.FA));
set(handles.text_N1MD, 'String',num2str(handles.MD));
set(handles.text_N1ACC, 'String',num2str(handles.accuracy));
[handles.accuracy,handles.FA,handles.MD]=performance_measure_noise_detection(handles.M,handles.N);
set(handles.text_NFA, 'String',num2str(handles.FA));
set(handles.text_NMD, 'String',num2str(handles.MD));
set(handles.text_NACC, 'String',num2str(handles.accuracy));
set(handles.text_b1, 'String',num2str(handles.b1));
set(handles.text_b2, 'String',num2str(handles.b2));
set(handles.text_alpha, 'String',num2str(((handles.b1+255-handles.b2)/255)));
set(handles.text_mu, 'String',num2str(1-(numel(find(handles.N==1))/numel(handles.N))));
guidata(hObject,handles);


% --- Executes on button press in filtration.
function filtration_Callback(hObject, eventdata, handles)
% hObject    handle to filtration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.F]=filter_proposed(handles.X,handles.N,handles.b1,handles.b2);
axes(handles.axes11);imshow(handles.F);title('Filtered image F');
[handles.psnr,handles.ssim,handles.ief,handles.fsim]=performance_measure_filteration(handles.S,handles.F,handles.X);
set(handles.text_PSNR, 'String',num2str(handles.psnr));
set(handles.text_FSIM, 'String',num2str(handles.fsim));
set(handles.text_SSIM, 'String',num2str(handles.ssim));
set(handles.text_IEF, 'String',num2str(handles.ief));
guidata(hObject,handles);


% --- Executes on slider movement.
function slider_row_Callback(hObject, eventdata, handles)
% hObject    handle to slider_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.row=round(get(hObject,'Value')*size(handles.S,1));
set(handles.text_row, 'String',strcat('r=',num2str(handles.row)));
axes(handles.axes2);imshow(handles.X);hold on; plot(handles.col,handles.row,'s','Color','w','LineWidth',5);hold off;title('Noisy X with W');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.row=1;
guidata(hObject,handles);

% --- Executes on slider movement.
function slider_col_Callback(hObject, eventdata, handles)
% hObject    handle to slider_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.col=round(get(hObject,'Value')*size(handles.S,2));
set(handles.text_col, 'String',strcat('c=',num2str(handles.col)));
axes(handles.axes2);imshow(handles.X);hold on; plot(handles.col,handles.row,'s','Color','w','LineWidth',5);hold off;title('Noisy X with W');
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.col=1;
guidata(hObject,handles);


% --- Executes on button press in pushbutton_WND.
function pushbutton_WND_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_WND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.w,handles.h,handles.hf,handles.a1,handles.a2,handles.status,handles.pixel_st]=noise_extract_proposed_check(handles.X,handles.row,handles.col,handles.ft);
handles.gt=handles.M(handles.row,handles.col);
axes(handles.axes12);imshow(uint8(handles.w));title(sprintf('W(%d,%d) :Size (21 x 21)',handles.row,handles.col));
axes(handles.axes13);
max_limit=max(max(([handles.h;handles.hf])));
h1=plot(handles.h,'LineWidth',2);hold on;h2=plot(handles.hf,'r','LineWidth',2);h3=stem(handles.a1,max_limit,'y','LineWidth',1);h4=stem(handles.a2,max_limit,'g','LineWidth',1);legend([h1,h2,h3,h4],'h','hf','a1','a2');axis([0 256 0 max_limit]);title('Fuzzy Histogram');hold off;
set(handles.text_status,'String',num2str(handles.status));
set(handles.text_pixel_st,'String',num2str(~handles.pixel_st));
set(handles.text_gt,'String',num2str(~handles.gt));
if(handles.gt==handles.pixel_st)
    dsp='Succeed';
else
    dsp='Failed';
end
set(handles.text_match,'String',dsp);
guidata(hObject,handles);


% --- Executes on button press in pushbutton_snap.
function pushbutton_snap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=strcat('m_',num2str(handles.m),'_p_',num2str(handles.p),'_u_',num2str(handles.u),'_',handles.filename);
path=strcat(pwd,'\snap_shot\',name);
fig=gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 16 9];
saveas(fig,path);
guidata(hObject,handles);


% --- Executes on slider movement.
function slider_gauss_Callback(hObject, eventdata, handles)
% hObject    handle to slider_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ws=round(get(hObject,'Value')*30)+1;
set(handles.text_gauss,'String',strcat('k=',num2str(handles.ws)));
axes(handles.axes15);
[X,Y,gk]=gaussian_fun(handles.ws);
surfc(X,Y,gk);axis([min(X(:)) max(X(:)) min(Y(:)) max(Y(:)) 0 1]);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_gauss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
handles.ws=3;
guidata(hObject,handles);
