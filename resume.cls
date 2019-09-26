\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2019/09/25 Resume Class]

\LoadClass[letterpaper, oneside, final]{article} 
\RequirePackage{xcolor}
\RequirePackage{titlesec} % Allows creating custom \section's
\RequirePackage{marvosym} % Allows the use of symbols
\RequirePackage{fontspec} % Allows font customization
\RequirePackage{forloop}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{relsize}
\RequirePackage{lipsum} % Dummy text to verify formatting behavior
\RequirePackage[top=0.75in, left=0.5in, right=0.5in]{geometry}


% Define fonts we'll use throughout the resume
\setmainfont{Work Sans}
\newfontfamily\titlefont{Work Sans Medium}[Letters=Uppercase,
  Color=1b054c]
\newfontfamily\sectionfont{Work Sans SemiBold}[Letters=SmallCaps,
  Color=1d2c4c]
\newfontfamily\tableheaderfont{Work Sans Medium}[Letters=SmallCaps]
\newfontfamily\subsubsectionfont{Work Sans Bold}
\newfontfamily\emphasisfont{Work Sans Medium}

\newcommand{\level}{
  \textcolor[HTML]{26ad75}{●} \hspace{-0.7em}
}

\newcommand{\emptylevel}{
  ● \hspace{-0.7em}
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
