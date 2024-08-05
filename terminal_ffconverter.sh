#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to check video files
check_video_files() {
    echo "Checking for video files in the current directory:"
    video_extensions=("mp4" "avi" "m4v" "mkv" "mov" "wmv" "flv" "webm" "3gp" "mpg" "mpeg")
    found_files=0
    declare -a video_files

    for ext in "${video_extensions[@]}"; do
        files=(*."$ext")
        if [ -e "${files[0]}" ]; then
            echo "Found ${#files[@]} .$ext file(s):"
            for file in "${files[@]}"; do
                echo "  $((found_files+1)): $file"
                video_files+=("$file")
                ((found_files++))
            done
        fi
    done

    if [ $found_files -eq 0 ]; then
        echo "No video files found in the current directory."
        exit 1
    else
        echo "Total video files found: $found_files"
    fi
    echo "----------------------------------------"

    echo "Select a file to convert (enter the number):"
    read file_number
    if [[ "$file_number" =~ ^[0-9]+$ ]] && [ "$file_number" -ge 1 ] && [ "$file_number" -le $found_files ]; then
        file="${video_files[$((file_number-1))]}"
    else
        echo "Invalid selection. Exiting."
        exit 1
    fi
}

clear
echo "Linux Debian Converter script"
echo "----------Last updated Aug 04 2024----------"
echo "--------------------------------------------"

# Call the function to check video files
check_video_files

echo "Selected file: $file"
echo "1: Convert to mp4"
echo "2: Convert to mp3"
echo "3: Advanced Conversion"
echo "q/Default: quit"
read n

file_name="${file##*/}"
name="${file_name%.*}"
OUTPUT_DIR="$SCRIPT_DIR/ffmpeg_output"
[ ! -d "$OUTPUT_DIR" ] && mkdir "$OUTPUT_DIR"

if [ "$n" == '1' ]; then
    clear
    echo "Please select output quality (default : original)"
    echo "0: 2160p (3840*2160)"
    echo "1: 1440p (2560*1440)"
    echo "2: 1080p (1920*1080)"
    echo "3: 720p (1280*720)"
    echo "4: 480p (854*480)"
    echo "5: 360p (640*360)"
    echo "6: 240p (426*240)"
    read q
    ext="0"
    [[ $q == "0" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=3840:2160 -qscale 0 "$OUTPUT_DIR/${name}_2160p.mp4" && ext="1"
    [[ $q == "1" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=2560:1440 -qscale 0 "$OUTPUT_DIR/${name}_1440p.mp4" && ext="1"
    [[ $q == "2" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=1920:1080 -qscale 0 "$OUTPUT_DIR/${name}_1080p.mp4" && ext="1"
    [[ $q == "3" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=1280:720 -qscale 0 "$OUTPUT_DIR/${name}_720p.mp4" && ext="1"
    [[ $q == "4" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=854:480 -qscale 0 "$OUTPUT_DIR/${name}_480p.mp4" && ext="1"
    [[ $q == "5" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=640:360 -qscale 0 "$OUTPUT_DIR/${name}_360p.mp4" && ext="1"
    [[ $q == "6" ]] && /usr/bin/ffmpeg -i "$file" -vf scale=426:240 -qscale 0 "$OUTPUT_DIR/${name}_240p.mp4" && ext="1"
    [[ $ext == "0" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 "$OUTPUT_DIR/${name}.mp4"
elif [ "$n" == '2' ]; then
    clear
    echo "Please select output quality (default : 320k)"
    echo "0: 320k"
    echo "1: 256k"
    echo "2: 192k"
    echo "3: 128k"
    echo "4: 64k"
    read q
    ext="0"
    [[ $q == "1" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 -ab 256k  "$OUTPUT_DIR/${name}.mp3" && ext="1"
    [[ $q == "2" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 -ab 192k  "$OUTPUT_DIR/${name}.mp3" && ext="1"
    [[ $q == "3" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 -ab 128k  "$OUTPUT_DIR/${name}.mp3" && ext="1"
    [[ $q == "4" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 -ab 64k  "$OUTPUT_DIR/${name}.mp3" && ext="1"
    [[ $ext == "0" ]] && /usr/bin/ffmpeg -i "$file" -qscale 0 -ab 320k  "$OUTPUT_DIR/${name}.mp3"
elif [ "$n" == '3' ]; then
    clear
    echo "Output Format (extension):"
    echo "e.g. |mp4|webm|mkv|avi|mov| for video and |mp3|wav|flac|aac|ogg| for audio"
    read f
    /usr/bin/ffmpeg -i "$file" -qscale 0 "$OUTPUT_DIR/${name}.${f}"
fi

echo "Conversion complete. Output saved in $OUTPUT_DIR"
