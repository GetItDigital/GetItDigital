#!/bin/bash

output_dir="TeXAux/compiledPNG" 

# Verzeichnisse entfernen falls vorhanden
rm -rf "$output_dir"

mkdir -p "$output_dir"

for tex_file in *.tex; do

    # Suche nach \includesvg und extrahiere die Dateinamen
    awk -v output_dir="$output_dir" '
    BEGIN {
        # Array zum Speichern bereits verarbeiteter Dateinamen
        delete processed
    }
    # Ignoriere auskommentierte Zeilen
    /^[[:space:]]*%/ { next }
    # Suche nach \includesvg und extrahiere den Dateinamen und den Wert
    /\\includesvg\[[^]]*\]\{([^}]*)\}/ {
        # Extrahiere den Dateinamen und den Wert aus dem gefundenen Muster
        if (match($0, /\\includesvg\[(.*?)\]\{([^}]*)\}/, arr)) {
            width = arr[1]
            filename = arr[2]
            # Entferne "Bilder/" aus filename, falls vorhanden
            sub(/^Bilder\//, "", filename)
            # Prüft, ob der Dateiname bereits verarbeitet wurde
            if (!(filename in processed)) {
                processed[filename] = 1  # Markiert den Dateinamen als verarbeitet
                # Erstelle den Inhalt der TEX-Datei
                content = "\\documentclass{standalone}\n"
                content = content "\\input{../Templates/Settings.tex}\n"
                content = content "\\begin{document}\n"
                content = content "\\includesvg[" width "]{" filename ".svg}\n"
                content = content "\\end{document}\n"
                # Erstelle das Zielverzeichnis, indem nur der Verzeichnispfad verwendet wird
                dir_path = output_dir "/" filename
                sub(/\/[^\/]*$/, "", dir_path)  # Entferne den Dateinamen, behalte den Pfad
                system("mkdir -p " dir_path)
                # Schreibe den Inhalt in die Datei
                print content > output_dir "/" filename ".tex"
            }
        }
    }' "$tex_file"

done

find "$output_dir" -type f -name "*.tex" | while read -r tex_file; do
    echo "$tex_file"
    dir_path=$(dirname "$tex_file")
    pdflatex --shell-escape -output-directory="$dir_path" "$tex_file" >/dev/null 2>&1
    # Konvertiere in PNG
    path_name="${tex_file%.*}"
    pdf_file="${path_name}.pdf"
    png_file="${path_name}.png"
    convert -density 300 "$pdf_file" -quality 90 "$png_file"
done

# Lösche Hilfsdateien
find "$output_dir" -type f -name "*.log" -delete -o -name "*.aux" -delete -o -name "*.pdf" -delete -o -name "*.tex" -delete

if [ -d "svg-inkscape" ]; then
    # Lösche das Verzeichnis und seinen Inhalt
    rm -rf "svg-inkscape"
fi