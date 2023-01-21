function varargout = BrainTumorDetection(varargin)
% BRAINTUMORDETECTION MATLAB code for BrainTumorDetection.fig
%      BRAINTUMORDETECTION, by itself, creates a new BRAINTUMORDETECTION or raises the existing
%      singleton*.
%
%      H = BRAINTUMORDETECTION returns the handle to a new BRAINTUMORDETECTION or the handle to
%      the existing singleton*.
%
%      BRAINTUMORDETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAINTUMORDETECTION.M with the given input arguments.
%
%      BRAINTUMORDETECTION('Property','Value',...) creates a new BRAINTUMORDETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrainTumorDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrainTumorDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrainTumorDetection

% Last Modified by GUIDE v2.5 06-Aug-2021 10:16:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrainTumorDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @BrainTumorDetection_OutputFcn, ...
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


% --- Executes just before BrainTumorDetection is made visible.
function BrainTumorDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrainTumorDetection (see VARARGIN)

% Choose default command line output for BrainTumorDetection
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('brainbcg.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
%uistack(ah, 'bottom');

%%h = handles.axes_izmena0
%h.YAxis.Visible = 'off'; 
%h.XAxis.Visible = 'off';
%h = handles.axes_izmena1
%h.YAxis.Visible = 'off'; 
%h.XAxis.Visible = 'off';
%h = handles.axes_izmena2
%h.YAxis.Visible = 'off'; 
%h.XAxis.Visible = 'off';
%h = handles.axes_izmena4
%h.YAxis.Visible = 'off'; 
%h.XAxis.Visible = 'off';
%h = handles.axes_ucitana
%h.YAxis.Visible = 'off'; 
%h.XAxis.Visible = 'off';
% UIWAIT makes BrainTumorDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.ucitajSliku,'Enable','on');
set(handles.tresholdedImage,'Enable','off');
set(handles.watershedImage,'Enable','off');
set(handles.tumorDetect,'Enable','off');
set(handles.grayImage,'Enable','off');

set(handles.uipanel2,'visible','off');
set(handles.uipanel3,'visible','off');
set(handles.uipanel4,'visible','on');

% --- Outputs from this function are returned to the command line.
function varargout = BrainTumorDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ucitajSliku.
function ucitajSliku_Callback(hObject, eventdata, handles)
% hObject    handle to ucitajSliku (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.tresholdedImage,'Enable','off');
set(handles.watershedImage,'Enable','off');
set(handles.tumorDetect,'Enable','off');
set(handles.grayImage,'Enable','off');

cla
cla(handles.axes_ucitana)
cla reset
cla(handles.axes_ucitana,'reset')
cla
cla(handles.axes_izmena1)
cla reset
cla(handles.axes_izmena1,'reset')
cla
cla(handles.axes_izmena0)
cla reset
cla(handles.axes_izmena0,'reset')
cla
cla(handles.axes_izmena2)
cla reset
cla(handles.axes_izmena2,'reset')
%cla
%cla(handles.axes_izmena3)
%cla reset
%cla(handles.axes_izmena3,'reset')
cla
cla(handles.axes_izmena4)
cla reset
cla(handles.axes_izmena4,'reset')

set(handles.tb_decected,'String','')

[fname, fpath] = uigetfile('*', 'Izaberite sliku:'); % UCITAVANJE U PRVI PROZORCIC 
handles.slika_ucitana = imread([fpath, fname]);

set(handles.uipanel2,'visible','off');
set(handles.uipanel3,'visible','on');
set(handles.uipanel4,'visible','off');

axes(handles.axes_ucitana)
imshow(handles.slika_ucitana);
title('Ucitana slika:')

set(handles.ucitajSliku,'Enable','off');
set(handles.grayImage,'Enable','on');

guidata(hObject, handles);


% --- Executes on button press in tresholdedImage.
function tresholdedImage_Callback(hObject, eventdata, handles)
% hObject    handle to tresholdedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%level = graythresh(I) computes a global threshold (level) that 
%can be used to convert an intensity image to 
%a binary image with im2bw
%level is a normalized intensity value that lies in the range [0, 1].
%level=0.6 or level = 0.7

