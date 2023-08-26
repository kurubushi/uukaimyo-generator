module Main where

import           Control.Monad       (when)
import qualified Data.UUID           as UUID
import           Data.UUKaimyo       (Gender (Female, Male), genKaimyoFromUUID,
                                      genUUIDAndKaimyo)
import           Options.Applicative (Parser, execParser, flag, fullDesc,
                                      header, help, helper, info, long,
                                      progDesc, short, switch, (<**>), (<|>))
import           System.Exit         (die)

-- | Options for the command
data Options = Options
  { showUUID        :: Bool
  , convertFromUUID :: Bool
  , gender          :: Gender
  } deriving (Show)

defaultGender :: Gender
defaultGender = Male

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
  <*> ( (flag defaultGender Male
         ( long "male"
        <> short 'm'
        <> help "Generate a kaimyo for males"))
    <|> (flag defaultGender Female
          (long "female"
        <> short 'f'
        <> help "Generate a kaimyo for females" )))

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
                        Just uuid -> return ( UUID.toString uuid
                                            , genKaimyoFromUUID (gender opts) uuid
                                            )
                    else do
                      genUUIDAndKaimyo (gender opts)
  when (showUUID opts) $ putStrLn $ "UUID: " ++ uuid
  putStrLn kaimyo
