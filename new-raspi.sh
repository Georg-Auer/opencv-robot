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
#pyflycam installation!

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