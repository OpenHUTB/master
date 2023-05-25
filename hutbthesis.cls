%
% 本模版根据湖南工商大学本科生学位论文撰写规范创建
% 论文内容一般应由十一个主要部分组成，依次为：
% 1.封面
% 2.中文摘要；
% 3.英文摘要；
% 4.目录；
% 5.符号说明（必要时）；
% 6.论文正文；
% 7.参考文献；
% 8.致谢。
%
%
% 重构
% 参考CSU Thesis，以及SJTU Thesis和WHU Thesis Latex模板进行重构。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 声明部分（Identification）
%
% 指定模板使用的 Latex 版本，标识输出模板名
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hutbthesis}[v0.1, edited by tp2008]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 预先定义（Preliminary declarations）
% 
% 定义kv对，在模板文件中使用的指令并引入依赖的包
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 定义一些命令用于写文档
% /cs 在ltxdoc 包中也提供，剩下是自定义的
% 借鉴自thuthesis和ustcthesis模板
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}

% 模板类型选取
\newif\ifhutb@type@bachelor
\hutb@type@bachelortrue
\newif\ifhutb@type@master
\hutb@type@masterfalse
\newif\ifhutb@type@doctor
\hutb@type@doctorfalse
\newif\ifhutb@type@course
\hutb@type@coursefalse
\newif\ifhutb@type@print
\hutb@type@printfalse
\newif\ifhutb@type@graduate
\hutb@type@graduatefalse
\ifhutb@type@master
    \hutb@type@graduatetrue
\fi
\ifhutb@type@doctor
    \hutb@type@graduatetrue
\fi

% 定义致谢环境，盲审下隐藏致谢
\newif\ifhutb@review
\hutb@reviewfalse

% 定义模板选项
\DeclareOption{doctor}{\hutb@type@doctortrue}
\DeclareOption{master}{\hutb@type@mastertrue}
\DeclareOption{bachelor}{\hutb@type@bachelortrue}
\DeclareOption{course}{\hutb@type@coursetrue}
%\DeclareOption{forprint}{\hutb@type@printtrue}
% 使用 \XeTeX{} 引擎时，\pkg{fontspec} 宏包会被 \pkg{xeCJK} 自动调用。传递给
% \pkg{fontspec} 宏包 \opt{no-math} 选项，避免部分数学符号字体自动调整为 CMR。
% 并使用 \opt{quiet} 忽略警告。
%    \begin{macrocode}
% \PassOptionsToPackage{no-math,quiet}{fontspec}
\PassOptionsToPackage{no-math}{fontspec}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax


% 读取基类
% \LoadClass[a4paper,12pt]{article}
\LoadClass[UTF8,openany,a4paper,oneside,zihao=-4]{ctexbook}
% 注意openany和oneside参数，默认是无空白页不区分双面印。

