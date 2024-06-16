\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cgem-poster}[2024/06/14 CGEM Posters]

%--------------------------------
% Wraps around beamer and beamer poster
\LoadClass[t,dvipsnames]{beamer}
\RequirePackage[orientation=landscape, size=a0, scale=2]{beamerposter} % Size

\RequirePackage[export]{adjustbox}
\RequirePackage{amsmath, amsfonts, amssymb, bm} % math
\RequirePackage[backend=biber,style=authoryear-comp]{biblatex} % bibliography
\RequirePackage{float}
\RequirePackage{fontspec} % uni code fonts
\RequirePackage{graphicx} % graphics
\RequirePackage{hyperref} % links 
\RequirePackage[absolute,overlay]{textpos} % text blocks
\RequirePackage{xcolor} % colors

% Import Lua modules
\directlua{ poster = require("spacing") }

%--------------------------------
% Main font
\setmainfont{Verdana}

% Beamer global settings
\setbeamersize{text margin left=1em, text margin right=1em}
\beamertemplatenavigationsymbolsempty
\setbeamercolor*{normal text}{fg=white,bg=black}

%--------------------------------
% Lua functions

% Here, Lua does all the hard lifting
% All math is sent to Lua, organized,
% and returned by means of the \luavar{}
% function

% Mutator
% First argument:
% 'get' or 'set' -- indicates whether to get or set value
% Second argument
% if getting, white space delimited variable name
% if setting, white space delimited variable name with '=' and value
\newcommand{ \lua }[2]{ \directlua{ poster.#1("#2") } }

%--------------------------------
% Poster 'namespace'
% Essentially replaces \begin{document} & \end{document}
\newcommand{\poster}[1]{
  
  % Set up internal variables
  \directlua{ poster.setup() }

  % Poster title
  \newcommand{ \postertitle }[3]{
    \begin{textblock*}{ \lua{get}{title width} }( 0cm, 0cm )
      \textblockcolor{black}
      \begin{minipage}[t][\lua{get}{ title height }][t]{ \lua{get}{title width} }%
      \end{minipage}
    \end{textblock*}
    %
    \begin{textblock*}{ \lua{get}{title width} }( 0cm, 0cm )
      \textblockcolor{black}
      \begin{center}
        { \bf \Large ##1 } \\
        { \large ##2 } \\
        { \color{gray}{ \normalsize ##3 } }
      \end{center}
    \end{textblock*}
    %             
    % CGEM logo
    \begin{textblock*}{ 0.1\paperwidth }( \lua{get}{ background margin }, 0mm)
      \textblockcolor{black}
      \centering
      \includegraphics[height=\lua{get}{title height}]{cgem-logo-dark}
      \end{textblock*}
    
    % Mines logo
    \begin{textblock*}{ 0.1\paperwidth }( \dimexpr \lua{get}{ background width } - 9cm \relax, 0mm)
      \textblockcolor{black}
      \centering
      \includegraphics[height=\lua{get}{title height}]{mines-logo-dark}
      \end{textblock*}
    }

  %% Poster background
  \newcommand{ \posterbackground }{%
    \begin{textblock*}%
      {\lua{get}{background width}}%
      (\lua{get}{background anchor x},\lua{get}{background anchor y})%
      \textblockcolor{lightgray}%
      \begin{minipage}[t]%
        [\lua{get}{background height}][t]{\lua{get}{background width}}%
      \end{minipage}%
    \end{textblock*}}
  %% Document wrapper
  \begin{document}
    \begin{frame}
      \posterbackground
      #1
    \end{frame}
  \end{document}
}
