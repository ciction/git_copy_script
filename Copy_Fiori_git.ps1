 param (
    [string]$git_origin = $( Read-Host "git origin ( https://github.com/MYNAME/MYPROJECT.git )" ),
    [string]$git_destination_server = $( Read-Host "git destination server ( https://destination.server.net/username)
 )

 

 # If the destionation is empty set it to default value
 if (!$git_destination_server) {
  #SET DEFAULT SERVER HERE
  $git_destination_server = "https://destination.server.net/username" 
}

#Extract repository name, use it as folder name on the local machine and as the name for the destination repository
 $repostiroynameGit = Split-Path -Path $git_origin -Leaf
 $repostiroyname = $repostiroynameGit.Split('.')[0]
 $git_destionation = $git_destination_server + '/' + $repostiroynameGit

# Git Commands
git clone $git_origin
cd $repostiroyname
git remote rm origin
git remote add origin $git_destionation
git fetch origin 
git merge --allow-unrelated-histories origin /master
git push --set-upstream origin master
git push origin