% 加载宏包
% 引擎执行判断宏包
\RequirePackage{ifxetex}
% 加载xparse宏包
\RequirePackage{xparse}
% 报错与警告
\NewDocumentCommand{\hutb@error}{ m o }{
    \ClassError{hutbthesis_error}{#1}{#2}
}
\NewDocumentCommand{\hutb@warning}{m o }{
    \ClassWarning{hutbthesis_warning}{#1}{#2}
}

\RequireXeTeX
\ifxetex
    % Pass
\else
    \hutb@error{Please use xelatex driver instead of pdflatex.}
\fi

% 支持中文的 ctex 宏包
\RequirePackage{ctex}
% 页面布局
\RequirePackage{geometry}
% 使用 \pkg{amsmath} 处理数学公式
\RequirePackage{amsmath}
% 下面的数学宏包和unicode-math 冲突
% \RequirePackage{amsfonts}
% \RequirePackage{amssymb}
% \RequirePackage{bm}
% 使用 \pkg{unicode-math} 处理数学字体
\RequirePackage{unicode-math}
% 算法排版宏包
\RequirePackage[chapter]{algorithm}
\RequirePackage{algorithmic}
\floatname{algorithm}{算法}

% 自定义关键词
\RequirePackage{pgfkeys}
% 设置目录
\RequirePackage{titletoc}
% 设置字体
\RequirePackage{fontenc}
% 设置颜色
\RequirePackage{xcolor}
% 下划线换行
\RequirePackage{ulem}
% 设置页眉和页脚
\RequirePackage{fancyhdr}
% 代码高亮
% 注：该包依赖python环境Pygments语法高亮显示工具包
% 并且需要 -shell-escape参数
% TODO: 日后需要修改为可配置

% 超链接 hyperref 的设置
% 提供书签与链接
\RequirePackage{hyperref}
% 插入图片
\RequirePackage{graphicx}
% 表格
\RequirePackage{array}
% 长表格
\RequirePackage{longtable}
% booktabs 提供了\toprule 等命令.
\RequirePackage{booktabs}
% multirow 支持在表格中跨行
\RequirePackage{multirow}
% 调整间隔, 让表格更好看些
\RequirePackage{bigstrut}
%在跨行表格中输入定界符
\RequirePackage{bigdelim}
% 保护脆弱命令
\RequirePackage{cprotect}
% 设置代码高亮
% \RequirePackage{minted}
% 设置代码环境
\RequirePackage{listings}
\lstset{
 breaklines,
 columns=fixed,       
 numbers=none,                                        % 在左侧显示行号
 numberstyle=\tiny\color{gray},                       % 设定行号格式
 frame=single,                                        % 不显示背景边框
 rulecolor=\color{black},                             % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. commens (green here))
%  backgroundcolor=\color[RGB]{245,245,244},            % 设定背景颜色
 keywordstyle=\color[RGB]{40,40,255},                 % 设定关键字颜色
 numberstyle=\footnotesize\color{darkgray},           
 commentstyle=\it\color[RGB]{0,96,96},                % 设置代码注释的格式
 stringstyle=\rmfamily\slshape\color[RGB]{128,0,0},   % 设置字符串格式
 showstringspaces=false,                              % 不显示字符串中的空格
 language=c++,                                        % 设置语言
 aboveskip=20pt
}


% jing: ccaption宏包不能出现在 caption 宏包之后
% 设置浮动体的标题
\RequirePackage[justification=centering]{caption}
\RequirePackage[justification=centering]{subcaption}
% 定制列表环境
\RequirePackage{enumitem}
% 提供\AtBeginEnvironment以方便全局调整一些结构的设置
\RequirePackage{etoolbox}
% 确定宏定义的位置
\RequirePackage{filehook}
% 枚举
\RequirePackage{enumitem}
% 末尾页
\RequirePackage{lastpage}
% 
% \RequirePackage{hypdoc}

% 参考文献格式 GB/T7714-2015
% 来自https://github.com/hushidong/biblatex-gb7714-2015
\RequirePackage[backend=biber,gbpub=false, style=gb7714-2015]{biblatex}

\AtEndOfClass{
% 根据模板类型加载不同配置

%\input{undergraduate.cls}
%\ifhutb@type@graduate
%    \input{graduate.cls}
%\else
%    \input{undergraduate.cls}
%    % \input{test.cls}
%\fi
}


% 字体配置
\let\sjtu@font@family@xits\@empty
\newcommand\sjtu@font@set@xits@names{%
	\ifx\sjtu@font@family@xits\@empty
	\IfFontExistsTF{XITSMath-Regular.otf}{%
		\gdef\sjtu@font@family@xits{XITS}%
		\gdef\sjtu@font@style@xits@rm{Regular}%
		\gdef\sjtu@font@style@xits@bf{Bold}%
		\gdef\sjtu@font@style@xits@it{Italic}%
		\gdef\sjtu@font@style@xits@bfit{BoldItalic}%
		\gdef\sjtu@font@name@xits@math@rm{XITSMath-Regular}%
		\gdef\sjtu@font@name@xits@math@bf{XITSMath-Bold}%
	}{%
		\gdef\sjtu@font@family@xits{xits}%
		\gdef\sjtu@font@style@xits@rm{regular}%
		\gdef\sjtu@font@style@xits@bf{bold}%
		\gdef\sjtu@font@style@xits@it{italic}%
		\gdef\sjtu@font@style@xits@bfit{bolditalic}%
		\gdef\sjtu@font@name@xits@math@rm{xits-math}%
		\gdef\sjtu@font@name@xits@math@bf{xits-mathbold}%
	}%
	\fi
}
\let\sjtu@font@family@libertinus\@empty
\newcommand\sjtu@font@set@libertinus@names{%
	\ifx\sjtu@font@family@libertinus\@empty
	\IfFontExistsTF{LibertinusSerif-Regular.otf}{%
		\gdef\sjtu@font@family@libertinus@serif{LibertinusSerif}%
		\gdef\sjtu@font@family@libertinus@sans{LibertinusSans}%
		\gdef\sjtu@font@name@libertinus@math{LibertinusMath-Regular}%
		\gdef\sjtu@font@style@libertinus@rm{Regular}%
		\gdef\sjtu@font@style@libertinus@bf{Bold}%
		\gdef\sjtu@font@style@libertinus@it{Italic}%
		\gdef\sjtu@font@style@libertinus@bfit{BoldItalic}%
	}{%
		\gdef\sjtu@font@family@libertinus@serif{libertinusserif}%
		\gdef\sjtu@font@family@libertinus@sans{libertinussans}%
		\gdef\sjtu@font@name@libertinus@math{libertinusmath-regular}%
		\gdef\sjtu@font@style@libertinus@rm{regular}%
		\gdef\sjtu@font@style@libertinus@bf{bold}%
		\gdef\sjtu@font@style@libertinus@it{italic}%
		\gdef\sjtu@font@style@libertinus@bfit{bolditalic}%
	}%
	\fi
}
\newcommand\sjtu@set@font@xits{%
	\sjtu@font@set@xits@names
	\setmainfont{\sjtu@font@family@xits}[
	Extension      = .otf,
	UprightFont    = *-\sjtu@font@style@xits@rm,
	BoldFont       = *-\sjtu@font@style@xits@bf,
	ItalicFont     = *-\sjtu@font@style@xits@it,
	BoldItalicFont = *-\sjtu@font@style@xits@bfit,
	]
}
\newcommand\sjtu@set@font@times{%
	\setmainfont{Times New Roman}[Ligatures = Rare]
	\setsansfont{Arial}
	\setmonofont{Courier New}[Scale = MatchLowercase]
}
\newcommand\sjtu@set@font@stix{%
	\setmainfont{STIX2Text}[
	Extension      = .otf,
	UprightFont    = *-Regular,
	BoldFont       = *-Bold,
	ItalicFont     = *-Italic,
	BoldItalicFont = *-BoldItalic,
	]
}
\newcommand\sjtu@set@font@step{%
	\setmainfont{STEP}[
	Extension      = .otf,
	UprightFont    = *-Regular,
	BoldFont       = *-Bold,
	ItalicFont     = *-Italic,
	BoldItalicFont = *-BoldItalic,
	]
}
\newcommand\sjtu@set@font@source@sans@mono{%
	\setsansfont{SourceSansPro}[
	Extension      = .otf,
	UprightFont    = *-Regular ,
	ItalicFont     = *-RegularIt ,
	BoldFont       = *-Bold ,
	BoldItalicFont = *-BoldIt,
	]
	\setmonofont{SourceCodePro}[
	Extension      = .otf,
	UprightFont    = *-Regular ,
	ItalicFont     = *-RegularIt ,
	BoldFont       = *-Bold ,
	BoldItalicFont = *-BoldIt,
	Scale          = MatchLowercase,
	]
}
\newcommand\sjtu@set@font@termes{%
	\setmainfont{texgyretermes}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-italic,
	BoldItalicFont = *-bolditalic,
	]%
}
\newcommand\sjtu@set@font@pagella{%
	\setmainfont{texgyrepagella}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-italic,
	BoldItalicFont = *-bolditalic,
	]%
}
\newcommand\sjtu@set@font@texgyre@sans@mono{%
	\setsansfont{texgyreheros}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-italic,
	BoldItalicFont = *-bolditalic,
	]%
	\setmonofont{texgyrecursor}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-italic,
	BoldItalicFont = *-bolditalic,
	]%
}
\newcommand\sjtu@set@font@cambria{%
	\setmainfont{Cambria}
	\setsansfont{Calibri}
	\setmonofont{Consolas}[Scale = MatchLowercase]
}
\newcommand\sjtu@set@font@libertinus{%
	\sjtu@font@set@libertinus@names
	\setmainfont{\sjtu@font@family@libertinus@serif}[
	Extension      = .otf,
	UprightFont    = *-\sjtu@font@style@libertinus@rm,
	BoldFont       = *-\sjtu@font@style@libertinus@bf,
	ItalicFont     = *-\sjtu@font@style@libertinus@it,
	BoldItalicFont = *-\sjtu@font@style@libertinus@bfit,
	]%
	\setsansfont{\sjtu@font@family@libertinus@sans}[
	Extension      = .otf,
	UprightFont    = *-\sjtu@font@style@libertinus@rm,
	BoldFont       = *-\sjtu@font@style@libertinus@bf,
	ItalicFont     = *-\sjtu@font@style@libertinus@it,
	]%
	\setmonofont{lmmonolt10}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-oblique,
	BoldItalicFont = *-boldoblique,
	]%
}
\newcommand\sjtu@set@font@lm{%
	\setmainfont{lmroman10}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-italic,
	BoldItalicFont = *-bolditalic,
	]%
	\setsansfont{lmsans10}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-oblique,
	BoldItalicFont = *-boldoblique,
	]%
	\setmonofont{lmmonolt10}[
	Extension      = .otf,
	UprightFont    = *-regular,
	BoldFont       = *-bold,
	ItalicFont     = *-oblique,
	BoldItalicFont = *-boldoblique,
	]%
}
% 使用 \pkg{unicode-math} 配置数学字体。
\unimathsetup{
	math-style = ISO,
	bold-style = ISO,
	nabla      = upright,
	partial    = upright,
}
\newcommand\sjtu@set@math@font@xits{%
	\sjtu@font@set@xits@names
	\setmathfont{\sjtu@font@name@xits@math@rm}[
	Extension    = .otf,
	BoldFont     = \sjtu@font@name@xits@math@bf,
	StylisticSet = 8,
	]%
	\setmathfont{\sjtu@font@name@xits@math@rm}[
	Extension    = .otf,
	BoldFont     = \sjtu@font@name@xits@math@bf,
	StylisticSet = 1,
	range        = {cal,bfcal},
	]%
}
\newcommand\sjtu@set@math@font@stix{%
	\setmathfont{STIX2Math}[
	Extension    = .otf,
	StylisticSet = 8,
	]%
	\setmathfont{STIX2Math}[
	Extension    = .otf,
	StylisticSet = 1,
	range        = {cal,bfcal},
	]%
}
\newcommand\sjtu@set@math@font@step{%
	\setmathfont{STEPMath-Regular}[
	Extension    = .otf,
	BoldFont     = STEPMath-Bold,
	StylisticSet = 8,
	]%
	\setmathfont{STEPMath-Regular}[
	Extension    = .otf,
	BoldFont     = STEPMath-Bold,
	StylisticSet = 1,
	range        = {cal,bfcal},
	]%
}
\newcommand\sjtu@set@math@font@termes{%
	\setmathfont{texgyretermes-math.otf}
}
\newcommand\sjtu@set@math@font@pagella{%
	\setmathfont{texgyrepagella-math.otf}
}
\newcommand\sjtu@set@math@font@cambria{%
	\setmathfont{Cambria Math}
}
\newcommand\sjtu@set@math@font@libertinus{%
	\sjtu@font@set@libertinus@names
	\setmathfont{\sjtu@font@name@libertinus@math .otf}%
}
\newcommand\sjtu@set@math@font@lm{%
	\setmathfont{latinmodern-math.otf}%
}
%    \end{macrocode}
%
% 设置西文字体集。
%    \begin{macrocode}
\newcommand\sjtu@load@fontset@xits{%
	\sjtu@set@font@xits
	\sjtu@set@font@source@sans@mono
	\sjtu@set@math@font@xits
}
\newcommand\sjtu@load@fontset@times{%
	\sjtu@set@font@times
	\sjtu@set@math@font@xits
}
\newcommand\sjtu@load@fontset@stix{%
	\sjtu@set@font@stix
	\sjtu@set@font@source@sans@mono
	\sjtu@set@math@font@stix
}
\newcommand\sjtu@load@fontset@step{%
	\sjtu@set@font@step
	\sjtu@set@font@source@sans@mono
	\sjtu@set@math@font@step
}
\newcommand\sjtu@load@fontset@termes{%
	\sjtu@set@font@termes
	\sjtu@set@font@texgyre@sans@mono
	\sjtu@set@math@font@termes
}
\newcommand\sjtu@load@fontset@pagella{%
	\sjtu@set@font@pagella
	\sjtu@set@font@texgyre@sans@mono
	\sjtu@set@math@font@pagella
}
\newcommand\sjtu@load@fontset@cambria{%
	\sjtu@set@font@cambria
	\sjtu@set@math@font@cambria
}
\newcommand\sjtu@load@fontset@libertinus{%
	\sjtu@set@font@libertinus
	\sjtu@set@math@font@libertinus
}
\newcommand\sjtu@load@fontset@lm{%
	\sjtu@set@font@lm
	\sjtu@set@math@font@lm
}
\newcommand\sjtu@load@fontset@none{\relax}
%    \end{macrocode}
%
% 载入西文字体集。
%    \begin{macrocode}
% \newcommand\sjtu@load@fontset{%
	%   \@nameuse{sjtu@load@fontset@\sjtu@latinfontset}
	% }
