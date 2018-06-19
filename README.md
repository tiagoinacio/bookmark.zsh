# FZF-BOOKMARK

This plugin helps us finding sepecific files or traverse bookmarked directories.

# Dependencies

You should add FZF installed. Follow the instructions [here](https://github.com/junegunn/fzf).

# Installation

## The helper script

You should clone this repo, and source `fzf-bookmark.zsh` on your `.zshrc`.

## Without using the script

If you want to specify the directories that you want exactly, instead of using that helper script, you can create a file with the name `.fzf_bookmarks` and put it under your home directory.

Then add the bookmarked diretories listed line by line:

```
~/Work/
~/Another-Directory/
/etc/bin
~/.vim
```

# Usage

First we need to set our favourite directories:

```
bk my_top_directory max_depth
```

For example:

```
bk ~/Work 3
```

This will list all directories under `~/Work` with a maximum depth of 3 subdirectories in the tree.

After this, we will have a `~/.fzf_favorites` file.

## Usage

Using the mapping Ctrl-B, we can auto complete scripts with the bookmarked file that we chose from the list.

You can also call `bk` without any arguments to get a list of all the bookmarked directories.