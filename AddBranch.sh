#!/bin/sh

iter="NewB"

sub="_dev"
iter2="$iter$sub"

git clone https://github.com/CollaborativePGD/ProjetManhattan.git

mv ProjetManhattan/ $iter/
cd $iter/

	git checkout -b Script origin/ZZScriptsGit
	echo "$iter" >> BranchList
	cat BranchList | sort > TempBranchList
	cat TempBranchList > BranchList
	git add BranchList
	git commit -m "add branch $iter"
	git push
	
	git checkout -b $iter
	git branch -d master
	git branch -d Script
	git mv Inmaster .in$iter
	#	echo "$iter2/" >> .gitignore
	#	git add .gitignore
	git commit -m "Creating $iter branch"
	git push origin $iter:$iter

cd ..

git clone https://github.com/CollaborativePGD/ProjetManhattan.git
mv ProjetManhattan/ $iter/$iter2/
cd $iter/$iter2/
	git checkout -b $iter origin/$iter
	git branch $iter2
	git checkout $iter2
	git branch -d $iter
	git branch -d master
	git mv .in$iter .in$iter2
	git commit -m "Creating $iter2 branch"
	git push origin $iter2:$iter2
cd ../..

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
