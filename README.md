## Description
Manages [git](http://git-scm.org) repositories in Stata. It installs, updates, lists and removes git repositories containing Stata user-written programs. An alternative to sharing through `ssc` or `net`

## Requirements
[git](http://git-scm.org) must be installed and accessible from your command line.

## Installation

### Manually (recommended)

1. Create a directory called `git` in the same directory where your [personal ado directory](http://www.stata.com/support/faqs/programming/personal-ado-directory/) lives (i.e. make it a sibbling of your personal `ado` directory.
2. Clone this repo into the directory from **step 1** (*nix/OSX commands shown here) : `cd my/personal/directory/git && git clone https://github.com/coderigo/stata-git stata-git`
3. Copy the `.ado` and `.sthlp` files from the cloned repo from **step 2** to your [personal ado directory](http://www.stata.com/support/faqs/programming/personal-ado-directory/) under the `g` directory (create it if it does not exist).
4. Now you can keep the `git` command updated with this repo with `git update git`

### Using ssc
In Stata, type:

`ssc install git`

**Note**: keeping stata-git up to date with the changes in this GitHub repo is easier if you install it the manual way as updates to this repo are pretty much available instantly whereas `ssc` updates can take up to a few days to get ticked through.

## Usage

### install repository
Install a program from _repository_ (url or filepath)

```bash
git install https://github.com/coderigo/stata-switch
```

### uninstall program 
Uninstall program previously installed with `git`

```bash
git uninstall switch
```

### update program 
Update program previously installed with `git`

```bash
git update switch
```

### list repositories 
List all repositories managed by `git`

```bash
git list
```

## Creating a git repository containing a Stata module

A few handy tips to make it work best `git`:

1. Use the _snake-case_ format for your repository name and prefix it with "stata". For example, if your program is called _helloWorld_, your repository should be called _stata-hello-world_.

2. Use the _camelCase_ format for your program name and any installable other auxiliary files including the _.sthlp_ file.

3. Place all the files you want to be copied over in the root of your repository.

4. It works nicely (and it's easier for community collaboration) if you host your repository on a public repo like _github_.

## Contributing
Happy to take requests.
Please add to the `tests.do` some sort of test, or run to make sure nothing's broken.

## Limitations

1. Have only tested this out on OSX, but feel it _should_ work the same with *nix OSs. In theory should work on Windows, but have not tested it.

2. It requires repositories and program names to follow the `snake-case` and `camelCase` format respectively (there is no obvious way to read file data into a variable with Stata. Happy to be corrected)

