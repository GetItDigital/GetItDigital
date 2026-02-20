eval 'echo "\def \vtitel {Leistung}" > Videotiteltext.tex' | tr -d ' '
cd ..
cp ../Templates/VideoTitle.tex VideoTitle.tex
latexmk -pdf -output-directory=TeXAux VideoTitle.tex
rm VideoTitle.tex
cd TeXAux
convert -limit memory 2GB -limit map 2GB -density 350 -colorspace sRGB VideoTitle.pdf video/VideoTitle_Leistung.png
cp video/VideoTitle_Leistung.png ../Videos/2_5_Leistung.png
rm VideoTitle.*
ffmpeg -y -loop 1 -i video/VideoTitle_Leistung.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-titel.mp4
ffmpeg -y -loop 1 -i video/Folien-1.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-License.mp4
ffmpeg -y -loop 1 -i video/Folien-27.png -i ../TTS/tts-Video-03_Leistung1-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-03_Leistung1-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-28.png -i ../TTS/tts-Video-03_Leistung1-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-03_Leistung1-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-29.png -i ../TTS/tts-Video-03_Leistung2-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-03_Leistung2-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-30.png -i ../TTS/tts-Video-03_Leistung2-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-03_Leistung2-2-0.mp4
ffmpeg -y -f concat -safe 0 -i Video-RenderVideoFilelist-Leistung.txt -fflags +genpts -c copy ../Videos/2_5_Leistung.mp4