level=graythresh(handles.I1)
handles.I1= im2bw(handles.I1,0.6);

axes(handles.axes_izmena1);
imshow(handles.I1);
title('Thresholded segmentacija');

set(handles.tresholdedImage,'Enable','off');
set(handles.watershedImage,'Enable','on');


guidata(hObject, handles);


% --- Executes on button press in watershedImage.
function watershedImage_Callback(hObject, eventdata, handles)
% hObject    handle to watershedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.I2 = imgradient(handles.I1);
handles.I2 = watershed(handles.I2);
handles.I2 = label2rgb(handles.I2);
axes(handles.axes_izmena2);
imshow(handles.I2);
title('Watershed segmentacija');

se = strel('disk', 10);
handles.Io = imopen(handles.I1, se);
handles.Ie = imerode(handles.I1, se);
handles.Iobr = imreconstruct(handles.Ie, handles.I1);
handles.Iobrd = imdilate(handles.Iobr, se);
handles.Iobrcbr = imreconstruct(imcomplement(handles.Iobrd), imcomplement(handles.Iobr));
handles.Iobrcbr = imcomplement(handles.Iobrcbr);
handles.I2 = handles.I1;
handles.fgm = imregionalmax(handles.Iobrcbr);
handles.I2(handles.fgm) = 255;
se2 = strel(ones(5,5));
handles.fgm2 = imclose(handles.fgm, se2);
handles.fgm3 = imerode(handles.fgm2, se2);
handles.fgm4 = bwareaopen(handles.fgm3, 20);
handles.I3 = handles.I1;
handles.bw = handles.Iobrcbr;

%axes(handles.axes_izmena3);
%imshow(handles.bw);
%title('Only tumor. Regional Maxima of Opening-Closing by Reconstruction');

set(handles.watershedImage,'Enable','off');
set(handles.tumorDetect,'Enable','on');

guidata(hObject, handles);


% --- Executes on button press in grayImage.
function grayImage_Callback(hObject, eventdata, handles)
% hObject    handle to grayImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of grayImage

handles.I1 = imresize(handles.slika_ucitana,[200,200]);
[rows, columns, numberOfColorChannels] = size(handles.I1);
if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    handles.I1 = rgb2gray(handles.I1);
else
    % It's already gray scale.  No need to convert.
    handles.I1 = handles.I1;
end

%handles.I1 = imresize(handles.slika_ucitana,[200,200]);
%handles.I1= rgb2gray(handles.I1);

axes(handles.axes_izmena0);
imshow(handles.I1);
title('Grayscale slika');

set(handles.grayImage,'Enable','off');
set(handles.tresholdedImage,'Enable','on');
set(handles.grayImage,'value',0);
guidata(hObject, handles);


% --- Executes on button press in tumorDetect.
function tumorDetect_Callback(hObject, eventdata, handles)
% hObject    handle to tumorDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel2,'visible','on');
set(handles.uipanel3,'visible','on');
set(handles.uipanel4,'visible','off');

handles.slika_ucitana = imresize(handles.slika_ucitana,[200,200]);
axes(handles.axes_izmena4);
imshow(handles.slika_ucitana, []);
%title('Outlined tumor');

boundaries = bwboundaries(handles.bw);
if length(boundaries) ~= 0 
    detected = "DETEKTOVAN JE TUMOR";
    
else
    detected = "TUMOR NIJE DETEKTOVAN";
end

set(handles.tb_decected,'String',detected);
hold on;
for k = 1 : length(boundaries)
    thisBoundary = boundaries{k};
    x = thisBoundary(:, 2); % Column
    y = thisBoundary(:, 1); % Row
    plot(x, y, 'r-', 'LineWidth', 1.5);
end

set(handles.tumorDetect,'Enable','off');
set(handles.ucitajSliku,'Enable','on');

guidata(hObject, handles);



function tb_decected_Callback(hObject, eventdata, handles)
% hObject    handle to tb_decected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tb_decected as text
%        str2double(get(hObject,'String')) returns contents of tb_decected as a double


% --- Executes during object creation, after setting all properties.
function tb_decected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tb_decected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exitbt.
function exitbt_Callback(hObject, eventdata, handles)
% hObject    handle to exitbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq(); 
