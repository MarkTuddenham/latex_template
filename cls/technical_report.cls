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


\RequirePackage{listings}                 % import code files
\RequirePackage[UKenglish]{babel}         % Multilingual support & language settings
\RequirePackage{amsmath}                  % American Mathematical Society mathematical facilities
\RequirePackage{amssymb}                  % American Mathematical Society symbols
\RequirePackage{mathtools}                % Mathematical tools to use with amsmath
\RequirePackage{parskip}
% \RequirePackage{geometry}                 % Flexible and complete interface to document dimensions
\RequirePackage{sectsty}                  % Allows stylistic changes of headers

\RequirePackage{cls/common}

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


% ~~~~~ Headings ~~~~~
\renewcommand{\thesection}{\Roman{section}}
% \renewcommand{\thesubsection}{\thesection.\Roman{subsection}}


\definecolor{burgundy}{rgb}{0.5, 0.0, 0.13}
% \titleformat*{\section}{\Large\bfseries\sffamily\color{burgundy}}
\titleformat{\section}{\Large\color{burgundy}}{\thesection}{1em}{\sffamily}
% \titleformat{\section}[display]{\center\Huge}{{\uppercase\expandafter{\thesection}}}{0em}{\sffamily}

% \titleformat{\subsection}{\centering}{\normalfont\thesubsection}{0em}{\\\sffamily}
% \titleformat{\subsection}{\centering}{}{0em}{\sffamily}
\titleformat{\subsection}{\normalfont}{\thesubsection}{1em}{\sffamily}

\titleformat{\subsubsection}{\normalfont}{\thesubsubsection}{1em}{\sffamily}

\titlespacing\section{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

% ~~~~~~~~~~~~~~~~~~~


% ~~~~~ Input Listing settings ~~~~~
\input{listings}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
