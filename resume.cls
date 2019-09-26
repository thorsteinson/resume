\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2019/09/25 Resume Class]

\LoadClass[letterpaper, oneside, final]{article} 
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{titlesec} % Allows creating custom \section's
\RequirePackage{marvosym} % Allows the use of symbols
\RequirePackage{fontspec} % Allows font customization
\RequirePackage{forloop}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{etoolbox}
\RequirePackage{lipsum} % Dummy text to verify formatting behavior
\RequirePackage[top=0.75in, left=0.5in, right=0.5in]{geometry}


\RequirePackage[colorlinks=true, urlcolor=MidnightBlue]{hyperref}

\newcommand{\primarycolor}[1]{
  \global\def\@primarycolor{#1}
}

\newcommand{\accentcolor}[1]{
  \global\def\@accentcolor{#1}
}
% Default colors, they are ugly, which will hopefully prompt changing them
\primarycolor{ff0000}
\accentcolor{0000ff}

% Commands for contact info
\newcommand{\phone}[1]{
  \global\def\@phone{#1}
}
\newcommand{\email}[1]{
  \global\def\@email{#1}
  \global\def\@emailURL{mailto:#1}
}
% Only include the portion after the 'in/'. URL will be constructed
% automatically from the rest
\newcommand{\linkedin}[1]{
  \global\def\@linkedin{linkedin.com/#1}
  \global\def\@linkedinURL{https://www.linkedin.com/in/#1}
}
\newcommand{\address}[1]{
  \global\def\@address{#1}
}
\newcommand{\university}[4]{
  \global\def\@university{#1}
  \global\def\@universityStart{#2}
  \global\def\@universityEnd{#3}
  \global\def\@universityDegree{#4}
}
\newcommand{\website}[2]{
  \global\def\@website{#1}
  \global\def\@websiteURL{#2}
}
\newcommand{\github}[1]{
  \global\def\@github{github.com/#1}
  \global\def\@githubURL{https://github.com/#1}
}

\def\@bulletspace{-0.7em}

\AtBeginDocument{
    % Place this in a hook, so that we can safely set the colors in the
    % document preamble
    \setmainfont{Work Sans}
    \newfontfamily\titlefont{Work Sans Medium}[Letters=Uppercase,
    Color=\@primarycolor]
    \newfontfamily\sectionfont{Work Sans SemiBold}[Letters=SmallCaps,
    Color=\@primarycolor]
    \newfontfamily\tableheaderfont{Work Sans Medium}[Letters=SmallCaps]
    \newfontfamily\subsubsectionfont{Work Sans Bold}
    \newfontfamily\emphasisfont{Work Sans Medium}

    \newcommand{\level}{
    \textcolor[HTML]{\@accentcolor}{●} \hspace{\@bulletspace}
    }

    \newcommand{\makeedu}{
      \section{Education}
    \emph{\@university}

    \emph{\@universityStart}\textendash\emph{\@universityEnd}

    \emph{\@universityDegree}
    }

    \newcommand{\makecontact}{
      \section{Contact}
      \begin{tabular}{c l}
      {\Large \Letter} & \href{\@emailURL}{\@email} \\
      \ifdef{\@phone}{{\Large \Telefon} & \@phone \\}{}
      \includegraphics[width=10pt]{../linkedin-logo} & \href{\@linkedinURL}{\@linkedin} \\
      \ifdef{\@github}{\includegraphics[width=10pt]{../GitHub-Mark} & \href{\@githubURL}{\@github} \\}{}
      \end{tabular}
    }
}


\newcommand{\emptylevel}{
  ● \hspace{\@bulletspace}
}


\newcounter{ct}
\newcounter{proficiency}
\newcommand{\proficiency}[1]{
  % Reset our counter
  \setcounter{ct}{0}
  \setcounter{proficiency}{#1}

  \forloop{ct}{0}{\value{ct} < 5}{
    % Decrement counter every time
    \addtocounter{proficiency}{-1}
    \ifthenelse{\value{proficiency} < 0}{\emptylevel}{\level}
  }
}

\renewcommand{\emph}[1]{
  \emphasisfont #1
}

\pagenumbering{gobble} % Suppresses page numbers

\renewcommand{\section}[1]{
  {
  \vspace{1.0em}
  \sectionfont \Large #1 \par
  \vspace{1.0em}
  }
}

\renewcommand{\subsection}[1]{
  {
  \sectionfont \large #1 \par
  }
  \vspace{1.0em}
}


\renewcommand{\subsubsection}[1]{
  {
    \par
    \vspace{0.5em}
    \subsubsectionfont #1 \par
    \vspace{0.5em}
  }
}


\renewcommand{\maketitle}{
  {
    \titlefont \Huge \@author 
  \vspace{1.0em}
    }
}
