module Main where

import           Control.Monad       (when)
import qualified Data.UUID           as UUID
import           Data.UUKaimyo       (genKaimyoFromUUID, genUUIDAndKaimyo)
import           Options.Applicative (Parser, execParser, fullDesc, header,
                                      help, helper, info, long, progDesc, short,
                                      switch, (<**>))
import           System.Exit         (die)

-- | Options for the command
data Options = Options
  { showUUID        :: Bool
  , convertFromUUID :: Bool
  } deriving (Show)

-- | Parser for the command options
options :: Parser Options
options = Options
  <$> switch
      ( long "show-uuid"
     <> short 's'
     <> help "Show UUID" )
  <*> switch
      ( long "convert-from-uuid"
      <> short 'c'
      <> help "Convert from UUID" )

-- | The main function
main :: IO ()
main = do
  opts <- execParser $ info (options <**> helper)
                            ( fullDesc
                            <> progDesc "Generate UUKaimyo"
                            <> header "uukaimyogen - an UUKaimyo generator" )
  (uuid, kaimyo) <- if convertFromUUID opts
                    then do
                      uuid <- getLine
                      case UUID.fromString uuid of
                        Nothing   -> die "Invalid UUID"
                        Just uuid -> return (UUID.toString uuid, genKaimyoFromUUID uuid)
                    else do
                      genUUIDAndKaimyo
  when (showUUID opts) $ putStrLn $ "UUID: " ++ uuid
  putStrLn kaimyo
