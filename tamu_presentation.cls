% Beamer Template for Texas A&M University
% Skeleton drawn from Miwa Nakajo - October 24, 2009
% Expanded & made a document class by Billy McCulloch.

\ProvidesClass{tamu_presentation}[2011/03/11 v0.6.0 TAMU Presentation]

\RequirePackage{tamu_common}

\RequirePackage{xparse}

% All other options are passed through to memoir. Easy peasy.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions\relax
\LoadClass{beamer}

\usepackage{multimedia}

% This breaks the page numbers in the PDF! Why? I don't know...
% \hypersetup{unicode=true}

\mode<presentation>

%\author{\fullName}
\author{Billy McCulloch}
\title{\documentTitle}
\subtitle{\documentSubtitle}
\institute{%
  \includegraphics[width=0.3\paperwidth]{primary-alt08}%
  \par~%
  \par\textcolor{maroon}{\normalsize{College of Science}}%
  \par\textcolor{maroon}{\large{Department of Chemistry}}}
\date{\small{\publishDate}}

%\renewcommand\arraystretch{1.15}

%\titlegraphic{}

%\setbeamertemplate{title page}
%{
%  \begin{centering}
%    \title
%    \subtitle
%    \author
%    \institute
%  \end{centering}
%}

\usetheme{Luebeck}
%\usetheme{Warsaw}
%\useinnertheme{default}
%\useoutertheme{default}
%\useoutertheme{smoothbars}
%\usefonttheme{default}

% color
\definecolor{maroon}{RGB}{80,0,0} % A&M's primary color
\definecolor{darkgray}{RGB}{51,44,44} % A&M's primary support color, dark gray
\definecolor{lightgray}{RGB}{95,87,79} % A&M's secondary colors, light gray
\definecolor{verylightgray}{RGB}{140,135,130} % A&M's secondary colors, but even lighter gray :)
\definecolor{ultralightgray}{RGB}{205,200,195}
\usecolortheme[named=maroon]{structure}
\setbeamercolor{frametitle}{fg=maroon,bg=white}
\setbeamercolor{primary}{fg=white,bg=maroon}
\setbeamercolor{secondary}{fg=white,bg=lightgray}
%\setbeamercolor*{block title}{bg=verylightgray}
\setbeamercolor*{block title}{bg=maroon,fg=white}
\setbeamercolor*{block body}{bg=ultralightgray}
\setbeamercolor{frametitle}{fg=white,bg=darkgray}
%\setbeamercolor{frametitle right}{bg=maroon}
\setbeamercolor{alerted text}{fg=Red}

%\setbeamercovered{dynamic}

\setbeamersize{sidebar width left=0cm}
\setbeamersize{sidebar width right=0cm}
\setbeamersize{text margin left=0.30cm}
\setbeamersize{text margin right=0.30cm}

\setbeamertemplate{blocks}[default]%[rounded][shadow=false]

\setbeamertemplate{sidebar right}{default}
{%
%  \vfill%
%  \llap{\insertlogo\hskip0.1cm}%
%  \vskip2pt%
%  \llap{\usebeamertemplate***{navigation symbols}\hskip0.1cm}%
%  \vskip2pt%
}

% headline
%\setbeamertemplate{headline}{
%\hbox{%
%    \begin{beamercolorbox}[wd=0.5\paperwidth,ht=3.25ex,dp=2ex,left]{primary}%
%        \hspace*{2ex}\insertsectionhead % Section Title in Left
%    \end{beamercolorbox}%
%%    \begin{beamercolorbox}[wd=0.35\paperwidth,ht=3.25ex,dp=2ex,center]{secondary}%
%%        \insertsubsectionhead % Subsection Title in Middle
%%    \end{beamercolorbox}%
%    \begin{beamercolorbox}[wd=0.5\paperwidth,ht=3.25ex,dp=2ex,right]{secondary}%
%        \insertsubsectionhead\hspace*{2ex} % Subsection Title in Right
%    \end{beamercolorbox}%
%  }
%\vskip0pt }

