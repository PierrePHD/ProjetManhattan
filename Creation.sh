#!/bin/sh

curl https://raw.githubusercontent.com/CollaborativePGD/ProjetManhattan/ZZScriptsGit/BranchList > TempBranchList

while read iter; do
	if [ ! $iter = "" ]
	then
		sub="_dev"
		iter2="$iter$sub"
		
		#Creation d une branche
		git clone https://github.com/CollaborativePGD/ProjetManhattan.git
		mv ProjetManhattan/ $iter/
		cd $iter/
		
		git checkout -b $iter
		git branch -d master
		git mv Inmaster .in$iter
		git commit -m "Creating $iter branch"
		git push origin $iter:$iter
		
		cd ..
		
		#Creation de la branche dev associee
		git clone https://github.com/CollaborativePGD/ProjetManhattan.git
		mv ProjetManhattan/ $iter/$iter2/
		cd $iter/$iter2/
		git checkout -b $iter origin/$iter
		git checkout -b $iter2
		git branch -d $iter
		git branch -d master
		git mv .in$iter .in$iter2
		git commit -m "Creating $iter2 branch"
		git push origin $iter2:$iter2
		
		cd ../..
	fi
	
done <TempBranchList


while read iter; do

	if [ ! $iter = "" ]
	then
		cd $iter/
		echo "first modification, Forcing merging to keep both branches" > .in$iter
		date >> .in$iter
		git add .in$iter
		git commit -m "Forcing the merge with dev branch to keep both"
		git push origin $iter:$iter
		
		sub="_dev"
		iter2="$iter$sub"
		cd $iter2/
		echo "first modification" > .in$iter2
		date >> .in$iter2
		git add .in$iter2
		git commit -m "Keep branch visible"
		git push origin $iter2:$iter2
		cd ../..
	fi

done <TempBranchList


iter=$(head -n 1 TempBranchList)

cd $iter
git checkout -b master origin/master
echo "first modification" > Inmaster
date >> Inmaster
git add Inmaster
git commit -m "keep master alone"
git push origin master:master
git checkout $iter
git branch -d master

cd ..

rm TempBranchList