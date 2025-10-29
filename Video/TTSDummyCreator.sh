#!/bin/bash

input_dir="TeXAux"
output_dir="TTS"
dummy_file="Sprachsample.wav"

if [ ! -d "$output_dir" ]; then
    mkdir "$output_dir"
fi

# Durchsuchen des Verzeichnisses nach TXT-Dateien, die mit tts-Video beginnen
for file in "$input_dir"/tts-Video*.txt; do
    if [ -e "$file" ]; then
        # Extrahieren des Dateinamens
        filename=$(basename "$file" .txt)
        
        # Erstellen und Umbennen einer Kopie von dummy.wav
        cp "$dummy_file" "$output_dir/${filename}.wav"
        
        echo "Written: $output_dir/${filename}.wav"
    fi
done

echo "---> Done!"