function varargout = proj(varargin)
% PROJ MATLAB code for proj.fig
%      PROJ, by itself, creates a new PROJ or raises the existing
%      singleton*.
%
%      H = PROJ returns the handle to a new PROJ or the handle to
%      the existing singleton*.
%
%      PROJ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ.M with the given input arguments.
%
%      PROJ('Property','Value',...) creates a new PROJ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proj_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proj_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proj

% Last Modified by GUIDE v2.5 02-Dec-2019 16:15:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj_OpeningFcn, ...
                   'gui_OutputFcn',  @proj_OutputFcn, ...
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


% --- Executes just before proj is made visible.
function proj_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj (see VARARGIN)

% Choose default command line output for proj
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Video.
function Video_Callback(hObject, eventdata, handles)
% hObject    handle to Video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
[filename,filepath]=uigetfile('*.avi', 'Select a video');
fullname=[filepath filename];
vid=VideoReader(fullname);

% --- Executes on button press in speed.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
v = vid;
count=v.NumberOfFrames;
n1=130;
n2=470;
frame1=read(v,n1); 
frame2=read(v,n2);  
figure;
imshow (frame1);
figure;
imshow (frame2);
ttime=v.Duration;
fps=count/ttime;
ttime=(n2-n1)/fps;
im=rgb2gray(frame1);
im=im2bw(im,0.55);
[r,c,d]=size(im);
area1=0;
for i=1:r
    for j=1:c
        if im(i,j)==0
            area1=area1+1;
        end
    end
end
disp(area1);
rproj=0;
sproj=0;
for i=1:r
    for j=1:c
        if im (i,j)==0
            sproj=sproj+1;
        end
    end
    rproj=rproj+(i*sproj);
    sproj=0;
end
rcen=ceil(rproj/area1);
cen1=[];
cen1(1)=rcen;
sproj=0;
cproj=0;
for j=1:c
    for i=1:r
        if im (i,j)==0
            sproj=sproj+1;
        end
    end
    cproj=cproj+(j*sproj);
    sproj=0;
end
ccen=ceil(cproj/area1);
cen1(2)=ccen;
disp (cen1);
figure;
imshow (im);

im2=rgb2gray(frame2);
im2=im2bw(im2,0.55);
[r1,c1,d1]=size(im2);

area2=0;
for i=1:r1
    for j=1:c1
        if im2(i,j)==0
            area2=area2+1;
        end
    end
end
disp(area2);
rproj=0;
sproj=0;
for i=1:r
    for j=1:c
        if im2 (i,j)==0
            sproj=sproj+1;
        end
    end
    rproj=rproj+(i*sproj);
    sproj=0;
end
rcen=ceil(rproj/area2);
cen2=[];
cen2(1)=rcen;
sproj=0;
cproj=0;
for j=1:c
    for i=1:r
        if im2 (i,j)==0
            sproj=sproj+1;
        end
    end
    cproj=cproj+(j*sproj);
    sproj=0;
end
ccen=ceil(cproj/area2);
cen2(2)=ccen;
disp (cen2);
figure;
imshow (im2);
cen3=[];
cen3(2)=(cen2(2)-cen1(2));
ans=cen3(2)/3997;
set(handles.sp,'string',ans);

