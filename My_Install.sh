#!/bin/bash
#Script to allow user to install packages automatically.
#v0.4 (Beta)





read -p "Do you wish to install from the DEB list or your distros repositories? (deb/repo)?" PROMPT
if [ "$PROMPT" == "deb" ]; then
  printf "Installing from DEB list.\n";
  printf "WARNING: if your listed .deb files do not have an online repository, those package won't be updated!\n"
  sleep 3
  
MACHINE_ARCH=`uname -m`
if [ ${MACHINE_ARCH} == 'x86_64' ]; then

    URL='http://media.steampowered.com/client/installer/steam.deb'; PACKAGE=`mktemp`; wget "$URL" -qO $PACKAGE && sudo dpkg -i $PACKAGE; rm $PACKAGE
    URL='http://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'; PACKAGE=`mktemp`; wget "$URL" -qO $PACKAGE && sudo dpkg -i $PACKAGE; rm $PACKAGE
    URL='http://download.virtualbox.org/virtualbox/4.3.8/virtualbox-4.3_4.3.8-92456~Ubuntu~raring_amd64.deb'; PACKAGE=`mktemp`; wget "$URL" -qO $PACKAGE && sudo dpkg -i $PACKAGE; rm $PACKAGE
  
else

    URL='http://path.to/my32bit.deb'; PACKAGE=`mktemp`; wget "$URL" -qO $PACKAGE && sudo dpkg -i $PACKAGE; rm $PACKAGE
    URL='http://path.to/my32bit.deb'; PACKAGE=`mktemp`; wget "$URL" -qO $PACKAGE && sudo dpkg -i $PACKAGE; rm $PACKAGE
    
fi
  
elif [ "$PROMPT" == "repo" ]; then
  printf "Installing from the repositories.";
#pull an update to ensure we have the most recent package lists.
  apt-get update
  
#some packages may require additional PPAs, they can be added here.
  ppa="
       ppa:webupd8team/sublime-text-3
      "
#add each ppa from the array with the "yes" flag.
        sudo add-apt-repository $ppa -y

#pull another update.
        sudo apt-get update
  
#stack them, makes them easier to read.
packages="
	gimp
	vlc
	gparted
	filezilla
	openjdk-7-jre
	ufw
	unity-tweak-tool
	sublime-text-installer
	unrar
	p7zip
	python-pip
	
         "

#install each app from the array with "yes" flag.

	apt-get install $packages -y 
  
fi

sudo pip install butterfly

printf "Package installation has finished."
sleep 5
