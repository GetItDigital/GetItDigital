eval 'echo "\def \vtitel {Arbeit}" > Videotiteltext.tex' | tr -d ' '
cd ..
cp ../Templates/VideoTitle.tex VideoTitle.tex
latexmk -pdf -output-directory=TeXAux VideoTitle.tex
rm VideoTitle.tex
cd TeXAux
convert -limit memory 2GB -limit map 2GB -density 350 -colorspace sRGB VideoTitle.pdf video/VideoTitle_Arbeit.png
cp video/VideoTitle_Arbeit.png ../Videos/2_4_Arbeit.png
rm VideoTitle.*
ffmpeg -y -loop 1 -i video/VideoTitle_Arbeit.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-titel.mp4
ffmpeg -y -loop 1 -i video/Folien-1.png -i ../../Video/Videovorlagen/Stille4.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t 4 -color_trc bt709 -colorspace bt709 -color_primaries bt709 video/video-License.mp4
ffmpeg -y -loop 1 -i video/Folien-18.png -i ../TTS/tts-Video-02_Arbeit1-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit1-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-19.png -i ../TTS/tts-Video-02_Arbeit2-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit2-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-20.png -i ../TTS/tts-Video-02_Arbeit2-3-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit2-3-0.mp4
ffmpeg -y -loop 1 -i video/Folien-21.png -i ../TTS/tts-Video-02_Arbeit3-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit3-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-22.png -i ../TTS/tts-Video-02_Arbeit3-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit3-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-23.png -i ../TTS/tts-Video-02_Arbeit3-3-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit3-3-0.mp4
ffmpeg -y -loop 1 -i video/Folien-24.png -i ../TTS/tts-Video-02_Arbeit4-1-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit4-1-0.mp4
ffmpeg -y -loop 1 -i video/Folien-25.png -i ../TTS/tts-Video-02_Arbeit4-2-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit4-2-0.mp4
ffmpeg -y -loop 1 -i video/Folien-26.png -i ../TTS/tts-Video-02_Arbeit4-3-0.wav -c:v libx264 -r 25 -vf "scale=-1:1080,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white" -pix_fmt yuv420p -t XX video/video-02_Arbeit4-3-0.mp4
ffmpeg -y -f concat -safe 0 -i Video-RenderVideoFilelist-Arbeit.txt -fflags +genpts -c copy ../Videos/2_4_Arbeit.mp4
