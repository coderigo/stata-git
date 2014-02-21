{smcl}
{cmd:help git} {right:also see:  {help ssc }}
{hline}

{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{hi: git} {hline 2}}Manage git repositories through a series of basic commands. It installs, updates, lists and removes git repositories containing Stata user-written programs. An alternative to sharing through {cmd: ssc} or {cmd: net}{p_end}
{p2colreset}{...}

{title:Author}

{pstd}
Rodrigo Martell {opt rodrigo.martell@gmail.com}. Github - {opt github.com/coderigo/stata-git}.{p_end}


{title:Syntax}

{p 8 13 5}
{cmd:git} {it: command}

{synoptset 21 tabbed}{...}
{synopthdr: command}
{synoptline}
{synopt : {cmd:install} {it:repository}}Install program in {it:repository} (url or filepath).{p_end}
{synopt : {cmd:uninstall} {it:programName}}Uninstall {it: programName} and its repository previously installed with {cmd: git install}.{p_end}
{synopt : {cmd:update} {it:programName}}Update {it: programName}'s repository previously installed with {cmd: git install}.{p_end}
{synopt : {cmd:list}}List all repositories managed by {cmd: git}.{p_end}

{title:Description}

{pstd}
{opt git} Manages git repositories through a series of basic commands. It installs, updates, lists and removes git repositories containing Stata user-written programs. An alternative to sharing through {cmd: ssc} or {cmd: net}. Git repositories are saved in the same location as the {cmd: ado} and {cmd: personal} directories{p_end}

{title:Creating a git repository containing a Stata module}

{p 4 4 2} A few handy tips to make it work with {cmd: git}:{p_end}

{p 4 4 2} 1. Use the snake-case format for your repository name and prefix it with "stata". For example, if your program {it: helloWorld}, your repository should be called {it:stata-hello-world}.{p_end}

{p 4 4 3} 2. Use the {it: camelCase} for your program name and any installable other auxiliary files including the {it: .sthlp} file.{p_end}

{p 4 4 3} 3. Place all the files you want to be copied over in the root of your repository.{p_end}

{p 4 4 3} 4. It works nicely (and it's easier for community collaboration) if you host your repository on a public repo like {it:github}{p_end}.

{title:Examples}

{phang}{cmd:. git install https://github.com/coderigo/stata-switch}{p_end}
{phang}{cmd:. git update switch}{p_end}
{phang}{cmd:. git list}{p_end}
{phang}{cmd:. git uninstall switch}{p_end}
