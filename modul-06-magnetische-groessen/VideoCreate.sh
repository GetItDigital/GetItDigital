#!/bin/bash

[ ! -f "TeXAux/Video.pdf" ] && echo "Video.pdf not found. Please compile Video.tex first." && exit 1
[ ! -d "Videos" ] && mkdir "Videos"

cd TeXAux
rm -f -r video
mkdir video
echo "Creating PNG files from PDF..."

# Konvertiert PDF in Schritten von 100 Seiten auf ein mal, um Speicherüberlauf zu vermeiden
convert -limit memory 4GB -limit map 4GB -density 320 -colorspace sRGB Video.pdf[0-99] video/Folien-%d.png 2>/dev/null
convert -limit memory 4GB -limit map 4GB -density 320 -colorspace sRGB Video.pdf[100-199] video/Folien-%d.png 2>/dev/null
convert -limit memory 4GB -limit map 4GB -density 320 -colorspace sRGB Video.pdf[200-299] video/Folien-%d.png 2>/dev/null
convert -limit memory 4GB -limit map 4GB -density 320 -colorspace sRGB Video.pdf[300-399] video/Folien-%d.png 2>/dev/null

echo "PNGs done."

# Alle erzeugten WAVs auf ihre Dauer untersuchen und die Dauer in Folien-RenderVideo.sh in der passenden Zeile hinter "-t " einfügen
tts_dir="../TTS"
for filename in Video-RenderVideo-*.sh; do
    for audio_file in "$tts_dir"/*.wav; do
        # Ermittle die Dauer der Audiodateien in "filename"
        duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$audio_file")
        duration=$(awk "BEGIN {print $duration + 1}")
        sed -i "/$(echo "$audio_file" | sed 's/[\/&]/\\&/g')/s/-t XX /-t $duration /" "$filename"
    done
done

echo "Render Videos"
for filename in Video-RenderVideo-*.sh; do
    chmod ugo+x $filename
    ./$filename
done
