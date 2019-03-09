#!/bin/bash

#Get input from the user: student information and marks
#validate and display results
#validation: # of parameters, blank data and spaces not valid

#student information: first name, last name and student number
#keep looping 3 times for correct data
#validation:
#validation: # of parameters, first letter is Uppercase rest is lowercase
#validation: student number: 6 digit positive integers any leading zeros: 006574
function validateStudentNumber(){
 declare -i countStudentNumber

 while [[ $countStudentNumber -lt 3 ]]
 do
  echo "Please enter student number. The number should be 6 digit."
  read studentNumber
 (( countStudentNumber = countStudentNumber + 1))
 if [[ $studentNumber =~ ^[0-9]{6}$ ]]
 then
  echo "Valid Student Number."
  (( countStudentNumber = 11 ))
 else
  echo "Invalid Student Number Entered. Please try again."
 fi
 done

 if (( $countStudentNumber != 11 ))
 then
  echo "3 Attempts are finished. Exiting the script."
  exit 1
 fi
}

function validateFirstName(){
 declare -i countName
 while [[ $countName -lt 3 ]]
 do
  echo "Please enter your First Name. The first character should be in uppercase. e.g.: Shweta"
  read firstname
  (( countName = countName +1 ))
  if [[ $firstname =~ ^[A-Z][a-z][a-z]*$ ]]
  then
   echo "Valid First Name"
   (( countName = 11 ))
  else
   echo "Invalid Name. The first character should be in upper case. e.g.: Shweta"
  fi
 done

 if (( $countName != 11 ))
 then
  echo "3 Attempts are finished. Exiting the script."
  exit 2
 fi
}

function validateLastName(){
 declare -i countName
 while [[ $countName -lt 3 ]]
 do
  echo "Please enter your Last Name. The first character should be in upper case. e.g.: Shrestha"
  read lastname
  (( countName = countName + 1))
  if [[ $lastname =~ ^[A-Z][a-z][a-z]*$ ]]
  then
   echo "Valid Last Name"
   (( countName = 11 ))
  else
   echo "Invalid Name. The first character should be in upper case. e.g.: Shrestha"
  fi
 done

 if (( $countName != 11 ))
 then
  echo "3 Attempts are finished. Exiting the script."
  exit 3
 fi
}
#Get 3 course Codes with marks.
#keep looping 3 times for correct data.
#validation: 6 characters, first 3 uppercase, last 3 numbers: ULI705
#validation: numbers between 0-100, 90, 90.5 or 090.5
function validateCourse(){
 declare -i countCourse
 declare -ag CourseArray
 declare -i index
 (( index =0 ))
 while [[ $index -lt 3 ]]
 do
 (( countCourse = 0 ))
 while [[ $countCourse -lt 3 ]]
 do
  (( num= index + 1 ))
  echo "Please enter course code number $num. The format should be first three letters in uppercase followed by 3 numbers. e.g.: ULI705"
  read CourseArray[$index]
  if [[ ${CourseArray[$index]} =~ ^[A-Z]{3}[0-9]{3}$ ]]
  then
   echo "Valid course."
   (( countCourse = 11 ))
   (( index = index+1 ))
  else
   echo "Invalid course. Please try again. Format should be first 3 letters in uppercase followed by 3 numbers. e.g.: ULI705"
  fi
 done

 if (( $countCourse != 11 ))
 then
  echo "Invalid course. Exiting the script"
  exit 4
 fi
done

}

function validateMarks(){
 declare -i countMarks
 declare -ag MarksArray
 declare -i index
 (( index =0 ))
 while [[ $index -lt 3 ]]
 do
 (( countMarks = 0 ))
 while [[ $countMarks -lt 3 ]]
 do
  echo "Please enter marks for course code ${CourseArray[$index]}. Marks are between 0-100."
  read MarksArray[$index]
  if [[ ${MarksArray[$index]} =~ (^[0]*[0-9][0-9]?([.][0-9])?$)|(^100$) ]]
  then
   echo "Valid marks $index"
   (( countMarks = 11 ))
   (( index = index+1 ))
  else
   echo "Invalid marks. Please enter again. Marks are between 0-100."
  fi
 done
 if (( $countMarks != 11 ))
 then
  echo "Invalid marks. Exiting the script"
  exit 4
 fi
done

 #removing all the leading 0
 for i in ${#MarksArray[@]}
 do
 if [[ ${#MarksArray[$i]}>1 ]]
 then
  MarksArray=( ${MarksArray[@]##*0} )
 fi 
done
}
#give the highest marks and the corresponding course
#if highest marks was in more than one course display all.
function displayHighestMarks(){
 echo
 echo "Following are the courses and there correspoding marks."
 echo "${CourseArray[0]} : ${MarksArray[0]}"
 echo "${CourseArray[1]} : ${MarksArray[1]}"
 echo "${CourseArray[2]} : ${MarksArray[2]}"

 declare -i highestMarks
 for i in 0 1 2
 do
  if (( $(echo "${MarksArray[$i]} > ${MarksArray[$highestMarks]}" | bc ) ))
  then
   (( highestMarks = $i ))
  fi
 done

 echo "The highest scores are: "
 for i in 0 1 2
 do
  if [[ $i = $highestMarks ]]
  then
   echo "${CourseArray[$i]} : ${MarksArray[$i]}"
  elif [[ ${MarksArray[$highestMarks]} = ${MarksArray[$i]} ]]
  then
   echo "${CourseArray[$i]} : ${MarksArray[$i]}"
  fi
 done
}

validateStudentNumber
validateFirstName
validateLastName
validateCourse
validateMarks
displayHighestMarks
