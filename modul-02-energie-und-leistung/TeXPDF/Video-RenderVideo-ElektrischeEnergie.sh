eval 'echo "\def \vtitel {Elektrische Energie}" > Videotiteltext.tex' | tr -d ' '
cd ..
cp ../Templates/VideoTitle.tex VideoTitle.tex
latexmk -pdf -output-directory=TeXAux VideoTitle.tex
rm VideoTitle.tex
cd TeXAux
convert -limit memory 2GB -limit map 2GB -density 350 -colorspace sRGB VideoTitle.pdf video/VideoTitle_ElektrischeEnergie.png
cp video/VideoTitle_ElektrischeEnergie.png ../Videos/2_3_ElektrischeEnergie.png
rm VideoTitle.*
ffmpeg -y -loop 1 -i video/VideoTitle_ElektrischeEnergie.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-titel.mp4
ffmpeg -y -loop 1 -i video/Folien-1.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-License.mp4
ffmpeg -y -loop 1 -i video/Folien-13.png -i ../TTS/tts-Video-01_Energie5-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-01_Energie5-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-14.png -i ../TTS/tts-Video-01_Energie5-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-01_Energie5-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-14.png -i ../../Video/Videovorlagen/Stille02.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 0.2 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-01_Energie5-2-0-silence.mp4
ffmpeg -y -loop 1 -i video/Folien-15.png -i ../TTS/tts-Video-01_Energie6-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-01_Energie6-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-16.png -i ../TTS/tts-Video-01_Energie6-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-01_Energie6-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-16.png -i ../../Video/Videovorlagen/Stille02.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 0.2 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-01_Energie6-2-0-silence.mp4
ffmpeg -y -loop 1 -i video/Folien-17.png -i ../TTS/tts-Video-01_Energie7-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-01_Energie7-1-0.mp4
ffmpeg -y -f concat -safe 0 -i Video-RenderVideoFilelist-ElektrischeEnergie.txt -fflags +genpts -c copy ../Videos/2_3_ElektrischeEnergie.mp4
