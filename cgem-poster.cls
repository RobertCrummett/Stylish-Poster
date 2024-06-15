\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cgem-poster}[2024/06/14 CGEM Posters]

\LoadClass[t,dvipsnames]{beamer}
\RequirePackage[orientation=landscape,size=a0,scale=2]{beamerposter} % size

\RequirePackage{amsmath, amsfonts, amssymb, bm} % Math
\RequirePackage[backend=biber,style=authoryear-comp]{biblatex}
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{lengthconvert}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{xcolor}

\setmainfont{Verdana}

\setbeamersize{text margin left=1em, text margin right=1em}
\setbeamertemplate{navigation symbols}{} % no navigation on a poster
\setbeamercolor*{normal text}{fg=white,bg=black}

\newcommand{\anchorx}{0.015cm}
\newcommand{\anchory}{0.1cm}

\newcommand{\poster}[1]{

  % Poster title
  \newcommand{\postertitle}[3]{
    \begin{textblock*}{\paperwidth}(0ex,0ex)
      \textblockcolor{black}
      \begin{center}
        { \vskip1ex \bf \Large ##1 } \\[1mm]
        { \large ##2 } \\[1mm]
        { \large ##3 }
      \end{center}
    \end{textblock*}
  }
  % Poster background
  \newcommand{\posterbackground}{
    \begin{textblock*}{\luavar{bgwidth}}(\luavar{anchorx},\luavar{anchory})
      \textblockcolor{lightgray} ~ \vspace{0.875\paperheight}
    \end{textblock*}
  }

  \begin{document}
    \begin{frame}
      \posterbackground
      #1
    \end{frame}
  \end{document}
}