% footline
\setbeamertemplate{footline}{
\hbox{%
    \begin{beamercolorbox}[wd=.45\paperwidth,ht=5pt,dp=2pt,left]{primary}
        \hspace*{2ex} % Something in Left
        \raisebox{-2pt}{\usebeamertemplate***{navigation symbols}}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.1\paperwidth,ht=5pt,dp=2pt,center]{primary}%
%        \vspace{-2pt}%
%        \includegraphics[height=7pt]{aTm08-box}% aTm Logo in the Middle
        \raisebox{-2pt}{\includegraphics[height=7pt]{aTm08-box}}% aTm Logo in the Middle
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.45\paperwidth,ht=5pt,dp=2pt,right]{primary}
        \insertframenumber{} / \inserttotalframenumber \hspace*{3ex} % Page numbers in Right
    \end{beamercolorbox}}
\vskip0pt}

% \placeat{relative-X}{relative-Y}{content}
% the relative dimensions are in terms of the page width and height
% so, \placeat{0.5}{0.5}{\includegraphics{picture}} would put a picture centered in the slide
\newcommand{\placeat}[3]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node [xshift=#1\paperwidth,yshift=#2\paperheight] at (current page.south west)%
    {\pgftext{#3}};%
  \end{tikzpicture}%
}

\DeclareDocumentCommand{\putblockat} {O{0.5\textwidth} m m O{} +m}%
{\putat{#2}{#3}{\begin{minipage}{#1}\begin{block}{#4}#5\end{block}\end{minipage}}}

\newlength{\tmpwidth}
\DeclareDocumentCommand{\getWidth} {m}%
{
  \settowidth{\tmpwidth}{#1}%
  \the\tmpwidth
}

\DeclareDocumentCommand{\genericblock} {d<> m +m}%
{%
  \IfNoValueTF {#1}%
  {%
    \settowidth{\tmpwidth}{#3}%
    \begin{minipage}[t]{\tmpwidth}%
      \begin{block}{\centering{\strut{}#2}}%
        #3%
      \end{block}%
    \end{minipage}%
  }%
  {%
    \settowidth{\tmpwidth}{#3}%
    \begin{minipage}[t]{\tmpwidth}%
      \begin{block}<#1>{\centering{\strut{}#2}}%
        #3%
      \end{block}%
    \end{minipage}%
  }%
}

\DeclareDocumentCommand{\graphicsblock} {d<> m O{} +m}%
{\genericblock<#1>{#2}{\includegraphics[#3]{#4}}}

\DeclareDocumentCommand{\paragraphblock} {d<> m O{3cm} +m}%
{\genericblock<#1>{#2}{\parbox{#3}{#4}}}

\newcommand{\putatbl}[3]{%
\pgfrememberpicturepositiononpagetrue%
\begin{pgfpicture}%
\pgfputat%
{\pgftransformshift{\pgfpointanchor{current page}{south west}}\pgftransformshift{\pgfpoint{#1}{#2}}}%
{\pgfbox[left,bottom]{#3}}%
\end{pgfpicture}%
}

\newcommand{\putatbr}[3]{%
\pgfrememberpicturepositiononpagetrue%
\begin{pgfpicture}%
\pgfputat%
{\pgftransformshift{\pgfpointanchor{current page}{south east}}\pgftransformshift{\pgfpoint{-#1}{#2}}}%
{\pgfbox[right,bottom]{#3}}%
\end{pgfpicture}%
}

\newcommand{\putatul}[3]{%
\pgfrememberpicturepositiononpagetrue%
\begin{pgfpicture}%
\pgfputat%
{\pgftransformshift{\pgfpointanchor{current page}{north west}}\pgftransformshift{\pgfpoint{#1}{-#2}}}%
{\pgfbox[left,top]{#3}}%
\end{pgfpicture}%
}

\newcommand{\putatur}[3]{%
\pgfrememberpicturepositiononpagetrue%
\begin{pgfpicture}%
\pgfputat%
{\pgftransformshift{\pgfpointanchor{current page}{north east}}\pgftransformshift{\pgfpoint{-#1}{-#2}}}%
{\pgfbox[right,top]{#3}}%
\end{pgfpicture}%
}

\let\putat\putatbl

\AtBeginSection%
%%%% The square brackets are for \section* %%%%
[
]
%%%% The curly braces are for \section %%%%
{
  \begin{frame}{Table of Contents}
    \begin{minipage}[t][7cm][t]{1.7cm}
      \makebox{} % Empty content to "fill" the minipage, otherwise it doesn't generate one...
    \end{minipage}
    \begin{minipage}[t][7cm][t]{9cm}
      \tableofcontents[currentsection]
      \vfil % This centers the content vertically. I can't get it to align to the top for some reason...
    \end{minipage}
  \end{frame}
}
