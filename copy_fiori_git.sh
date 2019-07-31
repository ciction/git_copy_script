git_origin=$1
git_module_destination=$2
git_ci_cd_repo_name="ci_cd_files_fiori"
# git_ci_cd_repo_base_url="https://gitlab.com/swolfschristophe/"
git_ci_cd_repo_base_url="https://isoapp1199.belgrid.net/fiori/"
git_ci_cd_destination=$git_ci_cd_repo_base_url'/'$git_ci_cd_repo_name'.git'

if [ -z "$git_origin" ]
then
    git_origin="https://github.com/ciction/blender_menger_sponge.git"
    # echo "\$git_origin is empty"
    # exit
fi

if [ -z "$git_module_destination" ]
then
    echo "\$git_module_destination is empty"
    exit
fi
#git_destination_server="https://gitlab.com/swolfschristophe"
# git_destination_server="https://isoapp1199.belgrid.net/CS0006"
git_destination_server="https://isoapp1199.belgrid.net/fiori/"$git_module_destination

#Get the CI/CD file from Git if the folder doesn't exist
if [ ! -d $git_ci_cd_repo_name ]
then
    echo 'Getting CI/CD files from Git'
    git clone $git_ci_cd_destination
    if [ ! -d $git_ci_cd_repo_name ]
    then
        echo "Couldn't get the CI/CD repository, aborting..."
        exit
    fi
fi


repostiroynameGit=$(basename $git_origin)
repostiroyname="${repostiroynameGit%%.*}"  #split string at "."
git_destionation=$git_destination_server'/'$repostiroynameGit

echo $git_destionation


# Git Commands
if [ ! -d $repostiroyname ]
then
    echo 'Git clone source repo'
    git clone $git_origin	 #Clone the project if the directory does not exist
    #Before going into the folder, we copy the extra files needed
    
    echo 'Copy CI CD files to the repo'
    #Copy all files from CI/CD folder except Readme - (maxdepth 1 and f, prevent from copying recursively from the .git subfolder)
    find $git_ci_cd_repo_name -maxdepth 1 -type f ! -name README.md -exec cp -t $repostiroyname {} +
    
    
    #Go to the project
    cd $repostiroyname
    #stage extra files
    echo 'Stage new files'
    git add .
    echo 'Commit new files -m "Adding grunt files"'
    git commit -m 'Adding grunt files'
    
    
    #Exectue the git commands to change the repository
    echo 'Removing old origin'
    git remote rm origin
    echo 'Adding new origin'
    git remote add origin $git_destionation
    echo 'Git Fetch'
    git fetch origin
    echo 'Allow unrelated histories'
    git merge --allow-unrelated-histories origin /master
    echo 'Set the new upstream'
    git push --set-upstream origin master
    echo 'Pushing to the new origin'
    git push origin
else
    echo 'This repository has already been cloned, the script probably already ran for this project. Delete the repository manually if you want to start over.'
    exit
fi