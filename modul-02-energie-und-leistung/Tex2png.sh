#!/bin/bash

# Verzeichnis für die .tex-Dateien
tikz_dir="Tikz/src"

# Verzeichnis für die Ausgabedateien
output_tikz_dir="TeXAux"

# Verzeichnisse entfernen falls vorhanden
rm -rf "$output_tikz_dir/$tikz_dir"
rm -rf "$output_tikz_dir/Tikz/png"

# Erstelle Ausgabeverzeichnis, falls es nicht vorhanden
mkdir -p "$output_tikz_dir/$tikz_dir"

# Alle .tex-Dateien im Tikz-Verzeichnis
for tex_file in $(find "$tikz_dir" -name "*.tex"); do

    echo "Working on $tex_file ..."

    # Erstelle temporäre LaTeX-Datei
    mkdir -p $output_tikz_dir/$(dirname "$tex_file")
    temp_tex_file="$output_tikz_dir/$tex_file"

    # Extrahiere den Dateinamen und Verzeichnisse
    base_name=$(basename "$tex_file" .tex)
    input_path=$(dirname "$tex_file")
    outout_path="${input_path/src/png}"

    # LaTeX-Frame in die temporäre Datei
    cat <<EOF >"$temp_tex_file"

\immediate\write18{cd $output_tikz_dir/$outout_path;gnuplot *.gnuplot;cd ..;}
\documentclass[article]{standalone}
\usepackage{tikz}
\usepackage[nosiunitx,european,straightvoltages]{circuitikz}
\usepackage{beamerarticle}
\input{../Templates/Settings.tex}
\begin{document}
\input{$tex_file}
\end{document}
EOF
    

    mkdir -p "$output_tikz_dir/$outout_path"

    # Kompiliere temporäre LaTeX-Datei (mit Gnuplot)
    pdflatex --shell-escape -output-directory="$output_tikz_dir/$outout_path" "$temp_tex_file" >/dev/null 2>&1
    pdflatex --shell-escape -output-directory="$output_tikz_dir/$outout_path" "$temp_tex_file" >/dev/null 2>&1

    # Konvertiere in PNG
    pdf_file="$output_tikz_dir/$outout_path/${base_name}.pdf"
    png_file="$output_tikz_dir/$outout_path/${base_name}.png"
    convert -density 300 "$pdf_file" -quality 90 "$png_file"

    # Lösche Hilfsdateien
    find "$output_tikz_dir/Tikz/png" -type f -name "*.table" -delete -o -name "*.gnuplot" -delete -o -name "*.log" -delete -o -name "*.aux" -delete -o -name "*.pdf" -delete

done
