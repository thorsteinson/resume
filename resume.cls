\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2019/09/25 Resume Class]

\LoadClass[letterpaper, oneside, final]{article} 
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{titlesec} % Allows creating custom \section's
\RequirePackage{fontspec} % Allows font customization
\RequirePackage{forloop}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{etoolbox}
\RequirePackage{lipsum} % Dummy text to verify formatting behavior
\RequirePackage[top=0.75in, left=0.5in, right=0.5in, bottom=0.5in]{geometry}


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
    \newfontfamily\subsubsectionfont{Work Sans Medium}[Letters=SmallCaps, Color=\@primarycolor]
    \newfontfamily\emphasisfont{Work Sans Medium}
    \newfontfamily\subtitlefont{Work Sans Medium}[Letters=Uppercase, Color=\@accentcolor]

    \newcommand{\level}{
    \textcolor[HTML]{\@accentcolor}{●} \hspace{\@bulletspace}
    }

    \newcommand{\emptylevel}{
    \textcolor[HTML]{\@accentcolor}{○} \hspace{\@bulletspace}
    }

    \newcommand{\@makeedu}{
      \section{Education}
    \emph{\@university}

    \emph{\@universityStart}\textendash\emph{\@universityEnd}

    \emph{\@universityDegree}
    \par
    }

    \newcommand{\@makecontact}{
      \section{Contact}
      \begin{tabular}{c l}
      \ifdef{\@website}{\includegraphics[width=10pt]{assets/world} & \href{\@websiteURL}{\@website} \\}{}
      \ifdef{\@github}{\includegraphics[width=10pt]{assets/GitHub-Mark} & \href{\@githubURL}{\@github} \\}{}
      \includegraphics[width=10pt]{assets/envelope} & \href{\@emailURL}{\@email} \\
      \includegraphics[width=10pt]{assets/linkedin-logo} & \href{\@linkedinURL}{\@linkedin} \\
      \ifdef{\@phone}{\includegraphics[width=10pt]{assets/telephone} & \@phone \\}{}
      \includegraphics[width=10pt]{assets/location} & \@address \\
      \end{tabular}
    }

    \maketitle
    
    \begin{@resume}
}


\AtEndDocument{
  \@makeedu
  \@makecontact
  \end{@resume}
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
  {\emphasisfont #1}
}

\pagenumbering{gobble} % Suppresses page numbers

\renewcommand{\section}[1]{
  {
  \vspace{2.0em}
  \sectionfont \Large #1 \par
  \vspace{0.4em}
  }
}

\renewcommand{\subsection}[1]{
  {
  \vspace{1.3em}
  \sectionfont \large #1 \par
  \vspace{0.4em}
  }
}


\renewcommand{\subsubsection}[1]{
  {
    \vspace{0.4em}
    \subsubsectionfont #1 \par
    \vspace{0.2em}
  }
}


\renewcommand{\maketitle}{
  {
    \titlefont \Huge \MakeUppercase{\@author} \par
    \Large \subtitlefont \MakeUppercase{\@title} \par
  \vspace{1.0em}
    }
}

% An hidden environment that nearly all of the document is wrapped
% in. Allows for a 2-Column layout.
\newenvironment{@resume}{
    \begin{tabular}{p{4.5in} p{2.5in}}
}
{
    \end{tabular}
}

% Since we're in a table, this just adds the ampersand to mark the
% next column. It's easier for a user to understand.
\newcommand{\newcolumn}{&}

% An environment for capturing employment information. Add teams
% inside of this environment for more detail, or just add plain
% paragraphs if teams are too excessive.
\newenvironment{employer}[5][none]{
  \subsection{#2}
  \ifthenelse{\equal{#1}{none}}{
    \begin{tabular}{l l}
        \tableheaderfont Period & #3 -- #4 \\
        \tableheaderfont Title &  #5 \\
    \end{tabular}
  }{
    \begin{tabular}{c l l}
        \multirow{2}{*}{\includegraphics[height=0.33in]{#1}} &
        \tableheaderfont Period & #3 -- #4 \\
        & \tableheaderfont Title &  #5 \\
    \end{tabular}
    }
  \par
  }{\par}

  
% An environment that captures a single team. Takes the name of the
% team and the starting period or time length for that team.
\newenvironment{team}[1]{
  \subsubsection{#1} \par
}{\par}


% An environment where skills are listed along with proficiency. Only
% the \skill command should be used in this table.
\newenvironment{skilltable}[1]{
  \subsection{#1}
  % Need the fixed width so that the dots align between sections
  \begin{tabular}{p{0.6in} l}
}{\end{tabular}}

% Allows for specifying the level of a named skill inside of a skill table
\newcommand{\skill}[2]{
  \tableheaderfont \small #1 & \proficiency{#2} \\
}

% Condenses bullet points
\newenvironment{bullets}{
  \begin{itemize}
  \vspace{-1em}
  \setlength\itemsep{-0.5em}
}{\end{itemize}}
