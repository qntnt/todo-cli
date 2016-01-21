# todo-cli
A haskell program to manage a todo list from the terminal.

## Installation
```bash
git clone https://github.com/quentunahelper/todo-cli.git && cd todo-cli
ghc --make todo.hs
```

Then add the `todo` file to your system path.

## Usage
> The file `.todo` will be made in your home directory to store your tasks.

### Commands
* `list`
* `add <text>`
* `delete <number>`
* `prompt`
* `help`

```bash
> todo list

These are your tasks:
0 - CS Project 2
1 - Get milk
2 - Cure cancer

> todo delete 0
> todo list

These are your tasks:
0 - Get milk
1 - Cure cancer

> todo add "CS Project 3"
> todo list

These are your tasks:
0 - Get milk
1 - Cure cancer
2 - CS Project 3
```

**Commands:**
* (1) Add task
    * Enter a new task's text.
* (2) Delete task
    * Input the task number you wish to delete.

### Prompt
From the command line, enter the command `todo` to enter the todo list prompt.

You will be shown the current todo list then prompted for a command. To quit, enter any value other than "1" or "2".
