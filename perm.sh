#!/bin/bash

#validation:
# no of parameters entered
# filename exists
# permissions: rwx - | right format | right order
# blank data, spaces, or invalid data should not be allowed


#prompt for filename
#check if it exists if not print error message
#loop 3 times to see if valid name is given
#if no then exit the script
function validateFilename(){
 declare -i count
 while [[ $count<3 ]]
 do
  echo "Please enter the filename."
  read filename
  ((count=count + 1 ))
  if [[ $filename = "" ]]
  then
   echo "Blank Filename. Invalid. Please try again."
   continue
  fi  

  [ -a $filename ]
  if [[ $?==0 ]]
  then
   count=11
   echo
   echo "$filename exists. Following is the permission for the files: "
   echo
   ls -l $filename
   echo
   break
  else
   echo "$filename does not exist. Please provide filename that exists."
  fi
 done

 if (( $count!=11 ))
 then
  echo "Valid filename was not entered. Exiting from the script."
  exit 1
 fi
}
#if valid filename do ls -l
#ask user which permission to change
#validation : rwxr-x---
#only rwx and - allowed and then check there position
#loop 3 times to ask for the correct permission
#exit if not given
function changeToOctal(){
 declare -a OctalDigit=(0 0 0);
 (( i=0 ))
 (( j=0 ))
 while [[ $i<${#permission} ]]
 do
  if [[ ${permission:$i:1} = r ]]
  then
   (( OctalDigit[$j]=${OctalDigit[$j]}+4 ))
  elif [[ ${permission:$i:1} = w ]]
  then
   (( OctalDigit[$j]=${OctalDigit[$j]}+2 ))
  elif [[ ${permission:$i:1} = x ]]
  then
   (( OctalDigit[$j]=${OctalDigit[$j]}+1 ))
  fi

  (( rem = ($i+1)%3 ))

  if [[ $rem = 0 ]]
  then
   (( j= $j+1 ))
  fi
  (( i = $i+1 ))
 done
 echo
 echo "Please use the following command:"
 echo "chmod ${OctalDigit[0]}${OctalDigit[1]}${OctalDigit[2]} $filename"
 echo
}


function validatePermission(){
 declare -i countPermission

 while [[ $countPermission<3 ]]
 do
  echo "Please enter the permission that you want the $filename to have. For example: rwxr--r--"
  read permission
  (( countPermission=$countPermission+1 ))
  if [[ $permission =~ ^([r|-][w|-][x|-]){3}$ ]]
  then
   (( countPermission = 11 ))
   echo "Permission is valid: $permission"

   changeToOctal

   break
  else
   echo "Please enter a valid permission. For example: rwxr--r--"
  fi
 done

 if (( $countPermission != 11 ))
 then
  echo "Valid permission type was not entered. Exiting the script!"
  exit 2
 fi

}
#if valid permissions then convert to octal number
#display chmod command


validateFilename
validatePermission
