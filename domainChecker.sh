#!/bin/bash 
 
DOMAINS=( '.co' '.tv' '.cc' '.eu' \ 
'.in' '.it' '.sk' '.io' '.me' '.se' )
 
ELEMENTS=${#DOMAINS[@]} 

declare -a POSSIBILITES

NUMALPHA=( 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' \
'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' \
't' 'u' 'v' 'w' 'x' 'y' 'z' '1' '2' '3' '4' \
'5' '6' '7' '8' '9' '0' )

function buildPossibilities() {
    counter=0
    for ((i=0;i<36;i++))
    do
        for ((k=0;k<36;k++))
        do
            for ((j=0;j<36;j++))
            do
                for ((r=0;r<36;r++))
                do
                    POSSIBILITIES[$counter]="${NUMALPHA[$i]}${NUMALPHA[$k]}${NUMALPHA[$j]}${NUMALPHA[$r]}"
                    counter=$((counter+1))              
                done
            done
        done
    done
}

buildPossibilities

NUMPOSSIB=${#POSSIBILITIES[@]}

for ((j=0;j<$NUMPOSSIB;j++))
do
    for ((i=0; i<$ELEMENTS;i++))
    do
        whois ${POSSIBILITIES[${j}]}${DOMAINS[${i}]} | egrep -q \
        '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entr' &
        if [[ $? -eq 0 ]]
        then
            echo "${POSSIBILITIES[${j}]}${DOMAINS[${i}]} : available"
        fi
    done
done

 
