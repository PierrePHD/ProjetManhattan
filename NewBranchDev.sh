#!/bin/sh

if [ ! $1 = "" ]
then

	git branch > TempBranchA
	sed "/\*/!d" TempBranchA > TempBranchB
	sed "s/\* //g" TempBranchB > TempBranchA
	
	directory=`basename \`pwd\``
	
	if [ $directory = $(cat TempBranchA) ]
	then
		iter="$(cat TempBranchA)_dev_$1"
		main=$(cat TempBranchA)
		
		#Technique 1
			git clone https://github.com/CollaborativePGD/ProjetManhattan.git
			
			mv ProjetManhattan/ $iter/
			cd $iter/
				git checkout -b $main origin/$main
				git checkout -b $iter
				git mv .in$main .in$iter
				git commit -m "Creating $iter branch"
				git push origin $iter:$iter
				git branch -d $main
				git branch -d master
			cd ..
	fi		
	
	rm -rf TempBranchA TempBranchB
else
	echo "Il faut donner un nom a la branche"
fi
