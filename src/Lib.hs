module Lib
    ( someFunc
    ) where

import qualified Data.ByteString.Lazy as B
import System.IO
import System.Environment (getArgs)
import Control.Exception

someFunc :: IO ()
someFunc = main

main :: IO ()
main = do
    fileNames <- getArgs
    mapM_ safeShowFileContent fileNames

showFileContent :: String -> IO ()
showFileContent fileName = do
    content <- (B.readFile fileName)
    B.hPut stdout content

safeShowFileContent :: String -> IO ()
safeShowFileContent fileName = do
    result <- tryJust displayErr (showFileContent fileName)
    case result of
         Left s -> hPutStrLn stderr s
         Right _ -> pure ()


displayErr :: SomeException -> Maybe String
displayErr e =
    Just $ displayException e




