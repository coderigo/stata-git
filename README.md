## Description
Manages [git](http://git-scm.org) repositories in Stata. It installs, updates, lists and removes git repositories containing Stata user-written programs. An alternative to sharing through `ssc` or `net`

## Installation

### Manually (safest until published on ssc)
1. Clone this repo
2. Copy the `.ado` and `.sthlp` file to your [personal ado directory](http://www.stata.com/support/faqs/programming/personal-ado-directory/) under the `g` directory (create it if it does not exist).

### Using ssc (TBC)
In Stata, type:

`ssc install git`

After this you can keep `git` itself updated using `git` by typing `git update git`


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

## Creating a git repository containing a Stata module}

A few handy tips to make it work best `git`:

1. Use the snake-case format for your repository name and prefix it with "stata". For example, if your program {it: helloWorld}, your repository should be called {it:stata-hello-world}.{p_end}

2. Use the {it: camelCase} for your program name and any installable other auxiliary files including the {it: .sthlp} file.{p_end}

3. Place all the files you want to be copied over in the root of your repository.{p_end}

4. It works nicely (and it's easier for community collaboration) if you host your repository on a public repo like {it:github}{p_end}.

## Contributing
Happy to take requests.
Please add to the `tests.do` some sort of test, or run to make sure nothing's broken.

## Limitations

1. Have only tested this out on OSX, but feel it _should_ work the same with *nix OSs. In theory should work on Windows, but have not tested it.

2. It requires repositories and program names to follow the `snake-case` and `camelCase` format respectively (there is no obvious way to read file data into a variable with Stata. Happy to be corrected)

