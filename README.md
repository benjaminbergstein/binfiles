# binfiles

A collection of scripts that I keep in ~/.bin.

To use run:

```
$ git clone git@github.com:benjaminbergstein/binfiles.git > ~/.bin
````

Then add the following to your bash profile somewhere (`~/.bash_profile`, `~/.bashrc`, etc.):

export PATH="/Users/<your-user>/.bin:$PATH"

# Commands

Many of the commands use single letter aliases. The aliases all
can be pressed using the right hand on a QWERTY keyboard, and represent
a step in my personal development workflow.

## Git commands

| Command | Workflow step | Summary |
| --- | --- | --- |
| n | New branch | Fetches latest master branch and creates a new branch off of it. |
| u | Update branch | Fetches latest master and integrates into current branch via rebase |
| p | Patch / Push branch | Prompts user to add changes via `git add -p`, asks for a commit preference (edit vs no-edit), and optionally pushes |
| l | List / Switch branch | Uses `FZF` command to list branches, allowing quick switching between branches |
