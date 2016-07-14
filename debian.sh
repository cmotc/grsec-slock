#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=slock
SOURCEDOC=README.md
DEBFOLDER=slock
DEBVERSION=$(date +%Y%m%d)
CONTROL_FILE="Source: slock
Section: admin
Priority: optional
Maintainer: Dimitris Papastamos <sin@2f30.org>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: http://core.suckless.org/sinit
Vcs-Git: git@github.com:cmotc/slock.git
Vcs-Browser: http://github.com/cmotc/slock

Package: slock
Architecture: all
Depends: \${misc:Depends}
Description: slock is the simplest screen locker possible.
 slock is the simplest screen locker possible. This fork of
 slock makes a few modifications, it has a custom, non-user
 password for unlocking the screen saver, it will power down
 the computer after 5 failed login attempts, and it turns on
 kernel.grsecurity.deny_new_usb in the kernel if sysctl has
 not been locked.
 .
 "
POSTINSTALL_FILE="to be added"
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make -s --indep --createorig
echo "$CONTROL_FILE" > debian/control

# Remove make calls
#grep -v makefile debian/rules > debian/rules.new
#mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
#echo $DEBFOLDER usr/bin > debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log
