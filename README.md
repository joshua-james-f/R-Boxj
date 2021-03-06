R package for Sublime Text
------------

Features:

  - Send commands to various programs. 
    - Mac: R GUI, RStudio(>v0.99.769), Terminal, iTerm 2; 
    - Unix: screen, tmux; 
    - Windows: R GUI, RStudio, Cygwin, [Cmder](http://cmder.net) (see below to configure Cmder); 
    - SublimeREPL
  - Autocompletions for various packages.
  - Function hints in status bar for various packages.
  - Support Roxygen, Rcpp, R Sweave and R Markdown syntaxes. 
  - [knitr](https://github.com/yihui/knitr) build command for R markdown and Rnw files.
  - [R-Extended syntax](https://github.com/randy3k/R-Box/tree/master/syntax).

If you like it, you could send me some tips via [paypal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=YAPVT8VB6RR9C&lc=US&item_name=tips&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted) or [gratipay](https://gratipay.com/~randy3k/).

![](https://raw.githubusercontent.com/randy3k/R-Box/screenshots/terminal.png)

### Getting start


- Install via [Package Control](https://sublime.wbond.net)



### Usage

In the following, <kbd>C</kbd> is <kbd>ctrl</kbd> for Windows/Linux, <kbd>cmd</kbd> for Mac.

- <kbd>C</kbd> + <kbd>enter</kbd> to send code to gui/terminal. `R` is the default for mac, `R64` is default for windows and `tmux` is the default for linux. To change the default program, do <kbd>C</kbd> + <kbd>shift</kbd> + <kbd>p</kbd> -> `R-Box: Choose Program`.
- <kbd>C</kbd> + <kbd>\\</kbd> to change working dir
- <kbd>C</kbd> + <kbd>b</kbd> to source the current R file, or to run [knitr](https://github.com/yihui/knitr) for Rnw or R markdown files.


### Settings

See `Preference -> Package Settings -> R-Box`


### Autocompletions and status bar hints

Auto completions and status bar hints only support limited number of packages. R-Box will search for `library` or `require` statements in order to load the corresponding package support files. The support files are under the `packages` directory.  If your favorite packages are not listed there, you can generate the corresponding files by running `packages.R` in the following steps.

1. `Preference: Browse Packages` and create the directory `/Users/R-Box/` if it doesn't exist
2. Copy the file `packages.R` to `R-Box`
3. Run `Rscript packages.R <package name>`

This will create a json file under `packages` directory. 

### FAQ

#### SublimeLinter settings

To enable [SublimeLinter](http://www.sublimelinter.com/) via [SublimeLinter-contrib-R](https://github.com/jimhester/SublimeLinter-contrib-R) and  [lintr](https://github.com/jimhester/lintr), please add the following in the SublimeLinter user settings file:

```
    "syntax_map": {
        "r extended": "r"
    }
```

#### Cmder settings

- Go to `Paste` in the settings, uncheck, "Confirm <enter> keypress" and "Confirm pasting more than..."
- Change the default paste all lines command from <kbd>shift</kbd>+<kbd>insert</kbd> to <kbd>ctrl</kbd>+<kbd>shift</kbd>+<kbd>v</kbd>. I actually posted an [issue](https://github.com/cmderdev/cmder/issues/710) at Cmder about the default keybind.


### License

R-Box is licensed under the MIT License. `AutoHotkeyU32.exe` under `bin` is included with its own license.
