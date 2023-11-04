# line-counter-tmux

## Synopsis
A plugin that provides the ability to quickly count the amount of code that's written within a project

## Explanation
I was asked how many lines of code it took for me to create a project of mine and I started browsing through the files in my project adding the line count together in my head to give a rough estimate. Figured it would be nice functionality to have inside my terminal so decided to create this project.

## Features
* Count the total amount of code lines within a project
* Specify language to look for
* Specify a directory to ignore

## Installation with Tmux Plugin Manager (TPM)

1. Add the plugin to your tmux.conf:
```bash
set -g @plugin 'Nelliguns/line-counter-tmux'
```
2. Press prefix + <kbd>I</kbd> to install the plugin.

## Usage

Once installed, you can use the key binding \<prefix>F to retrieve the amounted lines of code for the current working directory.
By default, the plugin will look for py files and will ignore a directory named venv.

You may want to count the lines of multiple languages and also change the name of the directory to ignore.

## Configuration

By adding the following lines to your tmux.conf file you can customize the name of the directory to ignore and the file endings of the languages you want to look for as well as the command to run the plugin. 

```bash
set -g @env "venv" # The directory to ignore
set -g @file_endings "py,js" # file types separated with ","
set -g @run_command "C" # command to run script
```

## Tests

Tests written in [bashunit](https://bashunit.typeddevs.com/). You can run all tests with:
```bash
lib/bashunit tests
```
