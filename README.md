# About vtt-preview-generator
Shell VTT thumbnail generator for Akamai Adaptive media player (AMP) 

This tool will generate thumbnails and their own VTT file by using only your BASH/SHELL scripting.
```
yourVideoFile.vtt
yourVideoFile/ 
            |_ thumb-1.png
            |_ thumb-2.png
            |_ thumb-3.png
 ```
Here is the VTT output

```
WEBVTT FILE

00:00.0000 --> 00:10.9824
VfE/thumb-1.png#wh=128,72

00:10.9824 --> 00:20.9664
VfE/thumb-2.png#wh=128,72
```

# Getting started

You must install `ffmpeg` in your computer, please read the ffmpeg documentation in order to install this properly. 

1. run the sh command and pass the video path as an argument. 

```
$ main.sh http://projects.mediadev.edgesuite.net/customers/akamai/video/VfE.mp4 
``` 

2. That's all! a folder with the video name must be created within the thumbnails, also a VTT file must be generated.    
