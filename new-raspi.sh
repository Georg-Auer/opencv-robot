#format SD card with balena etcher, and install the latest raspian
#create a file on the card named SSH (no file extension)
#find the ip of the raspberry, it is displayed at the first boot or found via Advanced IP Scanner (Windows) or 
#install a X11 "X Server" on your machine, for instance VcXSrv in Windows 10, or xquartz for Mac OS X http://xquartz.macosforge.org/
#login via SSH, for instance PuTTy in Windows 10 (enable X11!)
#login with username: "pi" and password "raspberry"
#change password with raspi-config for security reasons with:
#sudo raspi-config

#samba enables the hostname for easy SSH access
sudo apt-get -y install samba
#modify: YES


#the rest is automatic:
sudo apt-get -y install feh

#upgrades..
sudo apt-get upgrade -y
sudo apt autoremove -y

#needed for python opencv-contrib-python==4.1.0.25:
sudo apt-get install -y libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev  libqtgui4  libqt4-test

cd /home/pi/projects
mkdir projects
cd projects
git clone https://github.com/Georg1986/spoc.git
#georg.auer@gmail.com
#PASSWORD

sudo pip3 install virtualenv virtualenvwrapper

#write to bashrc file
echo "# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc

#create new environment named "delta" using python3 and associate with the created directory
mkvirtualenv delta -p python3 -a ~/projects/spoc/delta_bot

# this should be done in the virtual environment!:
pip install pygame
pip install osc4py3
pip install opencv-contrib-python==4.1.0.25

#cameras:
pip install "picamera[array]"

#write the following two lines into rules.d:
#https://answers.opencv.org/question/221305/how-to-get-pointgrey-camera-acquiring-image-data-in-python-on-raspberry-pi/

sudo tee -a /etc/udev/rules.d/10-pointgrey.rules <<EOT
# udev rules file for Point Grey Firefly-MV
BUS=="usb", SYSFS{idVendor}=="1e10", SYSFS{idProduct}=="3300", GROUP="plugdev"
EOT

#--------------super-experimental-installation-guide-not-yet-working!!!!!!!!!!!!!!-----------------------

#pyflycam installation!
#at first, install FlyCapture SDK 

#(for ARM) look into the help file/webpage
#https://www.flir.com/support-center/iis/machine-vision/application-note/getting-started-with-flycapture-2-and-arm/

# wget https://tinyurl.com/ty2kgax
# mv ty2kgax flycap-sdk.tar.gz
# tar xzvf flycap-sdk.tar.gz

# # go into the lib folder, and 
# cd flycapture-<version>_arm/lib

# sudo cp libflycapture* /usr/lib
# sudo cp pwd /usr/lib

#sudo cp -r /home/pi/.virtualenvs/delta/bin/flycapture.2.13.3.31_armhf/lib /usr/lib


# #cd flycapture-<version>_arm/
# cd ..


# sudo sh flycap2-conf

# #install tools needed by PyCapture2
# sudo pip install setuptools cython numpy

# cd ~/.virtualenvs/delta/bin

# #not sure if this link works permanetly
# wget https://tinyurl.com/snyf68t
# #because said homepage is very excentric, the files name will be now snyf68t
# #therefore, rename it like this:
# mv snyf68t flycap.tar.gz
# #extract tar.gz files with
# tar xzvf flycap.tar.gz
# #now install as described in the extracted file README_Linux.txt
# sudo python setup.py install

#--------------end-of-super-experimental-installation-guide---------------------------------------

#installs puredata, externals are missing..
sudo apt-get -y install puredata --fix-missing
cd /home/pi/
sudo mkdir Pd
sudo mkdir Pd/externals
cd /home/pi/Pd/externals/
#import externals here - skript breaks anyway?

#arduino:
cd ~
sudo mkdir Arduino
cd ~/Arduino
sudo wget https://downloads.arduino.cc/arduino-1.8.9-linuxarm.tar.xz
sudo tar xf arduino-1.8.9-linuxarm.tar.xz
#does the next step work?
cd ~/Arduino/arduino-1.8.9/
#or this?
sudo ./install.sh
cd ..
sudo rm -rf arduino-1.8.9-linuxarm.tar.xz

#teensy:
cd /etc/udev/rules.d/
sudo wget https://www.pjrc.com/teensy/49-teensy.rules
sudo mkdir Downloads
cd ~/Downloads
sudo wget https://www.pjrc.com/teensy/td_148/TeensyduinoInstall.linuxarm
sudo chmod 755 TeensyduinoInstall.linuxarm
./TeensyduinoInstall.linuxarm
#choose where you put the installation files in the GUI
