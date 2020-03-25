#!/bin/bash -x

#Problem Statement: As a Tic Tac Toe player would like to challenge computer.
#Author: Raj Kush
#DAte: 24 March 2020

clear

#CONSTANTS
USER_LETTER=X
COMP_LETTER=O

declare -A Board

function displayBoard() {
	for (( i=0; i<3; i++ ))
	do
		echo "---------------"
		for (( j=0; j<3; j++ ))
		do
			echo -n "|   |"
		done
		echo
	done
	echo "---------------"
}

displayBoard

echo "You are assigned letter:- $USER_LETTER"

sleep 1
