# todo-cli
A haskell program to manage a todo list from the terminal.

## Installation
```bash
git clone https://github.com/quentunahelper/todo-cli.git && cd todo-cli
ghc --make todo.hs
```

Then add the `todo` file to your system path.

## Usage
> The file `todo.txt` will be made in your home directory to store your tasks.

From the command line, enter the command `todo`.

You will be shown the current todo list then prompted for a command. To quit, enter any value other than "1" or "2".

**Commands:**
* (1) Add task
    * Enter a new task's text.
* (2) Delete task
    * Input the task number you wish to delete.
