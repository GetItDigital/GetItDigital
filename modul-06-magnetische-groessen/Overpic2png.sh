#!/bin/bash

# Verzeichnis für die .tex-Dateien
overpic_dir="TeXAux/Overpic/src"

# Verzeichnis für die Ausgabedateien
output_overpic_dir="TeXAuX/Overpic/png"

# Ausgabe-Verzeichnis entfernen und neu anlegen
rm -r "$output_overpic_dir"
mkdir -p "$output_overpic_dir"

# Alle .tex-Dateien im Overpic-Verzeichnis
for tex_file in $overpic_dir/*.tex; do
    # Extrahiere den Dateinamen ohne die Endung
    base_name=$(basename "$tex_file" .tex)
    echo "Working on $tex_file ..."

    # Erstelle temporäre LaTeX-Datei
    temp_tex_file="$output_overpic_dir/${base_name}_temp.tex"

    # LaTeX-Frame in die temporäre Datei
    cat <<EOF >"$temp_tex_file"
\documentclass{article} 
\usepackage{beamerarticle}
\input{../Templates/Settings.tex}
\pagestyle{empty} % Keine Seitenzahlen
\usepackage{tikz}
\usepackage{overpic}
\newcommand{\fo}[5]{\begin{overpic}[#1]{#3}{#4}\end{overpic}}
\newcommand{\foo}[5]{\begin{overpic}[#1]{#3}{#4}\end{overpic}}
\begin{document}
\input{$tex_file}
\end{document}
EOF

    # Kompiliere temporäre LaTeX-Datei
    pdflatex -output-directory="$output_overpic_dir" "$temp_tex_file" >/dev/null 2>&1

    # Konvertiere in PNG
    pdf_file="$output_overpic_dir/${base_name}_temp.pdf"
    png_file="$output_overpic_dir/${base_name}.png"
    convert -density 300 "$pdf_file" -quality 85 -trim "$png_file"

    # Lösche die Hilfsdateien
    rm "$output_overpic_dir/${base_name}_temp.tex" "$output_overpic_dir/${base_name}_temp.log" "$output_overpic_dir/${base_name}_temp.aux" "$output_overpic_dir/${base_name}_temp.pdf"
done
