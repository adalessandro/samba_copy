#!/bin/bash

#dirs to mount
local_dir_A="/mnt/local_dir_A"
remote_dir_A="C$/Archivos de programa/"

local_dir_B="/mnt/local_dir_B"
remote_dir_B="C$/Documents and Settings/All Users/Escritorio/"

#files or dir to copy
file_A="Nombre Equipo/" 
file_B="All Users/Nombre Equipo.lnk" 

#user auth
username=hpr/adalessandro
password=contraseña

#input/output files
INPUT=input.txt
OUTPUT=output.txt

#other parameters
TIMEOUT=3
IFS=","

process() {
   
    echo "***************$HOSTNAME***************" 
    #mounting A
    umount $local_dir_A
    timeout $TIMEOUT smbmount "//$HOSTNAME/$remote_dir_A" "$local_dir_A" -o user=$username,password=$password

    if [ "$?" -ne "0" ]; then
        echo "smbmount_A failed" >> $OUTPUT
        continue
    fi
    
    #mounting B
    umount $local_dir_A
    umount $local_dir_B
    timeout $TIMEOUT smbmount "//$HOSTNAME/$remote_dir_B" "$local_dir_B" -o user=$username,password=$password

    if [ "$?" -ne "0" ]; then
        echo "smbmount_B failed" >> $OUTPUT
        continue
    fi

    #copying A
    cp -r "./$file_A" $local_dir_A
   
    if [ "$?" -ne "0" ]; then
        echo "cp_A failed" >> $OUTPUT
        continue
    fi

    #copying B
    cp -r "./$file_A" $local_dir_A
    cp -r "./$file_B" $local_dir_B
   
    if [ "$?" -ne "0" ]; then
        echo "cp_B failed" >> $OUTPUT
        continue
    fi
    
    #allright!
    echo "OK" >> $OUTPUT
    ((count++))
}

# main
count=0
total=0

case "$1" in
status)
    while read HOSTNAME STATUS
    do
        ((total++))
        case $STATUS in
            OK) ((count++));;
            *)  continue;;
        esac
    done < $INPUT
    echo "***************STATS***************"
    echo "Total: $total"
    echo "Total OK's: $count"
    ;;
run)
    while read HOSTNAME STATUS
    do
        case $STATUS in
            OK) echo "$HOSTNAME,$STATUS" >> $OUTPUT;;
            *)  echo -n "$HOSTNAME," >> $OUTPUT; process;;
        esac
    done < $INPUT
    echo "***************STATS***************"
    echo "Total new OK's: $count"
    ;;
*)
    echo "Wrong. Options are: status|run"
    ;;
esac
