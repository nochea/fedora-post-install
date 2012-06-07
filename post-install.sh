#!/usr/bin/env bash
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Are you root ? Needed to launch this script
ROOT_UID=0
if [ $UID -ne $ROOT_UID ]
then                                                                                                       
    echo ":/ You must be root to run this script... Quiting"
exit $E_NOTROOT
else
  echo ";) Welcome root"
fi              

# Some stuff not to forget before reinstall a system
# 
# Files to be saved : 
# 
# /root/.vimrc
# /etc/yum.conf
# 
# Check if /home/nochea/.ssh directory has been saved.

# Test if backup media is connected : 

if [ -e /media/89d7c618-1bb9-47a3-abf3-53ac3765c354 ]
then
  echo "Backup Media found, great !"
else
  echo "Cannot find backup Media, exit"
  exit 1
fi

# Hey! this is my main backup Script. Rather simple ??!
# a : recursive - symlinks - permissions - times - group - owner - Devices
# v : verbose
# z : Compress file during transfert (Think finally it's not much important. (i.e no network transfert)
rsync -av /home/nochea/ /media/89d7c618-1bb9-47a3-abf3-53ac3765c354/nochea


# First go to :
cd /etc/yum.repos.d

# Then grab Chromium and VirtualBox repo
# TODO what about skype ?
urlgrabber http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-chromium-stable.repo
urlgrabber http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

# Come back home and launch .yum script
cd ~ && yum shell post-install.yum

# Last thing should be to rsync my data back from External HDD
rsync -av /media/89d7c618-1bb9-47a3-abf3-53ac3765c354/nochea/ /home/nochea
