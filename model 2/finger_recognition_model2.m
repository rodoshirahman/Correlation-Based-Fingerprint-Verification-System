function varargout = finger_recognition_model2(varargin)
% FINGER_RECOGNITION_MODEL2 MATLAB code for finger_recognition_model2.fig
%      FINGER_RECOGNITION_MODEL2, by itself, creates a new FINGER_RECOGNITION_MODEL2 or raises the existing
%      singleton*.
%
%      H = FINGER_RECOGNITION_MODEL2 returns the handle to a new FINGER_RECOGNITION_MODEL2 or the handle to
%      the existing singleton*.
%
%      FINGER_RECOGNITION_MODEL2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGER_RECOGNITION_MODEL2.M with the given input arguments.
%
%      FINGER_RECOGNITION_MODEL2('Property','Value',...) creates a new FINGER_RECOGNITION_MODEL2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before finger_recognition_model2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to finger_recognition_model2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help finger_recognition_model2

% Last Modified by GUIDE v2.5 11-Apr-2019 01:39:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finger_recognition_model2_OpeningFcn, ...
                   'gui_OutputFcn',  @finger_recognition_model2_OutputFcn, ...
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


% --- Executes just before finger_recognition_model2 is made visible.
function finger_recognition_model2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to finger_recognition_model2 (see VARARGIN)

% Choose default command line output for finger_recognition_model2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes finger_recognition_model2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = finger_recognition_model2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile('*.jpg;*.bmp;*.jpeg;*.png;*.tif;','dataset Images');
imgname=[pathname filename];
a = imread(imgname);
a = imresize(a, [400 400]);
setappdata(0,'filename',imgname);
axes(handles.axes1)
imshow(a);
setappdata(0,'a',a);
setappdata(0,'filename',a);
title('Raw image');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
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
axes(handles.axes2);
plot(img_histogram);
setappdata(0,'filename',img_gray);
title('Image Histogam');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

oimg=getappdata(0,'filename');
equal_histogram = adapthisteq(oimg);
axes(handles.axes1);
plot(equal_histogram);
title('Equalized Histogam');
axes(handles.axes2);
imshow(equal_histogram);
title('Image after CLAHE');
setappdata(0,'filename',equal_histogram);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%IM=getappdata(0,'filename');                     % Display image
%FF = fft(IM);                   % Take FFT
%IFF = ifft(FF);                 % take IFFT
%FINAL_IM = uint8(real(IFF));      % Take real part and convert back to UINT8
%axes(handles.axes1);
%imshow(FINAL_IM);
%title('Image after Fourier Transform');
%setappdata(0,'filename',FINAL_IM);

IM=getappdata(0,'filename');     % Read in a image
FF = fft(IM);  % Take FFT

IFF = ifft((FF));                 % take IFFT
FINAL_IM = uint8((IFF));      % Take real part and convert back to UINT8

axes(handles.axes1);   
imshow(FINAL_IM);
title('Image after Fourier Transform');

 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = getappdata(0,'filename');      % read image
T = adaptthresh(I);                % find the threshold for input image
S = imbinarize(I,T);               % Segment the image using thresholding

axes(handles.axes1);
imshow(S);
title('Binarized Image');
setappdata(0,'filename',S);


K=bwmorph(S,'thin','inf');
axes(handles.axes2);
imshow(K);
title('Image after Thinning');
setappdata(0,'filename',K);


%[Path,File] = uiputfile('*.jpg');% Save the thresholded image with .jpg extention
%imwrite(S,[File,Path]);         % Save the thresholded image to the specified path
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_img = getappdata(0,'filename');
filter = {'*.jpg;*.bmp;*.jpeg;*.png;*.tif;*.*'};
[filename, foldername] = uiputfile(filter,'Processed Images');
complete_name = fullfile(foldername, filename);
imwrite(data_img, complete_name);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.jpg;*.bmp;*.jpeg;*.png;*.tif;','image for template matching');
imgname=[pathname filename];
template = imread(imgname);
axes(handles.axes1);
imshow(template);
title('Template');
setappdata(0,'tempname',template);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%new
%Read an Image A(Template)
A = getappdata(0,'filename');

%Read the Target Image
B = getappdata(0,'tempname');
[~,~,dim] = size(B);
if dim == 3
    B = rgb2gray(B);
end

 %Pad the image matrix B with zeros
B1 = zeros([size(A,1),size(A,2)]);
B1(1:size(B,1),1:size(B,2))=B(:,:,1);

 %Apply Fourier Transform
Signal1 = fftshift(fft2(A(:,:,1)));
Signal2 = fftshift(fft2(B1));

%Mulitply Signal1 with the conjugate of Signal2
R = Signal1 .*conj(Signal2);

%Normalize the result
Ph = R./abs(R);

%Apply inverse fourier transform
IFT = ifft2(fftshift(Ph));


 %Find the maximum value
maxpt = max(real(IFT(:)));

%Find the pixel position of the maximum value
[x,y]= find(real(IFT)==maxpt);


axes(handles.axes1);
imagesc(B);axis image
title('Template');

axes(handles.axes2);
imagesc(A(x:x+size(B,1),y:y+size(B,2),:));axis image
title('Matched Portion of Main Image');
