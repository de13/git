#!/bin/bash

git checkout -b green 
echo "# super dumper commit" > newfile.txt
echo -e "\n#I created the newfile.txt to solve the issue" >> README.md
git commit -a -m "solevd teh issue with a newfiel"
git checkout -b newbranch
echo -e "\nEverything looks fine now" >> README.md
git commit -a -m "nothing here, just to say"
git checkout master
git merge green
git branch -d green
git merge newbranch