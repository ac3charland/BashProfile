# BashProfile
My favorite shortcuts and functions to improve the Terminal experience.

## To use:
1. Using Terminal, open your .zshrc/.bash_profile in your editor of choice (the command below will use nano).
  - `nano ~/.zshrc`
2. Add the following line at the end of the file (or at the top of the `# User configuration` section in .zshrc), with the path to this repo on your machine filled in
  - `source ~/path/to/this/repo/BashProfile/profile.sh`
  - For zsh: make sure this line is *after* the git plugins line in .zshrc. Otherwise, some of the git aliases in here will be overwritten by the plugin's.
3. Close and restart your terminal and enjoy!

## Project Structure

For configuration that is machine-specific or that wouldn't be appropriate to commit, you can create a `local.sh` file which will be gitignored.

If you'd like to overwrite an alias in `profile.sh` with a function in `local.sh`, you'll need to `unalias` it beforehand:

```
# local.sh
unalias push
function push {
  ...
}
```
