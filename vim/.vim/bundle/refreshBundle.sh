#! /bin/bash

while read line
do
   DIR=`echo $line |rev |cut -f1 -d/ |rev |cut -f1 -d.`
   echo "Refresh $DIR"
   rm -rf $DIR
   $line
done < ./git_repositories.txt
