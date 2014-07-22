% -*- mode: LaTeX; -*-
%%%% file tamu_thesis.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tamu_thesis}[2014/07/22 v0.6.0 TAMU Thesis]

\RequirePackage{tamu_common}

% These generates command for footnotes that I can keep for draft copies, and drop for the final. Passing the option "nomarginpar" to the tamu_thesis class removes the notes. Thus, by default, the marginpar's are visible.
\let\old@marginpar\marginpar
\renewcommand{\marginpar}[1]{\old@marginpar{\begin{SingleSpace}\tiny{#1}\end{SingleSpace}}}
\DeclareOption{nomarginpar}{\renewcommand{\marginpar}[1]{\relax}}

% By default, the links are all visible
\newcommand{\visi@links}{\hypersetup{pdfborder=0 0 1}}
\DeclareOption{invisiblelinks}{\renewcommand{\visi@links}{\hypersetup{pdfborder=0 0 0}}}

\newcounter{tref@switch}
\setcounter{tref@switch}{1}
\DeclareOption{notref}{\setcounter{tref@switch}{0}}

\newcounter{autoref@switch}
\setcounter{autoref@switch}{1}
\DeclareOption{noautoref}{\setcounter{autoref@switch}{0}}

\newcounter{hyperref@switch}
\setcounter{hyperref@switch}{1}
\DeclareOption{nohyperref}{\setcounter{hyperref@switch}{0}}

% All other options are passed through to memoir. Easy peasy.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions\relax
\LoadClass{memoir}

%
% tref is how I implement links to other parts of the document
% Use: 
% \tref{fig:figureName}
%
% Example:
% Blah blah (see \tref{fig:figureName}).}
% →
% Blah blah (see Figure 3 on the next page).
%
\ifnum\value{hyperref@switch} = 1 %
  \RequirePackage{varioref}%
  \RequirePackage[final,unicode=true]{hyperref}%
  \RequirePackage[all]{hypcap}%
  \visi@links%
  \ifnum\value{tref@switch} = 1 %
    \renewcommand{\reftextfaceafter}{ on the \reftextvario{facing}{next} page}%
    \renewcommand{\reftextfacebefore}{ on the \reftextvario{facing}{preceding} page}%
    \renewcommand{\reftextafter}{ on the \reftextvario{following}{next} page}%
    \renewcommand{\reftextbefore}{ on the \reftextvario{preceding}{previous} page}%
    %\renewcommand{\reftextcurrent}{ on \reftextvario{this}{the current} page}%
    \renewcommand{\reftextcurrent}{}%
    \renewcommand{\reftextfaraway}[1]{ on page~\pageref{#1}}%
    %
    \ifnum\value{autoref@switch} = 1 %
      \renewcommand{\tref}[1]{\autoref{#1}\vpageref*{#1}}%
    \else \renewcommand{\tref}[1]{\ref{#1}\vpageref*{#1}}%
    \fi%
  \fi%
\else \newcommand{\texorpdfstring}[2]{#1}
\fi

% This is so I can hack up starred macros easily (e.g. \chapter*{})
\RequirePackage{suffix}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Custom lower-level commands %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hyperref won't accept the use of TeX commands inside of things that will end up in the PDF ToC (e.g. titles of sections, etc), so we can use this macro to only make the text uppercase inside the document, but "normal" in the PDF tables, which looks better anyway.
\newcommand{\pdfuppercase}[1]{{\texorpdfstring{\MakeUppercase{#1}}{#1}}}

% Makes all the chapters uppercase inside the printed document by default
\let\old@chapter\chapter
\renewcommand\chapter[1]{\old@chapter{\pdfuppercase{#1}}}
\WithSuffix\newcommand\chapter*[1]{\old@chapter*{\pdfuppercase{#1}}}

% We use the unnumbered footnote to display journal model on the first page. I recommend calling this macro immediately after the first chapter is declared (with the \majorsection macro, of course)
\newcommand{\journalmodel}[1]{
  \blfootnote{#1}
  \setcounter{footnote}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Custom page-making macros %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\title@Top}[1]{
  \chapter*{\documentTitle}
  \thispagestyle{empty}
  \setcounter{page}{#1}
  \begin{SingleSpace}
    \begin{center}
      \vskip 36pt
      A \documentType\\~\\ by\\~\\ \MakeUppercase{\fullName}
      \vskip 60pt
      Submitted to the Office of Graduate Studies of \\
      Texas A\&M University \\
      in partial fulfillment of the requirements for the degree of \\
      \bigskip\MakeUppercase{\degree} \\
    \end{center}
  \end{SingleSpace}
  % \vskip 3em
}

\newcommand{\title@Bottom}{
  \begin{SingleSpace}
    \begin{center}
      \publishDate
      \vskip 48pt
      Major Subject: \major
    \end{center}
  \end{SingleSpace}
}

\newcommand{\makeTitlePage}{
    \title@Top{1}
    \vfill
    \title@Bottom
}

\newcommand{\copyrightPage}{
  \chapter*{}
  \thispagestyle{empty}
  \setcounter{page}{0}
  ~
  \vfill
  \begin{center}
    \documentTitle \\
    © \publishDate\ \fullName
  \end{center}
}

\newcommand{\signatureLine}{………………………………}
\renewcommand{\signatureLine}{}

\newcommand{\approvalPage}{
  \title@Top{2}
  \vskip 3em
  \begin{SingleSpace}
    \begin{tabbing}
      Approved by: \hskip 5em \= \hskip 12em \=\\~\\
      \committeeTitleA    \> \committeeNameA \> \signatureLine \\
      \committeeTitleB    \> \committeeNameB \> \signatureLine \\
      \committeeTitleC    \> \committeeNameC \> \signatureLine \\
      \committeeTitleD    \> \committeeNameD \> \signatureLine \\
      Head of Department, \> \deptHeadName   \> \signatureLine
    \end{tabbing}
  \end{SingleSpace}
  \vfill
  \title@Bottom
}

\newcommand{\abstractPage}{
  \chapter{Abstract}
  \setcounter{page}{3}
  \begin{center}
    \documentTitle{}. (\publishDate)\\ \fullName{}, \degreesAwarded\\ Chair of Advisory Committee: Dr. \committeeNameA
  \end{center}
  \vskip 1em
  \abstractText
}

\newcommand{\dedicationPage}[1]{
  \chapter{Dedication}
  \vfill
  \begin{center}
  \dedicationText
  \end{center}
  \vskip 256pt
  \vfill
}

\newcommand{\acknowledgementPage}{
  \chapter{Acknowledgements}
  \acknowledgeText
}

\newcommand{\bibliographyPage}{
  \printbibliography
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% All of the contents of this section are modifications  %%
%% to the memoir class, using methods as suggested in the %%
%% manual.                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\renewcommand{\bibname}{References}
\renewcommand{\bibname}{\pdfuppercase{References}}

\aliaspagestyle{chapter}{simple}
\pagestyle{simple}

%% Make URLs use the body font
\RequirePackage{url}
\@ifpackageloaded{hyperref}{\urlstyle{same}}

%% Make verbatims use the body font
\setverbatimfont{\normalfont\rmfamily}

% Small is the default footnote size...
%\renewcommand{\foottextfont}{\small}

% These are two possible ways of "numbering" footnotes
\renewcommand*{\thefootnote}{\fnsymbol{footnote}}
%\renewcommand*{\thefootnote}{\roman{footnote}}

\raggedbottom

\setlrmarginsandblock{1.4in}{1.15in}{*}
\setulmarginsandblock{1.25in}{1.25in}{*}
\setheadfoot{14pt}{14pt}
\setheaderspaces{*}{*}{0.5}
\checkandfixthelayout

\marginparmargin{left}
\setmarginnotes{0.1in}{1.25in}{0.05in}

\fixpdflayout

\midsloppy % Allows TeX more leniency when adjusting interword spacing
\clubpenalty=10000 % Makes penalty high for single lines carrying onto new pages
\widowpenalty=10000 % Makes penalty high for single lines starting at the end of a page

\renewcommand{\contentsname}{\pdfuppercase{Table of Contents}}
\renewcommand*{\aftertoctitle}{\par\nobreak{\normalfont \hfill Page}\par\nobreak}

\renewcommand{\listfigurename}{\pdfuppercase{List of Figures}}
\renewcommand*{\afterloftitle}{\par\nobreak{\normalfont \hfill Page}\par\nobreak}

\renewcommand{\listtablename}{\pdfuppercase{List of Tables}}
\renewcommand*{\afterlottitle}{\par\nobreak{\normalfont \hfill Page}\par\nobreak}

\maxsecnumdepth{subsubsection}
\setsecnumdepth{subsubsection}

\maxtocdepth{subsubsection}
\settocdepth{subsubsection}

% This sets the chapter headings according to thesis guidelines
\setlength{\beforechapskip}{0pt}
\renewcommand*{\chapterheadstart}{\vspace{\beforechapskip}}
\setlength{\afterchapskip}{24pt}
\renewcommand*{\printchaptername}{}
\renewcommand*{\chapternamenum}{}
\renewcommand*{\chapnumfont}{\large\bfseries}
\renewcommand*{\chaptitlefont}{\chapnumfont}
\renewcommand*{\printchapternum}{\centering\chapnumfont\thechapter\quad}
\renewcommand{\afterchapternum}{}
\renewcommand*{\printchapternonum}{\centering}

\setsecheadstyle{\bfseries\raggedright}
\setbeforesecskip{2ex}
\setaftersecskip{0.2ex}
%\setsecindent{-\parindent}

\setsubsecheadstyle{\itshape\bfseries\raggedright}
\setbeforesubsecskip{1.5ex}
\setaftersubsecskip{0.2ex}
%\setsubsecindent{-\parindent}

\setsubsubsecheadstyle{\itshape\raggedright}
\setbeforesubsubsecskip{1ex}
\setaftersubsubsecskip{0.2ex}
%\setsubsubsecindent{-\parindent}

\setparaheadstyle{\slshape\raggedright}
\setbeforeparaskip{0.5ex}
\setafterparaskip{0.2ex}
%\setparaindent{-\parindent}

\setsubparaheadstyle{\slshape\raggedright}
\setbeforesubparaskip{0.5ex}
\setaftersubparaskip{0.2ex}
%\setsubparaindent{-\parindent}

\renewcommand{\cftdot}{.}
\renewcommand{\cftdotsep}{0}

% This puts leaders on all levels for the ToC. The code to have no leaders for subsections and subsubsections is commented out.
\renewcommand{\cftchapterdotsep}{\cftdotsep}
\renewcommand{\cftsectiondotsep}{\cftdotsep}
\renewcommand{\cftsubsectiondotsep}{\cftdotsep}
%\renewcommand{\cftsubsectiondotsep}{\cftnodots}
\renewcommand{\cftsubsubsectiondotsep}{\cftdotsep}
%\renewcommand{\cftsubsubsectiondotsep}{\cftnodots}

% The gap for different levels. Chapters get a bigger spacing.
\setlength{\cftbeforechapterskip}{8pt}
\setlength{\cftbeforesectionskip}{0pt}
\setlength{\cftbeforesubsectionskip}{0pt}
\setlength{\cftbeforesubsubsectionskip}{0pt}
\setlength{\cftbeforefigureskip}{0pt}
\setlength{\cftbeforetableskip}{0pt}

% These are prefixes used for the different levels. In this case, the figures will appear, for example, as "Figure 2.3"
\renewcommand{\cftchaptername}{}
\renewcommand{\cftfigurename}{Figure\space}
\renewcommand{\cfttablename}{Table\space}

% This may be useful for chemistry, assuming the thesis office allows it.
%\newcommand{\listscheme}{List of Schemes}
%\newlistof{scheme}{sch}{\listscheme}

\setlength{\floatsep}{6ex}
\setlength{\textfloatsep}{6ex}
\setlength{\intextsep}{6ex}

\setfloatlocations{figure}{htpb}\setfloatlocations{table}{htpb}

\captionnamefont{\bfseries\small}
\captiontitlefont{\small}
