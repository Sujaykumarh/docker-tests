#!/bin/bash

echo "Prune Docker on system"

read -p "Are you sure? [y/N] " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Pruning Docker System"
docker system prune

echo "Pruning Docker Networks"
docker network prune

echo "Pruning Docker Volumes"
docker volume prune


# echo -e  "\n"
read -p "Remove unused images? This action cannot be undone [y/N] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\nRemoving these Images from system \n"
    docker images --all
    
    echo -e '\n'
    read -p "Are you sure? [y/N] " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "\nRemoving unused docker images"
        docker rmi $(docker images --all -q)
    else        
        echo -e "\nAction cancelled"
    fi
fi
echo -e "\n"

echo "Pruning Docker Complete"
