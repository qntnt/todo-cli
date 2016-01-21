import Control.Monad
import System.Directory
import System.Environment
import System.IO
import Data.List

main = do
    args <- getArgs
    if (length args) > 0
    then
        todo args
    else
        displayInfo

            
--------------------------------------------------------------------------------
-- Command and Prompt

todo args = do
    let command = (head args)
        options = (tail args)

    case command of
        "list" -> listTodo options
        "add" -> addTodo options
        "delete" -> deleteTodo options
        "prompt" -> todoPrompt options
        "help" -> displayInfo

todoPrompt args = do
    listTodo []
    putStrLn "(1) Add Item"
    putStrLn "(2) Delete Item"
    input <- getLine
    when (input == "1" || input == "2") $ do
        case read input of
            1 -> addTodoPrompt
            2 -> deleteTodoPrompt
        todoPrompt args


--------------------------------------------------------------------------------
-- Actions

-- list
listTodo args = do
    todoPath <- getTodoPath
    contents <- readFile todoPath
    
    let todoLines = lines contents
        numberedLines = zipWith (\n line -> "\t" ++ (show n) ++ " - " ++ line) [0..] todoLines
    
    putStrLn "\nThese are your tasks:"
    putStrLn $ unlines numberedLines

-- add
addTodoPrompt = do
    putStrLn "What do you need to do?"
    taskText <- getLine
    addTodo [taskText]

addTodo args = do
    todoPath <- getTodoPath
    let taskText = head args
    appendFile todoPath (taskText ++ "\n")

-- delete
deleteTodoPrompt = do
    putStrLn "Which task do you want to delete?"
    numberString <- getLine
    deleteTodo [numberString]
    
deleteTodo args = do
    homeDir <- getHomeDirectory
    todoPath <- getTodoPath
    todoHandle <- openFile todoPath ReadMode
    (tempName, tempHandle) <- openTempFile (homeDir ++ "/.") "todoTemp"
    todoContents <- hGetContents todoHandle
    
    let todoTasks = lines todoContents
        number = read $ head args  

    if number < (length todoTasks)
    then do
        let newTodoTasks = delete (todoTasks !! number) todoTasks
        hPutStr tempHandle $ unlines newTodoTasks
    else
        hPutStr tempHandle $ unlines todoTasks
    hClose todoHandle
    hClose tempHandle
    removeFile todoPath
    renameFile tempName todoPath


--------------------------------------------------------------------------------
-- Helper Functions

getTodoPath = do
    homeDir <- getHomeDirectory
    return $ homeDir ++ "/.todo"

displayInfo = do
    putStrLn "Commands:"
    putStrLn "\tlist"
    putStrLn "\tadd <text>"
    putStrLn "\tdelete <task number (Integer)>"
    putStrLn "\tprompt"
    putStrLn "\thelp"
