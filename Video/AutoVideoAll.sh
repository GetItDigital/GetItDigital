#!/bin/bash

# Variable für die Verzeichnisse initialisieren
modules=""

# Übergeordnete Verzeichnisse durchlaufen
for dir in ../modul-*; do
    if [ -d "$dir" ]; then
        modules+="$dir "
    fi
done

# Ursprungsverzeichnis speichern
original_dir="../Video"

# Durchlaufe alle gefundenen Module
for module in $modules; do
    # In das Modulverzeichnis wechseln
    cd "$module" || { echo "Wechsel zu $module fehlgeschlagen"; continue; }
    
    echo "--> Working on: $module"

    # TeXAux leeren, falls bereits vorhanden
    if [ -d "TeXAux" ]; then
        rm -rf "TeXAux"
    fi
    mkdir "TeXAux"

    echo "Writing TTS files and Video.pdf ..."

    # Befehl ausführen
    pdflatex --shell-escape -output-directory="TeXAux" "Video.tex" >/dev/null 2>&1
    
    # Überprüfen, ob pdflatex erfolgreich war
    if [ $? -eq 0 ]; then
        ./TTSCreate.sh
        ./VideoCreate.sh
    else
        echo "pdflatex schlug fehl im Verzeichnis: $module"
    fi

    # Zurück ins Ursprungsverzeichnis wechseln
    cd "$original_dir" || { echo "Wechsel zu $original_dir fehlgeschlagen"; exit 1; }
done
