git_origin=$1
git_destination_server=$2

if [ -z "$git_origin" ]
then
      echo "\$git_origin is empty"
	  exit
fi

if [ -z "$git_destination_server" ]
then
	#echo "\$git_destination is empty, defaulted to https://isoapp1199.belgrid.net/CS0006"
	#git_destination_server="https://isoapp1199.belgrid.net/CS0006"
	git_destination_server="https://gitlab.com/swolfschristophe/"
fi



repostiroynameGit=$(basename $git_origin)
repostiroyname="${repostiroynameGit%%.*}"  #split string at "."
git_destionation=$git_destination_server'/'$repostiroynameGit

echo $git_destionation	


# Git Commands
echo 'clone'
if [ ! -d $repostiroyname ]
then
	git clone $git_origin
fi
echo 'cd' $repostiroyname
cd $repostiroyname
echo 'rm'
git remote rm origin
echo 'add origin'
git remote add origin $git_destionation
echo 'fetch'
git fetch origin 
echo 'merge'
git merge --allow-unrelated-histories origin /master
echo 'set upstream'
git push --set-upstream origin master
echo 'push'
git push origin