% latinfontset 是hutb的key 使用 对应的kv接口调用  现在没有实现
% \sjtu@load@fontset@latinfontset
\sjtu@load@fontset@times
% linux系统请使用 stix
% \sjtu@load@fontset@stix
% \sjtu@option@hook{sjtu}{latinfontset}{%
	%   \sjtu@load@fontset
	% }


\newcommand\hutb@pdfbookmark[2]{}
% 定义通用的chapter命令
\NewDocumentCommand{\hutb@chapter}{s m}{
  \if@openright\cleardoublepage\else\clearpage\fi
%   \addcontentsline{toc}{chapter}{#1}%
%   \hutb@pdfbookmark{0}{#1}
  \IfBooleanTF{#1}{
      \hutb@pdfbookmark{0}{#2}
  }{
      \addcontentsline{toc}{chapter}{#2}
  }
  \chapter*{#2}
}


\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    linktoc            = all,
    bookmarksdepth     = 2,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    unicode            = true,
    psdextra           = true,
    breaklinks         = true,
    plainpages         = false,
    pdfdisplaydoctitle = true,
    hidelinks,
  }
  \newcounter{hutb@bookmark}
  \renewcommand\hutb@pdfbookmark[2]{%
    \phantomsection
    \stepcounter{hutb@bookmark}%
    \pdfbookmark[#1]{#2}{hutbchapter.\thehutb@bookmark}%
  }
%   \renewcommand\sjtu@phantomsection{%
%     \phantomsection
%   }
%   \pdfstringdefDisableCommands{%
%     \let\\\@empty
%     \let\quad\@empty
%     \let\hspace\@gobble
%   }
%   \@ifpackagelater{hyperref}{2019/04/27}{}{%
%     \g@addto@macro\psdmapshortnames{\let\mu\textmu}
%   }%
%   \AtBeginDocument{%
%     \hypersetup{
%       pdftitle    = \sjtu@info@title,
%       pdfsubject  = \sjtu@name@subject,
%       pdfkeywords = \sjtu@info@keywords,
%       pdfauthor   = \sjtu@info@author,
%       pdfcreator  = {LaTeX with SJTUThesis \version}
%     }
%   }%
}


% 定制titlepage
% 定义命令和定义相应的宏。
%----------------------------------------------------------------------%
% 预定义全局使用的文字，如姓名、专业等信息，在content/info.tex中定义
%----------------------------------------------------------------------%
% 以下定义封面相关命令和相应的宏，以titleen为例，\titleen为实际在源码中使用的命令，一旦执行就会因为\gdef\@titleen{#1}使得其产生一个\@titleen的宏，而该宏能够在后续的环境中使用。
% TODO: 之后版本迁移至公共模板入口hutbthesis.cls 处（放置在引入子模版之后）
\newcommand*{\titlecn}[1]{\gdef\@titlecn{#1}}                           % 中文标题
\newcommand*{\titleen}[1]{\gdef\@titleen{#1}}                           % 英文标题
\newcommand*{\priormajor}[1]{\gdef\@priormajor{#1}}                     % 一级学科（学科专业）
\newcommand*{\minormajor}[1]{\gdef\@minormajor{#1}}                     % 二级学科（学科方向）
\newcommand*{\interestmajor}[1]{\gdef\@interestmajor{#1}}               % 研究方向，关键词组
\newcommand*{\department}[1]{\gdef\@department{#1}}                     % 二级培养单位
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}                     % 导师
\newcommand*{\myclass}[1]{\gdef\@myclass{#1}}                           % 班级
\newcommand*{\subsupervisor}[1]{\gdef\@subsupervisor{#1}}               % 副导师
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}                       % 学号

\newcommand*{\clcnumber}[1]{\gdef\@clcnumber{#1}}                       % 中图分类号 Chinese Library Classification
\newcommand*{\schoolcode}[1]{\gdef\@schoolcode{#1}}                     % 学校代码
\newcommand*{\udc}[1]{\gdef\@udc{#1}}                                   % UDC
\newcommand*{\academiccategory}[1]{\gdef\@academiccategory{#1}}         % 学术类别

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 页面布局
%
% 设置页边距以及版芯行间距设置
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 边距要求上2.5cm，下2.5cm，左3cm，右2cm
\geometry{top=2.5cm,bottom=2.5cm,left=3cm,right=2cm}
% 本科生从摘要开始就要有
% 设置页眉和页脚 %
\pagestyle{fancy}
% 本科学位论文底部样式
\newcommand{\hutb@thepage@format@zh}[2]{第~{#1}~页 共~{#2}~页}
\newcommand{\hutb@thepage@format@en}[1]{#1}
% 空白页清空页眉页脚
\patchcmd{\cleardoublepage}{\newpage}{\thispagestyle{empty}\newpage}{}{}
% 对章节首页的特殊page style清除页眉页脚
\patchcmd{\chapter}{\thispagestyle}{\@gobble}{}{}
% 内芯页眉设置
\ifhutb@type@print
\fancyhead[L]{\includegraphics[scale=0.10]{hutb_logo_maoti.png}}
\else
\fancyhead[L]{\includegraphics[scale=0.10]{hutb_logo_maoti.png}}
\fi
% \fancyhf[RH]{\heiti \zihao{-5} {图像与激光融合的轨道扣件脱落检测}} % 设置所有（奇数和偶数）右侧页眉
% UPDATE 更新配置为论文标题
\fancyhf[RH]{\heiti \zihao{-5} {\@titlecn}}
% frontmatter设置
\renewcommand{\frontmatter}{
	\cleardoublepage
	\@mainmatterfalse
	% 根据学校要求使用大罗马编号
	\pagenumbering{Roman}
	\def\hutb@thepage{\thepage}
	\def\hutb@lastpageref{\pageref{LastPage}}
	\fancyfoot[C]{\zihao{-5}  \hutb@thepage@format@en{\hutb@thepage}}
}
% mainmatter设置
\renewcommand{\mainmatter}{
	\cleardoublepage
	\@mainmattertrue
	% 正文部分启用阿拉伯数字编号
	\pagenumbering{arabic}
	\def\hutb@thepage{\thepage}
	\def\hutb@lastpageref{\pageref{LastPage}}
	\fancyfoot[C]{\zihao{-5} \songti \hutb@thepage@format@zh{\hutb@thepage}{\hutb@lastpageref}}
}
% 给页眉留足空间（否则会有 \headheight is too small的warning）
\setlength{\headheight}{14.5pt}
% “磅”是衡量印刷字体大小的单位,约等于七十二分之一英寸。
% 而 1英寸＝25.4毫米，则1磅＝25.4/72≈0.353毫米。
% 磅和 LaTeX的 pt- points (大约 1/72 inch) 是一致的。
% 基本行间距设置
\renewcommand*{\baselinestretch}{1.3}   % 几倍行间距
\setlength{\baselineskip}{20pt}         % 基准行间距
% \setlength{\bibsep}{0.5ex} % 参考文献条目间距



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 字体设置
%
% 进行相关字体设置，定义必须的新字体
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Times New Roman目前只能在Windows上使用，需要增加Linux系统字体
% \setmainfont{Times New Roman}
% \setmonofont{Courier New}
% \setsansfont{Arial}
% \newfontfamily{\enheiti}{SimHei} % 解决标题英文括号不显示黑体
% \newfontfamily{\enheiti}{\heiti}
% \renewcommand\normalsize{%
	% 	\@setfontsize\normalsize{12.05}{14.45}%
	% 	\abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
	% 	\abovedisplayshortskip \z@ \@plus3\p@
	%     \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
	% }
% 协议页的标题按模板是华文新魏
% \setCJKfamilyfont{hwxw}{STXinwei}
% \newcommand{\huawenxinwei}{\CJKfamily{hwxw}}
% 实现楷体GB_2312
% \setCJKfamilyfont{kaitigb}{KaiTi_GB2312.ttf}
% \newcommand{\kgb}{\CJKfamily{kaitigb}}
% 重定义ctex定义好的宋体和黑体，以支持伪加粗AutoFakeBold
% 即支持类似word里的给黑体、宋体等中文字体加粗的操作，用\bfseries
% \let\heiti\relax
% \newCJKfontfamily[hei]\heiti{SimHei}[AutoFakeBold]
% \let\songti\relax
% \newCJKfontfamily[song]\songti{SimSun}[AutoFakeBold]
% \newcommand{\kaiti}{\CJKfamily{kai}}
% \newcommand{\kgb}{\CJKfamily{kai}}
% 设置参考文献的字体格式
% \renewcommand{\bibfont}{\zihao{5} \kgb}


% 预定义名称
\newcommand*{\hutb@name@cover}{扉页}
\newcommand*{\hutb@name@declaration@zh}{声明}
\newcommand*{\hutb@name@abstract@zh}{中文摘要}
\newcommand*{\hutb@name@abstract@en}{英文摘要}
\newcommand*{\hutb@name@keywords}{关键字}
\newcommand*{\hutb@name@contents}{目录}
\newcommand*{\hutb@name@listfigure}{插图清单}
\newcommand*{\hutb@name@listtable}{附表清单}
\newcommand*{\hutb@name@index}{索引}
\newcommand*{\hutb@name@figure}{图}
\newcommand*{\hutb@name@table}{表}
\newcommand*{\hutb@name@appendix}{附录}
\newcommand*{\hutb@name@acknowledge}{致谢}

%---------------------------------------------
%控制引用格式，选用上标引用
% \newcommand\supercite[2][]{%
	% \textsuperscript{\cite[#1]{#2}}}





%\newCJKfontfamily\sonti{SimSun}[BoldFont=FandolSong-Bold]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 封面扉页
%
% 提供本科毕业论文封面扉页设计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 论文日期
% 采用key-value对的方式来制定存储信息的pgf路径
\pgfkeys{/thesisdate/pgf/.cd, % 定义pgf路径
	year/.store in = \year, % 指定关键词year的存储位置为\year
	month/.store in = \month % 指定关键词month的存储位置为\month
}
% 利用上述的pgf的key-value定制论文日期命令
\newcommand{\thesisdate}[1] {
	\pgfkeys{/thesisdate/pgf/.cd,#1} % 指定使用/thesisdate/pgf/.cd来解释参数，然后在后文能直接使用存储位置来指定解释的内容
	\gdef\@thesisdate{\year{} 年 \month{} 月} % 将构建好的日期存储到宏（\@thesisdate）中
}
% 重定义\maketitle实现封面（扉页）绘制
\RenewDocumentCommand{\maketitle}{}{%
	\hutb@pdfbookmark{0}{\hutb@name@cover}
	\hutb@make@cover@zh%
}
% 构建封面绘制宏
\NewDocumentCommand{\hutb@make@cover@zh}{} {
	\thispagestyle{empty}
	\begin{center}
		\vspace*{0pt}
		\begin{figure}[hbt]
			\centering
			\ifhutb@type@print
			\includegraphics[width=0.6\textwidth]{hutb_logo_maoti.png}
			\else
			\includegraphics[width=0.6\textwidth]{hutb_logo_maoti.png}
			\fi
		\end{figure}
		\vspace{0pt}
		\begingroup
		\fontsize{45}{50}\selectfont 本科毕业设计(论文) \par
		% 45磅，黑体
		\endgroup
		\vspace*{6pt}
		\begingroup
		% \zihao{1} \setmainfont{SimHei} GRADUATION DESIGN(THESIS) \par
		% \zihao{1} GRADUATION DESIGN(THESIS) \par
		% 1号，黑体
		\endgroup
		\begin{figure}[hbt]
			\centering
			\ifhutb@type@print
			\includegraphics[width=0.2\textwidth]{hutb_logo.png}
			\else
			\includegraphics[width=0.2\textwidth]{hutb_logo.png}
			\fi
		\end{figure}
		\vspace{10pt} % 空行
		\begingroup
		\linespread{1.3}
		\zihao{-2} 
		\songti
		\begin{tabular}{ll}
			\hspace{12pt} \makebox[4em][s]{\textbf{题\qquad 目：}} & \underline{\parbox[b][][c]{250pt}{\center \kaishu \@titlecn}} \\
			\hspace{12pt} \makebox[4em][s]{\textbf{学生姓名：}} & \underline{\makebox[250pt][c]{\kaishu \@author}} \\
			\hspace{12pt} \makebox[4em][s]{\textbf{学\qquad 号：}} & \underline{\makebox[250pt][c]{\kaishu \@studentid}}  \\
			\hspace{12pt} \makebox[4em][s]{\textbf{专\qquad 业：}} & \underline{\makebox[250pt][c]{\kaishu \@priormajor}}  \\
			\hspace{12pt} \makebox[4em][s]{\textbf{班\qquad 级：}} & \underline{\makebox[250pt][c]{\kaishu \@myclass}}  \\
			\hspace{12pt} \makebox[4em][s]{\textbf{指导老师：}} &  \underline{\makebox[250pt][c]{\kaishu \@supervisor}}  \\
			%\hspace{12pt} \makebox[4em][s]{学\qquad 院：} & \underline{\makebox[220pt][c]{\kaishu \@department}}  \\
			
		\end{tabular}
		\endgroup
		\par
		\vspace{40pt}
		% \vfill
		\begingroup
		{\zihao{2} \heiti 智能工程与智能制造学院 \par}
		\vspace{10pt}
		{\zihao{-2} \heiti \@thesisdate \par}
		\endgroup
	\end{center}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 诚信声明
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{declarationzh} {
	%\begin{titlepage}%
	\hutb@pdfbookmark{0}{\hutb@name@declaration@zh}
	%\renewcommand*{\headsep}{20pt}
	\vspace*{0pt}
	%	\begin{center} \zihao{-2} \heiti \@titlecn \end{center}
	\vspace{0pt}
	\begin{center} \zihao{2} \heiti 湖南工商大学本科毕业设计诚信声明 \end{center}  % 摘要为三号黑体
	\vspace{12pt}
	\linespread{1.5}
	\zihao{4}\songti  % 内容为四号宋体
	
	%\end{titlepage}%
	
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 摘要
% 
% 提供中英文摘要样式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------------------------------------
% 中文摘要
% ----------------------------------------------
% 中文摘要格式具体见样例8，居中打印论文题名（三号黑体）
% 换行顶格编排“摘要”（四号黑体）及摘要内容（四号宋体）、
% 每段开头空二格。摘要内容后下换行顶格编排“关键词”和“分类号”（四号黑体）。
% 每篇论文应选取3-8个关键词，每一关键词之间用分号分开，最后一个关键词后不打标点符号。
\newcommand*{\keywordscn}[1]{\gdef\@keywordscn{#1}} % 定义中文关键词
%\newcommand*{\categorycn}[1]{\gdef\@categorycn{#1}} % 定义中文分类
% 定义中文摘要环境
\newenvironment{abstractzh} {
	\hutb@pdfbookmark{0}{\hutb@name@abstract@zh}
	\renewcommand*{\headsep}{0pt}
	\vspace*{0pt}
	%\begin{center} \zihao{-2} \heiti \@titlecn \end{center}
	\vspace{0pt}
	\begin{center} \zihao{3} \heiti 摘\qquad  要 \end{center}  % 摘要为三号黑体
	\vspace{12pt}
	\linespread{1.5}
	\zihao{-4}\songti  % 内容为四号宋体
}
% 显示中文关键词和分类号
{
	\begin{flushleft}
		\noindent {\zihao{-4} \bfseries \songti 关键词：} {\zihao{-4} \songti \@keywordscn} \par % 关键词为小四号宋体加粗，内容为小四号宋体
	\end{flushleft}
}

% ----------------------------------------------
% 英文摘要
% ----------------------------------------------
% 英文摘要格式和内容与中文摘要相对应，另起一页，具体见样例9。居中打印论文英文题名（三号Times New Roman字体），换行顶格编排“Abstract”及英文摘要内容（四号Times New Roman字体），摘要内容每段开头留四个字符空格。摘要内容后下换行顶格编排“Keywords”和“Classification”。
% 定义英文摘要，字体全部为timesnewroman
\newcommand*{\keywordsen}[1]{\gdef\@keywordsen{#1}} % 英文关键词

\newenvironment{abstracten} { % 新建英文摘要环境
	\hutb@pdfbookmark{0}{\hutb@name@abstract@en}
	\vspace*{0pt}
	%\begin{center} \zihao{-2} \bfseries \@titleen \end{center}
	
	\begin{center} \zihao{3} \bfseries ABSTRACT \end{center}
	\vspace{12pt}
	\linespread{1.5}
	\zihao{-4} % 内容为四号宋体
}
{
	\begin{flushleft}
		\noindent {\zihao{4} \bfseries Key\ words:~} {\zihao{4} \@keywordsen} \par % 关键词为四号黑体，内容为四号宋体
	\end{flushleft}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. 目录 %
% -----------------------------------------------%
% 目录应列出论文的大标题、一级和二级节标题，逐项标明页码（具体见样例10）。各级标题应简明扼要、点出各部分主要内容。学位论文的页码编排为：正文和后置部分用阿拉伯数字编连续码，前置部分用罗马数字单独编连续码（封面除外）。
% “目录”两字居中（三号黑体），下空两行为章、节、小节及其开始页码（靠右顶格）。章、节、小节分别以阶梯式排列：1（第1章）、1.1、1.1.1依次标出。章、节、小节的题名与页码之间用“．．．．．．”连接。除“目录”两字外，其余字体均为小四号宋体。

%TODO: 本科和硕博目录格式要求不同
% \renewcommand{\contentsname}{\hfill \heiti \zihao{3} 目\quad 录\hfill}
% \renewcommand{\contentsname}{目录}
% 	\renewcommand*{\baselinestretch}{1.5}   % 行间距
%     \tableofcontents
% }
\renewcommand\tableofcontents{
\hutb@chapter*{\contentsname}
% \hutb@pdfbookmark{0}{\contentsname}

% \chapter*{目录}
% \hutb@pdfbookmark{0}{\hutb@name@contents}
\@starttoc{toc}
}



\setcounter{secnumdepth}{3}
% 定义作为标题的格式
% \titleformat{command}[shape]%定义标题类型和标题样式
%               {format}%定义标题格式
%               {label}%定义标题的标签，即标题的标号等
%               {sep}%定义标题和标号之间的水平距离
%               {before-code}%定义标题前的内容
%               [after-code]%定义标题后的内容

% TODO: 修复章节标题样式
% \renewcommand{\chaptername}{第{\thesection}章}
% \titleformat{\chapter}{\zihao{3}  \heiti \centering}{\chaptername}{1em}{}
% \titleformat{\section}{\zihao{-4}  \heiti}{\thesection}{1em}{}
% \titleformat{\subsection}{\zihao{-4}  \kaishu}{\thesubsection}{1em}{}

% 定义在目录中的格式
% \titlecontents{标题名}
%               [左间距]
%               {标题格式}
%               {标题标志}
%               {无序号标题}
%               {指引线与页码}
%               [下间距]

% \titlecontents{section}
%               [0em] % 按样例目录左侧是和前置部分文字左侧对齐的
%               {\zihao{-4} \songti}
%               %{\contentslabel {1em}}
%               {第\thecontentslabel\ 章\quad}%
%               {\hspace*{-1em}}
%               {\titlerule*[0.5pc]{.}\contentspage}

% \titlecontents{subsection}
%     [4em]
%     {\zihao{-4} \songti} % note that 3.8 = 1.5 + 2.3
%     {\contentslabel{2.2em}}
%     {\hspace*{-3.5em}}
%     {\titlerule*[0.5pc]{.}\contentspage}

% \titlecontents{subsubsection}
%     [7em]
%     {\zihao{-4} \songti} % note that 3.8 = 1.5 + 2.3
%     {\contentslabel{3.0em}}
%     {\hspace*{-5em}}
%     {\titlerule*[0.5pc]{.}\contentspage}

% 6. 符号说明（必要时）%
% ---------------------------------------------------------%
% TODO:
%
% 如果论文中使用了大量的物理量符号、标志、缩略词、专门计量单位、自定义名词和术语等，应编写成注释说明汇集表，说明论文中所用符号所表示的意义及单位（或量纲）。若上述符号和缩略词使用数量不多，可以不设专门的注释说明汇集表，仅在论文中出现时加以说明。
% “符号说明”四字居中（三号黑体）。


% 7. 论文正文 %
% -------------------------------------------------------%
% 论文正文是主体，主体部分应从另页右页开始，每一章应另起页。一般由序号标题、文字叙述、图、表格和公式等五个部分构成。
% 写作形式可因研究内容的性质不同而变化，一般可包括绪论（或综述）、理论分析、计算方法、实验装置和测试方法、实验结果分析和讨论、研究成果、结论及意义等。
% 该部分由用户编写

% 图表等浮动环境设置 %
% ----------------------------------------------------------%
% TODO %
% 图、表、公式：文中的图、表、附注、公式一律采用阿拉伯数字分章（或连续）编号，如：图2-5，表3-2，公式（5-1）等。
% 图序及图名居中置于图的下方，如果图中含有几个不同部分，应将分图号标注在分图的左上角，并在图解下列出各部分内容。图中的术语、符号、单位等应与正文表述所用一致。
% 表序及表名置于表的上方，表中参数应标明量和单位的符号。表的编排应采用国际通用的三线表。续表均应重复表头，如表需转页接排，随后各页应重复表的编号，其后跟表题（可省略）和“续”置于表上方。
% 图序及图名、表序及表名采用五号楷体字。若图或表中有附注，采用英文小写字母顺序编号，附注写在图或表的下方。公式的编号用括号括起写在右边行末，其间不加虚线。
% 图、表、公式等与正文之间要有一定的行间距。
% \RequirePackage{caption}
% 默认情况下, \LaTeX{} 要求每页的文字至少占据 20%,否则该页就只单独放置一个浮动环境,
% 而这通常不是我们想要的, 我们将这个要求降低到 5%.
\renewcommand*{\textfraction}{0.05}
% 有时如果多个浮动环境连续放在一起, \LaTeX{}
% 会将它们分在几个不同页，即使它们可在同一页放
% 得下. 我们可以通过修改 |\topfraction| 和 |\bottomfraction| 分别设置顶端和底端的浮
% 动环境的最大比例.
\renewcommand*{\topfraction}{0.9}
\renewcommand*{\bottomfraction}{0.8}
% 有时\LaTeX{}会把一个浮动环境单独放在一页,
% 我们要求这个环境至少要占据 85% 才能单独放在一页.
% 注意:  |\floatpagefraction| 的数值必须小于 |\topfraction|.
\renewcommand*{\floatpagefraction}{0.85}
% 关于图片 graphicx
% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png,.tif}
% 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}}




% 插图格式
% ------------------------------------------------------%
% \captionsetup[subfigure]{labelfont=normalfont,textfont=normalfont,singlelinecheck=off,justification=raggedright}
% singlelinecheck=off 表示即使caption只有一行， justification 也生效
% justification=raggedright 使子图 caption 靠左对齐，而caption的上下位置由\caption标签的位置决定，以此实现了学校要求的子图标签在左上角显示。
% 这部分功能由 subcaption 这个包实现，而这个包不能和 subfigure 同时使用，所以子图的写法也与 subfigure 包的不大一样。
\captionsetup[subfigure]{singlelinecheck=off,justification=raggedright}

% 图下方描述的黑体
\DeclareCaptionFont{hei}{\heiti}
\DeclareCaptionFont{five}{\zihao{5}}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
% \renewcommand{\thefigure} {\thesection-\arabic{figure}}

\captionsetup[figure]{
format=plain,      % 标题从第二行开始是否缩进，plain无缩进，hang有缩进
labelsep=quad,     % 分隔符是一个空格
font={hei,five},
position=bottom    % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
% 表格格式
% ------------------------------------------------------%
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
% \renewcommand {\thetable} {\thesection-\arabic{table}}
\captionsetup[table]{
format=plain,      % 标题从第二行开始是否缩进，plain无缩进，hang有缩进
labelsep=quad,     % 分隔符是一个空格
font={hei,five},   % 表的字体, 宋体小四
position=top
}



% 列表环境设置 %
% ------------------------------------------------------------------%
\setlist{%
topsep=0.3em, % 列表顶端的垂直空白
partopsep=0pt, % 列表环境前面紧接着一个空白行时其顶端的额外垂直空白
itemsep=0ex plus 0.1ex, % 列表项之间的额外垂直空白
parsep=0pt, % 列表项内的段落之间的垂直空白
leftmargin=1.5em, % 环境的左边界和列表之间的水平距离
rightmargin=0em, % 环境的右边界和列表之间的水平距离
labelsep=0.5em, % 包含标签的盒子与列表项的第一行文本之间的间隔
labelwidth=2em % 包含标签的盒子的正常宽度；若实际宽度更宽，则使用实际宽度。
}

% 表格 %
% ------------------------------------------------------%
% 修改tabular 环境, 设置表格中的行间距为正文行间距.
\let\hutb@oldtabular\tabular
\let\hutb@endoldtabular\endtabular
\renewenvironment{tabular} {
\bgroup
\renewcommand{\arraystretch}{0.92}
\hutb@oldtabular
} {
\hutb@endoldtabular\egroup
}

% 表格字号应比正文小，一般五号/10.5pt，但是暂时没法再cls里设置（不然会影响到封面等tabular环境）
% 所以目前只好在主文件里局部\AtBeginEnvironment

% 数学环境, 定理等设置 %
% -------------------------------------------------------%
\newtheorem{definition}{\hutb@cap@definition}
\newtheorem{theorem}{\hutb@cap@theorem}
\newtheorem{lemma}{\hutb@cap@lemma}
\newtheorem{corollary}{\hutb@cap@corollary}
\newtheorem{assumption}{\hutb@cap@assumption}
\newtheorem{conjecture}{\hutb@cap@conjecture}
\newtheorem{axiom}{\hutb@cap@axiom}
\newtheorem{principle}{\hutb@cap@principle}
\newtheorem{problem}{\hutb@cap@problem}
\newtheorem{example}{\hutb@cap@example}
\newtheorem{proof}{\hutb@cap@proof}
\newtheorem{solution}{\hutb@cap@solution}

% 数学定理相关的常量
\newcommand*{\hutb@cap@definition}{定义}
\newcommand*{\hutb@cap@theorem}{定理}
\newcommand*{\hutb@cap@lemma}{引理}
\newcommand*{\hutb@cap@corollary}{推论}
\newcommand*{\hutb@cap@assumption}{假设}
\newcommand*{\hutb@cap@conjecture}{猜想}
\newcommand*{\hutb@cap@axiom}{公理}
\newcommand*{\hutb@cap@principle}{定律}
\newcommand*{\hutb@cap@problem}{问题}
\newcommand*{\hutb@cap@example}{例}
\newcommand*{\hutb@cap@proof}{证明}
\newcommand*{\hutb@cap@solution}{解}


% TODO 测试段落后间距
% 各级标题格式设置。
\ctexset{%
chapter = {%
	format       = \zihao{3} \heiti\centering,
	name         = {第, 章},
	nameformat   = {},
	number       = \arabic{chapter},
	numberformat = {},
	titleformat  = {},
	aftername    = \quad,
	afterindent  = true,
	% beforeskip 默认为 50pt 适当缩减
	fixskip      = true,
	beforeskip   = {15pt},
	% beforeskip   = {\ifhutb@type@graduate 20pt \else 5pt\fi}
	% afterskip 默认为 40pt 适当缩减
	afterskip    = {40pt},
	% afterskip    = {\ifhutb@type@graduate 30pt\else 20pt\fi},
},
section = {%
	format       = \zihao{-4} \heiti,
	afterindent  = true,
	% beforeskip 默认为 3.5ex plus 1ex minus .2ex 适当缩减
	% beforeskip   = {20pt},
	% beforeskip   = {\ifhutb@type@graduate 30pt \else 20pt\fi}
	% afterskip 默认为 2.3ex plus .2ex 适当缩减
	afterskip    = {1ex \@plus .2ex},
},
subsection = {%
	format       = \zihao{-4} \bfseries \songti,
	afterindent  = true,
	% afterskip 默认为 2.3ex plus .2ex 适当缩减
	afterskip    = {1ex \@plus .2ex},
	%fixskip      = true,
},
subsubsection = {%
	format       = \zihao{-4} \normalfont,
	afterindent  = true,
	afterskip    = {1ex \@plus .2ex},
	%fixskip      = true,
},
}

% 定义描述距离的变量
\newlength{\hutb@headings@indent@fixed}
\setlength{\hutb@headings@indent@fixed}{2\ccwd}
\newcommand{\hutb@style@set@indent@heading}{%
\gdef\hutb@headings@indent{\hutb@headings@indent@fixed}
% \ifsjtu@type@graduate\relax\else
% 本科毕设设置四级标题
\ctexset{%
	subsubsection/name   = {(,)},
	subsubsection/number = \arabic{subsubsection},
}
% \fi
% 设标题的缩进
\ctexset{%
	section/indent       = \hutb@headings@indent,
	subsection/indent    = \hutb@headings@indent,
	subsubsection/indent = \hutb@headings@indent,
}
}
\hutb@style@set@indent@heading

% 全文首行缩进 2 字符， 标点符号用全角
% \ctexset{%
%   punct          = quanjiao,
%   space          = auto,
%   autoindent     = true,
% }

% % 编号分章节。如需要连续编号，注释\makeatletter下面对应内容即可。
% \renewcommand{\theequation}{\arabic{section}-\arabic{equation}}
% \makeatletter
% \@addtoreset{figure}{section}
% \@addtoreset{table}{section}
% \@addtoreset{equation}{section}
% \makeatother

% 8. 参考文献 %
% ------------------------------------------------------%
% TODO %
% 文后参考文献只列出作者直接阅读过、在正文中被引用过的文献资料，务必实事求是。参考文献一律列在正文的末尾，不得放在各章之后。人文社科类学位论文中不宜用文后参考文献列出的注释可采用页下注，包括对学位论文中某些关键词句、论点的详细说明。在引用别人的科研成果时，应在引用处加以说明，遵循学术道德规范，严禁论文抄袭、剽窃等学术不端行为。
% 参考文献可以采用顺序编码制组织，也可以按“著者-出版年”制组织。建议按顺序编码制，即按中文引用的顺序将参考文献附于文末。作者姓名写到第三位，余者写“，等”或“，et al.”。“参考文献”四字居中(三号黑体)，空一行左起按顺序依次列出参考文献，将序号置于方括号内(如[1])，用小四号宋体字，所有符号均用半角编排。
% 目前采用bgt7714-2005标准进行文献索引，详见gbt7714-2005.bst.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 附录
%
% 附录中主要列入正文内不便列出的过分冗长的公式推导，供查读方便所需的辅助性数学工具或表格、重复性数据图表、计算程序及说明等。
% 附录依次为附录1，附录2……等，“附录X”三字居中（三号黑体）。附录中的图表公式另编排序号，与正文分开。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义附录环境
% 在\appendix 后直接使用 chapter
% 暂不需要
% \newenvironment{appendixs}{
%     % \ifhutb@review\else
%     \hutb@chapter{\hutb@name@appendix}
%     % \fi
% }


% 10. 攻读学位期间主要研究成果 %
% --------------------------------------------------------%
% 分类按时间顺序列出作者在攻读学位期间取得的与学位论文相关的研究成果，含参加的研究项目、获奖情况、专利、专著、发表学术论文（含正式录用论文）等,书写格式参照参考文献格式。“攻读学位期间主要研究成果”字体居中（三号黑体）

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 致谢
%
% 作者对给予指导、各类资助和协助完成研究工作以及提供各种对论文工作有利条件的单位及个人表示感谢。“致谢”二字居中（三号黑体）。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义致谢环境
\newenvironment{acknowledgements}{
%   \ifhutb@review\relax\else
\ifhutb@review\else
% \hutb@chapter{\hutb@name@acknowledgements}
\hutb@chapter{\hutb@name@acknowledge}
\fi
}


% 篇眉和页码要求 %
% ---------------------------------------------------------%
% 篇眉从正文开始至全文结束，采用宋体五号字左起书写“博（或硕）士学位论文”，靠右写章标题。
% 页码从正文开始至全文结束按阿拉伯数字连续编排，前置部分（如学位论文原创性声明和版权使用授权书、中文摘要、英文摘要、目录、符号说明等）用罗马数字分别单独编排。页码位于页面底端，居中书写。




%\endinput
