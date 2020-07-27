% book.cls
% Write a book!
% 2020-Jun-22 Mark Tuddenham mark (at) tudders.com

% --- Class structure: identification
\ProvidesClass{book}[2020/06/22 version 1.00 Book]
\NeedsTeXFormat{LaTeX2e}

% --- Class structure: declaration of options
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "cls/<currentoption>.min" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{cls/\CurrentOption.min}{}{%
\PassOptionsToClass{\CurrentOption}{book}}}


% --- Class structure: execution of options
\ProcessOptions \relax
% --- Class structure: declaration of options
\LoadClass{book}


% \RequirePackage{graphicx}               % Include graphics files
\RequirePackage{sectsty}                  % Allows stylistic changes of headers
\RequirePackage[page]{appendix}           % Allows formatting of appendix titles
\RequirePackage[greek, UKenglish]{babel}         % Multilingual support & language settings
% \RequirePackage[T1]{fontenc}
\RequirePackage{parskip}                  % Layout with zero \parindent, non-zero \parskip
\RequirePackage{parallel}
% \RequirePackage{wrapfig}                % allows text to wrap around figures
% \RequirePackage{fontawesome}            % 634 web-re­lated icons 
% \RequirePackage[super]{nth}             % add position formatting e.g. \nth{1} -> 1st
% \RequirePackage{subcaption}             % Support for captions on sub-divided figures
\RequirePackage{fancyhdr}
\RequirePackage{csquotes}                 % Advanced fa­cil­i­ties for in­line and dis­play quotations
\RequirePackage[paperwidth=6in, paperheight=9in]{geometry}                 % Flexible and complete interface to document dimensions

\RequirePackage{cls/common}


% ~~~~~ Headings ~~~~~
\setcounter{tocdepth}{1} % set max toc depth, parts and chapters don't count.

\addto\captionsUKenglish{\renewcommand{\partname}{Book}}

\titleformat{\section}{\center\sffamily\color{burgundy}}{}{0pt}{}
% \titleformat*{\section}{\center\sffamily\color{burgundy}}
\titlespacing\section{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

\titleformat{\part}[display]{\center\Huge}{Book\\[1ex] \expandafter{\thepart}}{2ex}{\LARGE}[\rule{1cm}{.1pt}\vspace{1cm}]
% \titleformat{\part}[display]{\center\Huge}{Book \thepart}{12pt}{\LARGE}

\titleformat{\chapter}[display]{\vspace{4ex}\center}{\footnotesize\MakeUppercase{Chapter \expandafter{\thechapter}}}{-5pt}{\vspace{2ex}\titlerule\vspace{2ex}\large\bfseries}[\vspace{1cm}]
% \titleformat{\chapter}[display]{\center}{\footnotesize\bfseries\MakeUppercase{Chapter \expandafter{\thechapter}}}{-5pt}{\vspace{2ex}\titlerule\vspace{2ex}\large}[\vspace{1cm}]
% \titleformat{\chapter}[display]{\center}{\footnotesize\bfseries\MakeUppercase{Chapter \expandafter{\thechapter}}}{-5pt}{\large}[\rule{1cm}{.1pt}\vspace{1cm}]
% \titleformat{\chapter}[display]{\center}{\footnotesize\bfseries\MakeUppercase{Chapter \expandafter{\thechapter}}}{-5pt}{\large}[\vspace{2ex}\titlerule]
% \titleformat{\chapter}[display]{\center\Huge}{{\uppercase\expandafter{\romannumeral\thechapter}}}{12pt}{\LARGE}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~

\newenvironment{absolutelynopagebreak}
  {\par\nobreak\vfil\penalty0\vfilneg
   \vtop\bgroup}
  {\par\xdef\tpd{\the\prevdepth}\egroup
   \prevdepth=\tpd}


\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LE, RO]{\small\itshape\nouppercase{\leftmark}}
% \fancyhead[LO, RE]{\small\itshape\nouppercase{\rightmark}}
\fancyfoot[CE, CO]{\thepage}
\setlength{\headheight}{15pt}


\makeatletter
\newcommand*{\cleartoleftpage}{%
  \clearpage
    \if@twoside
    \ifodd\c@page
      \hbox{}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}
\makeatother


% Reset chapters on new part
% \makeatletter\@addtoreset{chapter}{part}\makeatother%
