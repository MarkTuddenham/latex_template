% technical_report.cls
% Report / Document technical details.
% 2020-Jun-22 Mark Tuddenham mark (at) tudders.com

% --- Class structure: identification
\ProvidesClass{technical_report}[2020/06/22 version 1.00 Technical Report]
\NeedsTeXFormat{LaTeX2e}

% --- Class structure: declaration of options
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "cls/<currentoption>.min" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{cls/\CurrentOption.min}{}{%
\PassOptionsToClass{\CurrentOption}{article}}}


% --- Class structure: execution of options
\ProcessOptions \relax
% --- Class structure: declaration of options
\LoadClass{article}


\RequirePackage[utf8]{inputenc}           % use utf-8 encoding
\RequirePackage{listings}                 % import code files
\RequirePackage[normalem]{ulem}           % provides \ul for underlining
\RequirePackage{tocloft}                  % Provides control over the ty­pog­ra­phy of the Ta­ble of Con­tents etc.
\RequirePackage[UKenglish]{babel}         % Multilingual support & language settings
\RequirePackage{amsmath}                  % American Mathematical Society mathematical facilities
\RequirePackage{amssymb}                  % American Mathematical Society symbols
\RequirePackage{mathtools}                % Mathematical tools to use with amsmath
\RequirePackage[automake]{glossaries}
% \RequirePackage{geometry}                 % Flexible and complete interface to document dimensions
\RequirePackage{titlesec}                 % Select alternative section titles
\RequirePackage{xcolor}                   % Driver-independent colour extensions for LaTeX
\RequirePackage{sectsty}                  % Allows stylistic changes of headers
\RequirePackage{hyperref,bookmark}        % Produce hy­per­text links for cross-ref­er­enc­ing commands & book­mark (out­line) organization for pack­age hy­per­ref.
\RequirePackage{cleveref}                 % Enhances LaTeX’s cross-ref­er­enc­ing features


% ~~~~~ Datetime2 setup ~~~~~
% \DTMlangsetup[en-GB]{ord=raise,monthyearsep={,\space}}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~ Biblatex ~~~~~
\RequirePackage[
  backend=biber,
  style=ieee,
  sortlocale=en_GB,
  natbib=true,
  url=true,
  doi=true,
  eprint=false,
  maxcitenames=2,
  mincitenames=1
]{biblatex}
  
\addbibresource{bibs/main.bib}
% ~~~~~~~~~~~~~~~~~~~~


% ~~~~~ New Maths ~~~~~
\DeclareMathOperator*{\argmax}{arg\!\max} % argmax operator
\newcommand*\mean[1]{\bar{#1}}

\DeclarePairedDelimiter\abs{\lvert}{\rvert}
\DeclarePairedDelimiter\norm{\lVert}{\rVert}
\makeatletter
\let\oldabs\abs
\def\abs{\@ifstar{\oldabs}{\oldabs*}}
%
\let\oldnorm\norm
\def\norm{\@ifstar{\oldnorm}{\oldnorm*}}
\makeatother
% ~~~~~~~~~~~~~~~~~~~~


% ~~~~~ Add folders to input path ~~~~~
\makeatletter
\def\input@path{{content/}{map/}{in/}}
\makeatother
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~ Graphics ~~~~~
% \epstopdfsetup{update}
% \DeclareGraphicsExtensions{.png, .eps} % For editing
% \DeclareGraphicsExtensions{.eps, .png} % For publishing
\renewcommand\textfraction{.5} % How much of the page is available for text
\setcounter{totalnumber}{3} % total number of figures per page
% ~~~~~~~~~~~~~~~~~~~~

% ~~~~~ Cleverref namings ~~~~~
\crefname{algo}{Algorithm}{Algorithms}
\crefname{script}{Script}{Scripts}
\crefname{data}{the data set presented in}{the data sets presented in}
\crefname{appendix}{Appendix}{Appendices}
\crefname{figure}{Figure}{Figures}
\crefname{equation}{Equation}{Equations}
\crefdefaultlabelformat{#2#1#3}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~ Headings ~~~~~
\setcounter{tocdepth}{3} % set max toc depth  

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\thesection.\Roman{subsection}}

\cftsetindents{section}{0em}{2em}
\cftsetindents{subsection}{2em}{2em}

\definecolor{burgundy}{rgb}{0.5, 0.0, 0.13}
% \titleformat*{\section}{\Large\bfseries\sffamily\color{burgundy}}
\titleformat{\section}{\Large\color{burgundy}}{\thesection}{1em}{\sffamily}
% \titleformat{\section}[display]{\center\Huge}{{\uppercase\expandafter{\thesection}}}{0em}{\sffamily}

% \titleformat{\subsection}{\normalfont}{\thesubsection}{1em}{}
% \titleformat{\subsection}{\centering}{\normalfont\thesubsection}{0em}{\\\sffamily}
\titleformat{\subsection}{\centering}{}{0em}{\sffamily}
\titlespacing\section{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

\sectionfont			{\fontsize{14}{16}\selectfont}
\subsectionfont		{\fontsize{11}{12}\selectfont}
\subsubsectionfont{\fontsize{10}{11}\selectfont}
\useunder{\uline}{\ul}{}
% ~~~~~~~~~~~~~~~~~~~


% ~~~~~ Hyphenation ~~~~~
\pretolerance=10000
\tolerance=2000
\emergencystretch=10pt
\lefthyphenmin4
\righthyphenmin4
\hyphenpenalty=1000
% ~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~ Input Listing settings ~~~~~
\input{listings}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


\DeclareUnicodeCharacter{2010}{-}
\renewcommand\labelitemi{---}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

\newcommand{\ie}{\textit{i.e.}\ }
\newcommand{\eg}{\textit{e.g.}\ }
\newcommand{\inc}{\textit{inc.}\ }
\newcommand{\etc}{\textit{etc.}\ }
\newcommand{\wrt}{\textit{wrt.}\ }

\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

\fontfamily{cmr}\selectfont

% ~~~~~ PDF metadata ~~~~~
\input{head}

\hypersetup{
  pdfinfo={
    Title={\pdfTitle{}},
    Author={\pdfAuthor{}},
    Subject={\pdfSubject{}},
    Keywords={\pdfKeywords{}},
    Creator={\pdfCreator{}},
    Producer={\pdfProducer{}},
    },
  colorlinks,
  hidelinks,
  pdfnewwindow=true,
  linktoc=all,
  pdfborder=0 0 0,
}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   

\newglossary{symbols}{sym}{sbl}{List of Abbreviations and Symbols}
\makeglossary
\input{gloss}