#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied / video file is not being provided"
  else  
  	fullfilename=$1
    filename=$(basename "$fullfilename")
    fname="${filename%.*}"
    
    if [ ! -d $fname ]
    then
        mkdir -p $fname;
    fi
    
    ffmpeg -i $fullfilename -vf fps=1/10 -s 160x90 $fname/thumb-%d.png

    ##get some values for VTT creator
    eval $(ffprobe -v quiet -show_format -of flat=s=_ -show_entries stream=height,width,nb_frames,duration,codec_name $fullfilename)
    duration=${format_duration};
    
    ##parse this to Integer in order to validate
    VTT_OUTPUT=${fname}.vtt
    duration=${duration%.*}
    echo "Video duration is:" $duration

    ##check if vtt file exist 
    if [ -f "$VTT_OUTPUT" ]; then
        rm $VTT_OUTPUT
    fi

    counter=1
    interval=1

    while [ "$interval" -lt "$duration" ]
    do
    ((interval=interval+10))
    eval $(ffprobe -v quiet -sexagesimal -show_format -of flat=s=_ -read_intervals ${interval}%+1 -skip_frame nokey -select_streams v:0 -show_entries frame=pkt_pts_time $fullfilename)
    timestamp=${frames_frame_0_pkt_pts_time:2:10};

    if [ ${counter} -le 1 ] 
    then
        start='00:00.0000'
        printf "WEBVTT FILE\n">>$VTT_OUTPUT;
        printf "\n%10s --> %10s" "$start" "$timestamp" >>$VTT_OUTPUT;
    else
        printf "\n%10s --> %10s" "$current" "$timestamp" >>$VTT_OUTPUT; 
    fi
        printf "\n%s/thumb-%d.png#wh=128,72\n" "$fname" "$counter" >>$VTT_OUTPUT;
        current=$timestamp;
        ((counter++))
    done
fi
