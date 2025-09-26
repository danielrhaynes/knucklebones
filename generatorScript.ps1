#The default wordlist accompanying this script is derived from the Electronic Frontier Foundation's "Short Word List," found here: 
#https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases
Add-Type -AssemblyName PresentationFramework

###
#Config
###

    #default settings
    $defaultSettings = @{
        wordlist = 'default'
        mode = 1
        passwordsToGenerate = 10
        wordsPerPassword = 3
        digitsPerPassword = 4
        charactersPerPassword = 1
        }


    #path to the config file
    $config = $Script:PSScriptRoot + "\kbconfig.txt"

    #if config exists, read it, if not, initialize it with default settings
    if (Test-Path -Path $config)
        {
        $readSettings = Get-Content -Path $config | ConvertFrom-Json
        }
    else
        {
        $defaultSettings | ConvertTo-Json -Depth 2 | Out-File $config

    
        [System.Windows.MessageBox]::Show("No config file was found in the expected location. One should have been created for you in the script directory.")

        exit
        }

###
#Generator
###


    #Retreive wordlist. If "wordlist" value in config is "default," a file called "eff_short_wordlist_1.txt" will be searched for in the script directory. 
    #If the value of "wordlist" is anything else, that value is treated as a path to an alternate wordlist.
    if ($readSettings.wordlist -eq "default")
        {
        $wordsPath = $Script:PSScriptRoot + "\eff_short_wordlist_1.txt"
        }
    else
        {
        $wordsPath = $readSettings.wordlist
        }

    if ((Test-Path $wordsPath) -ne $true)
        {
            [System.Windows.MessageBox]::Show("The wordlist path supplied in the config file was not a valid path. Please check any custom path provided, or check to ensure that the path to the default wordlist has not been changed.")
            exit
        }

    #Get the words, and determine the length of the list
    $words = Get-Content -Path $wordsPath
    $wordsLength = $words.Length - 1

    function WordSet
    {
        $iterations = $readSettings.wordsPerPassword

        $wordBuffer = $null

        for ($i =1;$i -le $iterations;$i++)
            {
            $rand = Get-Random -Maximum $wordsLength

            $inputWord = $words[$rand]

            $inputWord = $inputWord.Trim("1","2","3","4","5","6","7","8","9","0", "`t")

            $firstLetter = $inputWord.Substring(0,1).ToUpper()

            $capitalWord = $inputWord -replace "^(.)", $firstLetter

            $wordBuffer += $capitalWord
            }

        $wordBuffer
    }

    Function GenerateNumbers
    {

        $iterations = $readSettings.digitsPerPassword

        for ($i =1;$i -le $iterations;$i++)
            {
            $digit = Get-Random -Maximum 9

            [string]$digitsBuffer += [string]$digit
            }
        $digitsBuffer
    }

    Function RandomChar {
        $characters = "!" ,"@" ,"#" ,"$" ,"%" ,"^" ,"&"

        $iterations = $readSettings.charactersPerPassword

        for ($i =1;$i -le $iterations;$i++){
            $randChar = $characters[(Get-Random -Maximum 6)]

            $randCharBuffer += $randChar
        }

        $randCharBuffer
    }

    Function MakePW {
        $PW = (WordSet) + (GenerateNumbers) + (RandomChar)
        $PW
    }

###
#Output Mode 1
###
    if ($readSettings.mode -eq 1)
    {
        $iterations = $readSettings.passwordsToGenerate
        for ($i =1;$i -le $iterations;$i++)
        {
        MakePW
        }
    Pause
    }

###
#Output Mode 2
###
    if ($readSettings.mode = 2)
        {
            MakePW | Clip
        }
