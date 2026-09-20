# XeLaTeX is required by gmcmthesis.cls.
@default_files = ('GMCM-main.tex');
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
# makefiles.sh supplies a per-run temporary output directory and cleans it.
