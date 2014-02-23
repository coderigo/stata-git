*! version 1.0
version 12.0
capture program drop git
program define git
syntax anything(name=gitArgs id="git command and arguments")

    /**
     * This requires that you have git installed and accessible through the command line.
     * For instructions on installing git, see: http://git-scm.com/downloads
    */
    di as yellow "------ WARNING:---------"
    di as yellow " This program requires git to be accessible through the command line."
    di as yellow " See http://git-scm.com/downloads"
    di as yellow "------------------------"
    /*
    OS-dependent vars
    */
    local os         = "`c(os)'"
    local adoPlusDir = "`c(sysdir_plus)'"
    if("`os'" != "Windows"){
        local adoPlusDir = subinstr("`adoPlusDir'","~","/Users/`c(username)'",.)
    }
    local adoDir    = trim(subinstr("`adoPlusDir'","ado/plus/","",.))
    local gitDir    = "`adoDir'git/"
    local copyCmd   = "cp" /* Defaults to *nix command */
    local deleteCmd = "rm" /* Defaults to *nix command */
    local origDir   = "`c(pwd)'"
    local lsCmd     = "ls" /* Defaults to *nix command */
    local rmdirCmd  = "rm -rf" /* Defaults to *nix command */
    if("`os'" == "Windows"){
        local copyCmd   = "copy"
        local deleteCmd = "erase"
        local lsCmd     = "dir"
        local rmdirCmd  = "rmdir /Q /S"
    }

    /*
    Make the git program dir if not there and cd to it
     */
    capture confirm file "`gitDir'"
    if _rc!=0{
        mkdir "`gitDir'"
    }
    qui cd "`gitDir'"

    /*
    Command parsing
     */
    if(strpos("`gitArgs'"," ") >0){
        local gitCommand = trim(substr("`gitArgs'",1, strpos("`gitArgs'"," ")))
    }
    else{
        local gitCommand = trim("`gitArgs'")
    }
    local gitParam1  = trim(subinstr("`gitArgs'","`gitCommand'","",1))

    /* Translate "install" to "clone". "install" is used to be consistent with the ssc command */
    if("`gitCommand'" == "install"){

        /* Get the name of the repo - Stata has no equivalent to JS (or others) of string split */
        local repoName     = subinstr("`gitParam1'",".git","",.)
        local separatorPos = strpos("`repoName'","/")
        while `separatorPos' > 0 {
            local repoName     = trim(substr("`repoName'", `separatorPos'+1, length("`repoName'")-`separatorPos'))
            local separatorPos = strpos("`repoName'","/")
        }

        /* Get the name of the command snake-cased */
        local commandSnakeName = "`repoName'"
        local dashPos = strpos("`commandSnakeName'", "-")
        while `dashPos' > 0 {
            local commandSnakeName = trim(substr("`commandSnakeName'", `dashPos'+1, length("`commandSnakeName'")-`dashPos'))
            local dashPos = strpos("`commandSnakeName'", "-")
        }

        /* Create the repo */
        local repoDir = "`gitDir'`repoName'/"
        capture confirm file "`repoDir'"
        if _rc!=0{
            mkdir "`repoDir'"
        }
        else{
            /* Return to old directory */
            di as green "`repoName' already installed"
            di as green "type - git update `repoName' - to get the latest and greatest."
            qui cd "`origDir'"
            exit
        }
        shell git clone "`gitParam1'"

        /* Copy all .ado and .sthlp files to the right directory */
        local programFirstLetter = lower(substr(subinstr("`repoName'","stata-","",.),1,1))
        local programDir         = "../ado/plus/`programFirstLetter'/"
        capture confirm file "`programDir'"
        if _rc!=0{
            mkdir "`programDir'"
        }
        qui cd "`repoName'"
        shell `copyCmd' *.ado "`adoPlusDir'`programFirstLetter'"
        capture shell `copyCmd' *.sthlp "`adoPlusDir'`programFirstLetter'"
        capture shell `copyCmd' *.mmat "`adoPlusDir'`programFirstLetter'"

        /* Return to old directory */
        qui cd "`origDir'"

        di as green "Done installing `commandSnakeName' from the `repoName' git repository"
        di as green "Type -help `commandSnakeName'-"

    }

    /* Translate "uninstall" to just removing the repo */
    if("`gitCommand'" == "uninstall" | "`gitCommand'" == "update"){

        /* Convert from camel case to snake case*/
        local commandCamelCase   = "`gitParam1'"
        local repoName           = "stata-`commandCamelCase'"
        local lengthOfName       = length("`repoName'")
        local programFirstLetter = substr("`commandCamelCase'",1,1)
        if(length("`repoName'") > 1){
            forvalues pos = 2/`lengthOfName'{
                local charAtPos = substr("`repoName'",`pos',1)
                if(lower("`charAtPos'") != "`charAtPos'"){
                    local repoName = substr("`repoName'",1,`pos'-1) + "-" + lower("`charAtPos'") + substr("`repoName'",`pos'+1,length("`repoName'")-`pos')
                }
            }
        }

        /* Translate "update" to -git pull origin- */
        if("`gitCommand'" == "update"){
            di as green "Checking for updates for `commandCamelCase' (git repository name: `repoName')..."
            qui cd "`repoName'"
            shell git pull origin
            shell `copyCmd' `commandCamelCase'.ado "`adoPlusDir'`programFirstLetter'"
            capture shell `copyCmd' `commandCamelCase'.sthlp "`adoPlusDir'`programFirstLetter'"
            capture shell `copyCmd' `commandCamelCase'.mmat "`adoPlusDir'`programFirstLetter'"
            qui cd "`origDir'"
        }

        /* Uninstall nukes all */
        if("`gitCommand'" == "uninstall"){
            capture confirm file "`repoName'"
            if _rc!=0{
                di as red "-`commandCamelCase'- not installed via -git- command"
            }
            else{
                qui shell `rmdirCmd' `repoName'
                qui cd "`adoPlusDir'`programFirstLetter'"
                qui erase "`commandCamelCase'.ado"
                qui capture erase "`commandCamelCase'.sthlp"
                qui capture erase "`commandCamelCase'.mmat"
                qui cd "`origDir'"
                di as green "Git repository `repoName' and command -`commandCamelCase'- removed."
            }
        }

    }

    /* "list" lists all git-managed repos */
    if("`gitCommand'" == "list"){
        di as yellow "Git repositories installed using -git- command in"
        di as yellow "`gitDir':"
        di as green "note: when used in Stata, the stata- prefix is stripped and the "
        di as green "      program name is snake-cased"
        di as green "      e.g. repository stata-my-program becomes -myProgram- when used in Stata"
        shell `lsCmd'
        qui cd "`origDir'"
    }

end
