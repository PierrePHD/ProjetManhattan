#!/bin/sh

git clone https://github.com/CollaborativePGD/ProjetManhattan.git

cd ProjetManhattan/

git branch -r > ../.TempListRemoteA
cd ..
rm -rf ProjetManhattan/

sed -e "s/origin\///g" .TempListRemoteA > .TempListRemoteB
sed -e "/master/d" .TempListRemoteB > .TempListRemoteAll	# Contient maintenant toutes les branches autres que master

sed -e "/_dev/d" .TempListRemoteAll > .TempListRemoteMain	# Contient maintenant toutes les branches Principales autres que master
sed -e "/_dev/!d" .TempListRemoteAll > .TempListRemoteDev	# Contient maintenant toutes les branches de developpement


echo ".TempListRemoteDev"
cat .TempListRemoteDev
echo ".TempListRemoteMain"
cat .TempListRemoteMain

while read iter; do
	if [ ! $iter = "" ]
	then
		git clone https://github.com/CollaborativePGD/ProjetManhattan.git
		mv ProjetManhattan/ $iter/
		cd $iter/
			git checkout -b $iter origin/$iter
			git branch -d master
			
			sed -e "/$iter/!d" ../.TempListRemoteDev > ../.TempListRemoteA	# Contient maintenant toutes les branches de developpement de $iter
			while read iter2; do
				if [ ! $iter2 = "" ]
				then
					git clone https://github.com/CollaborativePGD/ProjetManhattan.git
					mv ProjetManhattan/ $iter2/
					cd $iter2/
						git checkout -b $iter2 origin/$iter2
						git branch -d master
					cd ..
				fi
			done <../.TempListRemoteA
		cd ..
	fi
done <.TempListRemoteMain


rm -rf .TempListRemoteB .TempListRemoteA .TempListRemoteAll .TempListRemoteMain .TempListRemoteDev