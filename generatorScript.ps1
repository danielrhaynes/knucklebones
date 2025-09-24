$wordsPath = $Script:PSScriptRoot + "\trimmedWordlist.txt"

$words = Get-Content -Path $wordsPath
$wordsLength = $words.Length - 1

function WordSet
{
    $iterations = 3

    $wordBuffer = $null

    for ($i =1;$i -le $iterations;$i++)
        {
        $rand = Get-Random -Maximum $wordsLength

        $inputWord = $words[$rand]

        $firstLetter = $inputWord.Substring(0,1).ToUpper()

        $capitalWord = $inputWord -replace "^(.)", $firstLetter

        $wordBuffer += $capitalWord
        }

    $wordBuffer
}

Function FourNumbers
{
$fourNumbers = [string](Get-Random -Maximum 9) + [string](Get-Random -Maximum 9) + [string](Get-Random -Maximum 9) + [string](Get-Random -Maximum 9)
$fourNumbers
}

Function RandomChar {
$characters = "!" ,"@" ,"#" ,"$" ,"%" ,"^" ,"&"

$randChar = $characters[(Get-Random -Maximum 6)] 

$randChar
}

Function MakePW {
$PW = (WordSet) + (FourNumbers) + (RandomChar)
$PW
}

$iterations = 10
for ($i =1;$i -le $iterations;$i++)
{
MakePW
}

#I wrote the script in this way because the passwords I create with it are sometimes given to end users, and I like having the oppertunity to curate for tone from the list of 10.
#Alternately, you could get rid of the loops above, dispense with the Pause at the end, and uncomment the commands below. This would result in a version of the script that
#only generated a single password, and sent it straight to the clipboard. This is useful if you just need a single password at a time and don't particularly care what it is.

#The wordlist accompanying this script is derived from the Electronic Frontier Foundation's "Large Word List," found here: 
#https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases

#This wordlist could be swapped out or pruned, and the script will adjust the range of its random selection based on the length of the list.


#MakePW | Clip

Pause