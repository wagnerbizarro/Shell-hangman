#!/bin/bash
# Autor: Wagner Bizarro
# Project: Hangman Bash
# Date: 06 April 2022
# Version.Release: 1.0

#Hide Word to players
prompt="Player one, please enter the word:"
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    word+="$char"
done
echo
echo "Done"

#Insert space at each letter
word1="echo '$word' |  sed 's/.\{1\}/& /g'" 
word2=$(eval "$word1")

#Converte string to Array
read -a wordArray <<< $word2
#echo "${wordArray[@]}"


#Get size word
x="echo -n '$word' | wc -c"
#eval "$x"
count=$(eval "$x")

#Start game
read -p "Player one, enter the tip about:" tip
read -p "Press [ENTER] to start:" enter

clear

printf "\n-----------------------------------\n"

echo "Word has $count letter and tip is $tip"


function draw () {
	case $1 in 
		1)
			echo " / "
			;;

		2)
			echo " /\ "
			;;

		3)  echo " || "
			echo " /\ "
			;;

		4) 
			echo " /|| "
			echo "  /\ "
			;;
		
		5)
			echo " /||\ "
			echo "  /\  "
			;;

		6)
			echo "  ( "
			echo " /||\ "
			echo "  /\  "
			;;

		7)
			echo "  () "
			echo " /||\ "
			echo "  /\  "
			echo -e "You died"
			exit

			
	esac
}

i=0

while [ $i -le 7 ]
do
	read -p "Try a letter: " letter
    
    if [[ "${wordArray[*]}" =~ "${letter}" ]]; then
    	echo "OK"
    	
    	read -p "Do you know the word?[y/n]:" know
    		if [ $know == "y" ]; then
    			read -p "Write the word:" word5
    				if [ $word5 == $word ]; then
    					clear
    					echo "You WIN !!!"
    					exit
    				fi
    		fi
    fi

    if [[ ! "${wordArray[*]}" =~ "${letter}" ]]; then
    	echo "NOT_OK"
    	i=$((i + 1))
    	clear
    	draw $i
    fi

done


