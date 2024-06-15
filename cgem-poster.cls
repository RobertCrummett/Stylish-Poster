\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cgem-poster}[2024/06/14 CGEM Posters]

\LoadClass[t,dvipsnames]{beamer}
\RequirePackage[orientation=landscape,size=a0,scale=2]{beamerposter} % Size

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

\newcommand{\luavar}[1]{
  \directlua{
    poster = require("spacing")
    tex.print(poster.get("#1"))
  }
}

\newcommand{\luaset}[2]{
  \directlua{
    poster = require("spacing")
    poster.#1(#2)
  }
}

\newcommand{\poster}[1]{

  % Poster background
  \newcommand{\posterbackground}{
    \begin{textblock*}
      {\luavar{background width}}
      (\luavar{background anchor x},\luavar{background anchor y})
      \textblockcolor{lightgray}~\vspace{\luavar{background height}}
    \end{textblock*}
  }

  % Poster title
  \newcommand{\postertitle}[3]{
    \begin{textblock*}{\paperwidth}(0cm,0cm)
      \textblockcolor{black}
      \begin{center}
        { \bf \Large ##1 } \\
        { \large ##2 } \\
        { \large ##3 }
      \end{center}
    \end{textblock*}
  }


  \begin{document}
    \begin{frame}
      \posterbackground
      #1
    \end{frame}
  \end{document}
}
