#!/bin/bash

# a scrpt to down load and unzip the metsense 20Hz data from the server on which it sits.

echo This script will download the 20Hz weather data recorded by the sensor onto of the BioMed School
echo building. To do this you should have been provided with a username and password to access the
echo online archive. Please entre those credentials now.

# read in the username and password for dwnloading data,
read -p 'Username: ' uservar
read -sp 'Password: ' passvar
echo

LIST_FILE="./files_to_download.txt"

# check to see if the files_to_download.txt file exists
if [ ! -f $LIST_FILE ]
then
    echo $LIFT_FILE does not exist, please provide a file containting a list of which files to download.
    exit 1
fi

# create the folder into which zipped files will be saved.
mkdir zip_files

# while through list of files, downloading them to the directory.
while IFS= read -r line
do
    echo Downloading: $line
    curl -u $uservar:$passvar http://137.222.204.171/UKCRIC/metsense/daily_20Hz_dumps/$line --output zip_files/$line
    # curl will return a 0 wheather is achived the download or not, so you have to check the file
    # to see if contains the word 'unauthorized' to see if you actually got the file you want.
    grep Unauthorized zip_files/$line > /dev/null
    if [ ! $? -eq 1 ]
    then 
        echo Error: Authorization failed and file could not be downloaded, please check your access credentials.
        exit 1
    fi

    # now uncompress the file
    echo Uncompressing log file to:
    tar -xvzf zip_files/$line

    # and delete the tar file
    rm zip_files/$line

done < $LIST_FILE

# and delete the folder that had the zip files in
rm -r zip_files


# now we are going to for though the files that have been uncompressed concating them to one big file
# I'm doign this to avoid have both the orignal and concatted on teh disk at the same time.

BIG_FILE=MetSense_20Hz_Complete_Record.log

FILES="home/metsense/data/archive/*"

for f in $FILES
do
    echo Including $f in $BIG_FILE
    cat $f >> $BIG_FILE
    echo Deleting $f
    rm $f
done

# and delete the folder to which files were extracted
rm -r home
