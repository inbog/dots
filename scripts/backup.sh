#!/bin/bash

# initial variables
BACKUPPATH=/home/bot/.backup
DATE=`date +%Y%m%d`
STTIME=`date +%s.%N`

# make some catalogues first
cd $BACKUPPATH
mkdir $DATE
mkdir $DATE/{pacman,etc,music,movies,tasks,notes,home}

# pacman
touch $DATE/pacman/{packages,config}
pacman -Q > $DATE/pacman/packages
sudo cp /etc/pacman.conf $DATE/pacman/config

# etc
mkdir $DATE/etc/{grub,modprobe,udev,X11,sudoers}
sudo cp /boot/grub/grub.cfg $DATE/etc/grub/
sudo cp /etc/default/grub $DATE/etc/grub/default
sudo cp /etc/grub.d/backup/etc_grub_d/40_custom $DATE/etc/grub/40_custom
# 40_custom shouldn't be in backup subdirectory, it's because of GRUB Customizer
sudo cp /etc/modprobe.d/alsa-base.conf $DATE/etc/modprobe/alsa-base.conf
sudo cp /etc/udev/rules.d/10-network.rules $DATE/etc/udev/10-network.rules
sudo cp /etc/X11/xorg.conf.d/* $DATE/etc/X11/
sudo cp /etc/sudoers.d/g_backlight $DATE/etc/sudoers/
sudo cp /etc/sudoers $DATE/etc/sudoers/
sudo cp /etc/{fstab,ntp.conf,profile,asound.conf*} $DATE/etc/
# pacman did change while one of updates, asound.conf.pacorig should work

# music
touch $DATE/music/{checksums,list,tree}
beet check --export > $DATE/music/checksums
ls -lR /home/bot/Muzyka > $DATE/music/list
tree /home/bot/Muzyka > $DATE/music/tree

# movies
touch $DATE/movies/{list,tree,ratings}
ls -alR /home/bot/Filmy > $DATE/movies/list
tree -a /home/bot/Filmy > $DATE/movies/tree
cat /home/bot/Filmy/.ocena > $DATE/movies/ratings

# tasks
touch $DATE/tasks/.checksums
rhash --printf='%C\t%p\n' /home/bot/.task/* > $DATE/tasks/.checksums
cp --preserve /home/bot/.task/* $DATE/tasks/

# notes
touch $DATE/notes/.checksums
rhash --printf='%C\t%p\n' /home/bot/.note/* > $DATE/notes/.checksums
cp --preserve /home/bot/.note/* $DATE/notes/

# home
mkdir $DATE/home/config
mkdir $DATE/home/config/{beets,bspwm,htop,mpd,mpv,ranger,sxkhd,transmission,gtk20,gtk30,puddletag,QtProject,Thunar,xfce4}
mkdir $DATE/home/{dots,mpdscribble,ncmpcpp,vim}
cp /home/bot/.config/beets/* $DATE/home/config/beets/
cp /home/bot/.config/bspwm/* $DATE/home/config/bspwm/
cp /home/bot/.config/htop/* $DATE/home/config/htop
cp -r /home/bot/.config/mpd/* $DATE/home/config/mpd
cp /home/bot/.config/mpv/* $DATE/home/config/mpv
cp /home/bot/.config/ranger/* $DATE/home/config/ranger
cp /home/bot/.config/sxkhd/* $DATE/home/config/sxkhd
cp -r /home/bot/.config/puddletag/* $DATE/home/config/puddletag/
cp -r /home/bot/.config/QtProject/* $DATE/home/config/QtProject/
cp -r /home/bot/.config/Thunar/* $DATE/home/config/Thunar/
cp -r /home/bot/.config/xfce4/* $DATE/home/config/xfce4/
cp -r /home/bot/.config/transmission/* $DATE/home/config/transmission
cp -r /home/bot/.config/gtk-2.0/* $DATE/home/config/gtk20
cp -r /home/bot/.config/gtk-3.0/* $DATE/home/config/gtk30
cp -r /home/bot/.dots/* $DATE/home/dots/
cp -r /home/bot/.mpdscribble/* $DATE/home/mpdscribble/
cp -r /home/bot/.ncmpcpp/* $DATE/home/ncmpcpp/
cp -r /home/bot/.vim/* $DATE/home/vim/
cp /home/bot/.config/{qnapi.ini,redshift.conf,user-dirs.*} $DATE/home/config/
cp /home/{.bash_profile,.bashrc,.fehbg,.gtkrc-2.0,.noterc,.taskrc,.viminfo,.vimrc,.xinitrc,.Xresources,.xscreensaver} $DATE/home/

# pack backup to archive and clean up
sudo tar -czf $DATE.tar.gz $DATE/

ENTIME=`date +%s.%N`
DFTIME=`echo "scale=3; ($ENTIME - $STTIME)/1" | bc`
echo Backup done in $DFTIME second\(s\).
