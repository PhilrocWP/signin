#!/bin/bash
trap rm logs.txt EXIT
if [ -a accounts.txt ] && [ -a logs.txt ]; then
	if [ -s accounts.txt ]; then
		read -p "Type in username, type ”new” if you're a new user, or press Ctrl + C to exit: " uname
		if [ $uname = "new" ]; then
			read -p "Hi! Looks like you haven't used us before. Please make a username. Username: " newuname
			grep -q "$newuname" accounts.txt && echo Username already taken! && bash signin.sh
			echo $newuname >> accounts.txt
			read -p "Now make a password: " newpwd
			echo $newpwd >> accounts.txt
			echo "Thanks for making an account!"
			bash signin.sh
		else
			grep  "$uname" accounts.txt >> logs.txt
			if (($? >= 1)); then
				echo Username does not exist!
				bash signin.sh
			fi	
			read -s -p "Password: " pwd
			grep  "$pwd" accounts.txt >> logs.txt
			if (($? >= 1)); then
				echo Password does not match!
				bash signin.sh
			fi
			read -p "Welcome! Press Enter to continue..."
		fi
	else
		read -p "Hi! Looks like you haven't used us before. Please make a username. Username: " newuname
		echo $newuname >> accounts.txt
		read -s -p "Now make a password: " newpwd
		echo $newpwd >> accounts.txt
		read -p "Thanks for making an account! Press Enter to continue..."
		bash signin.sh
	fi
		
		 
else
	touch accounts.txt
	touch logs.txt
	bash signin.sh
fi
