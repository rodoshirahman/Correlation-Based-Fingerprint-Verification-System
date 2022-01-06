function varargout = fingerprint_recognition(varargin)
% FINGERPRINT_RECOGNITION MATLAB code for fingerprint_recognition.fig
%      FINGERPRINT_RECOGNITION, by itself, creates a new FINGERPRINT_RECOGNITION or raises the existing
%      singleton*.
%
%      H = FINGERPRINT_RECOGNITION returns the handle to a new FINGERPRINT_RECOGNITION or the handle to
%      the existing singleton*.
%
%      FINGERPRINT_RECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINT_RECOGNITION.M with the given input arguments.
%
%      FINGERPRINT_RECOGNITION('Property','Value',...) creates a new FINGERPRINT_RECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fingerprint_recognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fingerprint_recognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fingerprint_recognition

% Last Modified by GUIDE v2.5 06-Apr-2019 21:25:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fingerprint_recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @fingerprint_recognition_OutputFcn, ...
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


% --- Executes just before fingerprint_recognition is made visible.
function fingerprint_recognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fingerprint_recognition (see VARARGIN)

% Choose default command line output for fingerprint_recognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fingerprint_recognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fingerprint_recognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile('*.jpg;*.bmp;*.jpeg;*.png;*.tif;','dataset Images');
imgname=[pathname filename];
a = imread(imgname);
a = imresize(a, [400 400]);
setappdata(0,'filename',imgname);
axes(handles.axes3)
imshow(a);
setappdata(0,'a',a);
setappdata(0,'filename',a);
title('Raw image')
%set(handles.text3,'string',imgname)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oimg=getappdata(0,'a');
[rows, columns, numberOfColorChannels] = size(oimg);
if numberOfColorChannels == 3    
   img_gray=rgb2gray(oimg);
end
if numberOfColorChannels < 2
    img_gray = oimg;
end
img_histogram=imhist(uint8(img_gray)); 
axes(handles.axes5);
plot(img_histogram);
setappdata(0,'filename',img_gray);
title('Image Histogam');

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oimg=getappdata(0,'filename');
equal_histogram = histeq(oimg);
axes(handles.axes3);
plot(equal_histogram);
title('Equalized Histogam');
axes(handles.axes5);
imshow(equal_histogram);
title('Image after Equalization');
setappdata(0,'filename',equal_histogram);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(~, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oimg=getappdata(0,'filename');
img_filter = medfilt2(oimg);
axes(handles.axes3);
imshow(img_filter); 
title('Image after Filtering ');
setappdata(0,'filename',img_filter);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=getappdata(0,'filename');
x=double(x);
tot=0;
[a,b]=size(x);
y=zeros(a,b);
for i=1:a
    for j=1:b
        tot=tot+x(i,j);
    end
end
thr=tot/(a*b);
for i=1:a
    for j=1:b
        if x(i,j) > thr
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end
axes(handles.axes3);
imshow(y);
title('Binarized Image');

K=bwmorph(y,'thin','inf');
axes(handles.axes5);
imshow(K);
title('Image after Thinning');
setappdata(0,'filename',K);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_img = getappdata(0,'filename');
filter = {'*.jpg;*.bmp;*.jpeg;*.png;*.tif;*.*'};
[filename, foldername] = uiputfile(filter,'Processed Images');
complete_name = fullfile(foldername, filename);
imwrite(data_img, complete_name);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.jpg;*.bmp;*.jpeg;*.png;*.tif;','image for template matching');
imgname=[pathname filename];
template = imread(imgname);
axes(handles.axes3);
imshow(template);
title('Template');
setappdata(0,'tempname',template);

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% 1. initialization
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Read an Image A(Template)
A = getappdata(0,'filename');

%Read the Target Image
B = getappdata(0,'tempname');
[~,~,dim] = size(B);
if dim == 3
    B = rgb2gray(B);
end
c = normxcorr2(B,A); 
axes(handles.axes3);
surf(c), shading flat
title('Correlation graph');

[ypeak, xpeak] = find(c==max(c(:)));

yoffSet = ypeak-size(B,1);
xoffSet = xpeak-size(B,2);

axes(handles.axes5);
imshow(A);
title('Final Image with matched Template');
imrect(gca, [xoffSet+1, yoffSet+1, size(B,2), size(B,1)]);


%matlab code that i have used for cropping the image
% I = imread('F:\CSE 4.2\Digital Image Processing\Lab\Project\B2_01_DIP\Project\Processed Images\model 2\8.jpg');
%[J, rect] = imcrop(I);
%data_img = J;
%filter = {'*.jpg;*.bmp;*.jpeg;*.png;*.tif;*.*'};
%[filename, foldername] = uiputfile(filter,'Processed Images');
%complete_name = fullfile(foldername, filename);
%imwrite(data_img, complete_name);
