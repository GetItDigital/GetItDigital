eval 'echo "\def \vtitel {Wirkungsgrad}" > Videotiteltext.tex' | tr -d ' '
cd ..
cp ../Templates/VideoTitle.tex VideoTitle.tex
latexmk -pdf -output-directory=TeXAux VideoTitle.tex
rm VideoTitle.tex
cd TeXAux
convert -limit memory 2GB -limit map 2GB -density 350 -colorspace sRGB VideoTitle.pdf video/VideoTitle_Wirkungsgrad.png
cp video/VideoTitle_Wirkungsgrad.png ../Videos/2_6_Wirkungsgrad.png
rm VideoTitle.*
ffmpeg -y -loop 1 -i video/VideoTitle_Wirkungsgrad.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-titel.mp4
ffmpeg -y -loop 1 -i video/Folien-1.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-License.mp4
ffmpeg -y -loop 1 -i video/Folien-31.png -i ../TTS/tts-Video-04_Wirkungsgrad1-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-04_Wirkungsgrad1-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-32.png -i ../TTS/tts-Video-04_Wirkungsgrad1-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-04_Wirkungsgrad1-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-32.png -i ../../Video/Videovorlagen/Stille02.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 0.2 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-04_Wirkungsgrad1-2-0-silence.mp4
ffmpeg -y -loop 1 -i video/Folien-33.png -i ../TTS/tts-Video-04_Wirkungsgrad2-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-04_Wirkungsgrad2-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-34.png -i ../TTS/tts-Video-04_Wirkungsgrad2-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-04_Wirkungsgrad2-2-0.mp4
ffmpeg -y -f concat -safe 0 -i Video-RenderVideoFilelist-Wirkungsgrad.txt -fflags +genpts -c copy ../Videos/2_6_Wirkungsgrad.mp4
