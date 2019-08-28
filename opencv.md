# Build 

[参考ページ](ttps://www.trifields.jp/how-to-install-opencv-on-ubuntu-2742)

```

sudo apt install build-essential cmake ccache git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libgtk-3-dev libjpeg-dev libpng++-dev libtbb2 libtbb-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-de ffmpeg checkinstall 

sudo apt install cmake ecm extra-cmake-modules fcitx-libs-dev libfcitx-qt5-1 mesa-utils build-essential git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev x264 libxvidcore-dev yasm libxine2-dev libv4l-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils ffmpeg libdc1394-22 libdc1394-22-dev libtiff5-dev unzip qt5-default libeigen3-dev libeigen3-doc tesseract-ocr tesseract-ocr-jpn vtk6 tcl-vtk6 python-vtk6 libgflags-dev autoconf automake libtool autoconf-archive libleptonica-dev libtesseract-dev gphoto2 liblapacke-dev libgoogle-glog-dev libprotobuf-dev libprotoc-dev protobuf-compiler ccache libgphoto2-dev libvtk6-dev libvtk6-qt-dev liblapack-dev libatlas-base-dev
```

# Gccのバージョン管理
```
sudo apt install gcc-5 g++-5 gfortran-5 gccgo-5
sudo apt install gcc-6 g++-6 gfortran-6 gccgo-6
sudo apt install gcc-7 g++-7 gfortran-7 gccgo-7
sudo apt install gcc-8 g++-8 gfortran-8 gccgo-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 100 \
--slave /usr/bin/g++ g++ /usr/bin/g++-5 \
--slave /usr/bin/gfortran gfortran /usr/bin/gfortran-5 \
--slave /usr/bin/gccgo gccgo /usr/bin/gccgo-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
--slave /usr/bin/g++ g++ /usr/bin/g++-6 \
--slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6 \
--slave /usr/bin/gccgo gccgo /usr/bin/gccgo-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 \
--slave /usr/bin/g++ g++ /usr/bin/g++-7 \
--slave /usr/bin/gfortran gfortran /usr/bin/gfortran-7 \
--slave /usr/bin/gccgo gccgo /usr/bin/gccgo-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 \
--slave /usr/bin/g++ g++ /usr/bin/g++-8 \
--slave /usr/bin/gfortran gfortran /usr/bin/gfortran-8 \
--slave /usr/bin/gccgo gccgo /usr/bin/gccgo-8
```

```
sudo update-alternatives --config gcc
```

```
CC=gcc-6 CXX=g++-6 cmake-gui ..
```

---
title: Ubuntu18.04でOpenCV3.4をcontribと一緒にbuildしたときのメモ
tags: OpenCV ubuntu18.04
author: gusugusu
slide: false
---
就活もめんどくさくなってきて、なんとなくROS2用のUbuntu18.04開発機を作ろうと思ったらつまづき、
ちょっとつらくなったので、今後被害者をださないようにメモを公開。

(僕の思考回路
就活やりたくない → ROS2触りたい → ESほっておいて開発機つくろー！)

## 前提
以下のような環境ではじめはmakeしてた。
cmake-guiは普段使わないが、cmakeオプション見やすいので最初は使っていた。

* OpenCV3.4.5
* cmake-gui
* cuda 10.0

## エラー
エラーが出たのは以下２点

###### 1. gccのバージョン
エラー内容

```
unsupported GNU version! gcc versions later than 6 are not supported
```

gccのバージョンを下げろと言われた気がしたので、
gcc-5とかでコンパイルしてみると、次のようなエラーが出ました。


###### 2. CUDAのホストコンパイラgccのバージョン
エラー内容

```
c++: error: unrecognized command line option ‘-Wimplicit-fallthrough=3’; did you mean ‘-Wno-fallthrough’?
modules/core/CMakeFiles/opencv_core.dir/build.make:554: recipe for target 'modules/core/CMakeFiles/opencv_core.dir/src/arithm.cpp.o' failed
```

どうしたらええんじゃ！と色々探して試してみたらできた。

## 対処方法

結論から言うと、たぶんcmake-guiは使わないほうがよいというのと、
以下２つに注意すればいいと思う。

###### 1. CC=gcc-6 CXX=g++-6
###### 2. -D CUDA_NVCC_FLAGS=--expt-relaxed-constexpr 

以下にざっくりメモしておいたので参考程度に

```
sudo apt install build-essential cmake ccache git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libgtk-3-dev libjpeg-dev libpng++-dev libtbb2 libtbb-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-de ffmpeg checkinstall 
sudo apt install gcc-6 g++-6

cd ~/env # どこでもいいよ
git clone https://github.com/opencv/opencv
cd opencv
git checkout 3.4.5
cd ..
git clone https://github.com/opencv/opencv_contrib.git 
cd opencv_conrib
git checkout 3.4.5
cd opencv
mkdir build
cd build
CC=gcc-6 CXX=g++-6 cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D OPENCV_EXTRA_MODULES_PATH=${HOME}/env/opencv_contrib/modules \
	-D OPENCV_GENERATE_PKGCONFIG=ON \
	-D BUILD_opencv_apps=ON \
	-D BUILD_opencv_calib3d=ON \
	-D BUILD_opencv_core=ON \
	-D BUILD_opencv_cudaarithm=ON \
	-D BUILD_opencv_cudabgsegm=ON \
	-D BUILD_opencv_cudacodec=ON \
	-D BUILD_opencv_cudafeatures2d=ON \
	-D BUILD_opencv_cudafilters=ON \
	-D BUILD_opencv_cudaimgproc=ON \
	-D BUILD_opencv_cudalegacy=ON \
	-D BUILD_opencv_cudaobjdetect=ON \
	-D BUILD_opencv_cudaoptflow=ON \
	-D BUILD_opencv_cudastereo=ON \
	-D BUILD_opencv_cudawarping=ON \
	-D BUILD_opencv_cudev=ON \
	-D BUILD_opencv_features2d=ON \
	-D BUILD_opencv_flann=ON \
	-D BUILD_opencv_highgui=ON \
	-D BUILD_opencv_imgcodecs=ON \
	-D BUILD_opencv_imgproc=ON \
	-D BUILD_opencv_ml=ON \
	-D BUILD_opencv_objdetect=ON \
	-D BUILD_opencv_photo=ON \
	-D BUILD_opencv_stitching=ON \
	-D BUILD_opencv_superres=ON \
	-D BUILD_opencv_ts=ON \
	-D BUILD_opencv_video=ON \
	-D BUILD_opencv_videoio=ON \
	-D BUILD_opencv_videostab=ON \
	-D WITH_1394=ON \
	-D WITH_CUBLAS=ON \
	-D WITH_CUDA=ON \
	-D WITH_CUFFT=ON \
	-D WITH_EIGEN=ON \
	-D WITH_FFMPEG=ON \
	-D WITH_GDAL=OFF \
	-D WITH_GPHOTO2=OFF \
	-D WITH_GIGEAPI=ON \
	-D WITH_GSTREAMER=ON \
	-D WITH_GTK=ON \
	-D WITH_INTELPERC=OFF \
	-D WITH_IPP=ON \
	-D WITH_IPP_A=OFF \
	-D WITH_JASPER=ON \
	-D WITH_JPEG=ON \
	-D WITH_LIBV4L=ON \
	-D WITH_OPENCL=ON \
	-D WITH_OPENCLAMDBLAS=OFF \
	-D WITH_OPENCLAMDFFT=OFF \
	-D WITH_OPENCL_SVM=OFF \
	-D WITH_OPENEXR=ON \
	-D WITH_OPENGL=ON \
	-D WITH_OPENMP=OFF \
	-D WITH_OPENNI=OFF \
	-D WITH_PNG=ON \
	-D WITH_PTHREADS_PF=OFF \
	-D WITH_PVAPI=ON \
	-D WITH_QT=OFF \
	-D WITH_TBB=ON \
	-D WITH_TIFF=ON \
	-D WITH_UNICAP=OFF \
	-D WITH_V4L=OFF \
	-D WITH_VTK=OFF \
	-D WITH_WEBP=ON \
	-D WITH_XIMEA=OFF \
	-D WITH_XINE=OFF \
	-D CUDA_NVCC_FLAGS=--expt-relaxed-constexpr \
	-D CUDA_FAST_MATH=ON \
	-D CUDA_TOOLKIT_ROOT_DIR=/usr \
	-D CUDA_HOST_COMPILER=/usr/bin/gcc-6 \
	..
sudo make install
sudo ldconfig

```

# 所感
今回実験的にubuntu18.04にblacklistとか何もせずcudaを入れてみたが難なくいけたのでとてもよかった。

OpenCVといえばdandelionさんですが、dandelionさんのgistにいい感じのシェルスクリプトが落ちてることにあとで気づいた。
僕もGistでまとめてみようかな...

https://gist.github.com/atinfinity/0aea057af98dcf5a838da23becfdffbe

## 参考文献
https://github.com/opencv/opencv/issues/12429
https://github.com/opencv/opencv/issues/11552
https://github.com/xmrig/xmrig-nvidia/issues/134
https://www.kunihikokaneko.com/dblab/linuxsoft/ubuntu_opencv_buildout.html
https://github.com/justadudewhohacks/npm-opencv-build/issues/9
https://qiita.com/LxrunYutaKojima/items/41535afdf7af4d3e6ed8
