import System.IO
import Control.Monad
import System.Directory
import Data.List

main = do
    listTodo
    putStrLn "(1) Add Item"
    putStrLn "(2) Delete Item"
    input <- getLine
    when (input == "1" || input == "2") $ do
        case read input of
            1 -> addTodo
            2 -> deleteTodo
        main

--------------------------------------------------------------------------------
-- Actions

listTodo = do
    todoPath <- getTodoPath
    contents <- readFile todoPath
    
    let todoLines = lines contents
        numberedLines = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoLines
    
    putStrLn "\nThese are your tasks:"
    putStrLn $ unlines numberedLines

addTodo = do
    todoPath <- getTodoPath
    putStrLn "What do you need to do?"
    todoItem <- getLine
    
    appendFile todoPath (todoItem ++ "\n")
    putStr "\n"

deleteTodo = do
    homeDir <- getHomeDirectory
    todoPath <- getTodoPath
    todoHandle <- openFile todoPath ReadMode
    (tempName, tempHandle) <- openTempFile (homeDir ++ "/.") "todoTemp.txt"
    todoContents <- hGetContents todoHandle
    
    let todoTasks = lines todoContents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    
    putStrLn "Which task do you want to delete?"
    numberString <- getLine

    let number = read numberString

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
    putStr "\n"


--------------------------------------------------------------------------------
-- Helper Functions

getTodoPath = do
    homeDir <- getHomeDirectory
    return $ homeDir ++ "/todo.txt"

