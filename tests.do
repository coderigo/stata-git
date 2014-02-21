do "git.ado"

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

/*Test installing*/
git install https://github.com/coderigo/stata-switch
local expectedRepoName = "stata-switch"
local repoSnakeCase    = "switch"
capture confirm file "`gitDir'`expectedRepoName'"
if _rc!=0{
    di as red "Test 1 FAILED."
    di as red "Expected `gitDir'`expectedRepoName' to exist but it does not."
}
else {
    di as green "Test 1 PASSED."
    capture confirm file "`adoPlusDir's/`repoSnakeCase'.ado"
    if _rc!=0{
        di as red "Test 2 FAILED."
        di "Expected `adoPlusDir's/`repoSnakeCase'.ado to exist but it does not."
    }
    else {
        di as green "Test 2 PASSED."
    }

    /*Test uninstalling*/
    git uninstall `repoSnakeCase'
    capture confirm file "`gitDir'`expectedRepoName'"
    if _rc!=0{
        di as green "Test 3 PASSED."
    }
    else{
        di as red "Test 3 FAILED."
        di "Expected `gitDir'`expectedRepoName' to NOT exist but it does."
    }
}

/* TODO: Add more tests */
