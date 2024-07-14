%% CGEM Poster Package
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cgem-poster}[2024/07/13 CGEM Posters]

%----------------------------------------
%% CGEM Presentation Package Dependencies
\LoadClass[aspectratio=169]{beamer}
\RequirePackage[orientation=landscape, size=a0, scale=2]{beamerposter}

% Preamble
\RequirePackage[export]{adjustbox}
\RequirePackage{amsmath, amsfonts, amssymb} % Math
\RequirePackage{array} % array stretch
\RequirePackage{bm}
\RequirePackage[backend=biber, style=authoryear-comp]{biblatex} % Bibliography, change style if you prefer
\RequirePackage{fontspec} % Fonts --- If this fails to compile, try XeLaTeX or LuaTeX
\RequirePackage{hyperref} % Links
\RequirePackage{longtable} % explanation of equations table
\RequirePackage[absolute,overlay]{textpos} % Figure placement
\RequirePackage{xcolor} % Colors

%-----------------------------------------
% Linking CGEM Lua package
\directlua{ cgembib = require("bib") } 

%-----------------------------------------
%% Global TeX Settings and Options Processing

% Presentation color options
\definecolor{highlight}{HTML}{FFC000} % Highlight color
\definecolor{cgemblue}{HTML}{90C5FB} % Light CGEM blue
\definecolor{pres-blue}{HTML}{496EAF} % Darkish blue
\definecolor{pres-red}{HTML}{BD3939} % Beautiful red

% Parse the optional color argument
\DeclareOption{dark}{
  \colorlet{ZeroColor}{black}
  \colorlet{FirstColor}{white}
  \colorlet{SecondColor}{cgemblue}
  \colorlet{ThirdColor}{cgemblue!40!red}
  \newcommand{\LogoFileCGEM}{cgem-logo-dark}
  \newcommand{\LogoFileMines}{mines-logo-dark}
}
\DeclareOption{light}{
  \colorlet{ZeroColor}{white}
  \colorlet{FirstColor}{black}
  \colorlet{SecondColor}{pres-blue}
  \colorlet{ThirdColor}{pres-red}
  \newcommand{\LogoFileCGEM}{cgem-logo-light}
  \newcommand{\LogoFileMines}{mines-logo-light}
}
\ProcessOptions\relax

% Font Settings
\setsansfont{Arial}

% Hyperlink settings
\hypersetup{
  colorlinks=true,
  citecolor=ThirdColor,
  linkcolor=SecondColor,
  urlcolor=ThirdColor,
} % Link to corresponding author

% Background and default text color
\setbeamercolor{background canvas}{bg = ZeroColor}
\setbeamercolor{normal text}{fg = FirstColor}\usebeamercolor*{normal text}

% Turn off Beamer navigation buttons
\beamertemplatenavigationsymbolsempty

% Page numbering
% \setbeamertemplate{footline}{
%   \begin{flushright}
%     \textcolor{SecondColor}{\large \insertframenumber}
%     \hspace{1mm}
%     \vspace{-1mm}
%   \end{flushright}
% }
