#!/bin/bash

curl https://raw.githubusercontent.com/CollaborativePGD/ProjetManhattan/ZZScriptsGit/BranchList > TempBranchList

while read iter; do
	
	echo $iter

if [ ! $iter = "" ]
then
	sub="_dev"
	iter2="$iter$sub"
	
	cd $iter/
		echo "add modification" >> .in$iter
		date >> .in$iter
		git add .in$iter
		git commit -m "example of modification for branche visibility"
		git push origin $iter:$iter
		
		cd $iter2/
			echo "add modification" >> .in$iter2
			date >> .in$iter2
			git add .in$iter2
			git commit -m "example of modification for branche visibility"
			git push origin $iter2:$iter2
	cd ../..
	
sortie="$iter"

fi

done <TempBranchList

rm TempBranchList

cd $sortie/
	pwd
	git checkout -b master origin/master
	git fetch
	git pull
	echo "add modification" >> Inmaster
	date >> Inmaster
	git add Inmaster
	git commit -m "example of modification for branche visibility"
	git push origin master:master
	git checkout $sortie
	git branch -d master
cd ..
