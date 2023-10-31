# line-counter-tmux

## Features

* Count the total amount of code lines within a project
* Specify languages to look for
* Specify a directory to ignore

## Installation with Tmux Plugin Manager (TPM)

1. Add the plugin to your tmux.conf:
```bash
set -g @plugin 'Nelliguns/line-counter-tmux'
```
2. Press prefix + <kbd>I</kbd> to install the plugin.
3. in the same level as your tmux.conf file
   ```bash
   tmux source tmux.conf
   ```

## Usage

Once installed, you can use the key binding \<prefix>C to retrieve the amounted lines of code for the current working directory.

## Configuration

You can customize the name of the directory to ignore and the file endings of the languages you want to look for

```bash
set -g @env "venv"
set -g @file_endings "py, sh, rs, js"
```
