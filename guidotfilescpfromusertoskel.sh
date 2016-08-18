# create user river and set up the gui the way you want it
# cd into the /etc/skel folder
# run this as root to copy river's gui setup files to the skel folder
# now when you adduser it will copy the skel folder to the new user's home folder

cp -r /home/river/.config/ ./ 
cp -r /home/river/.dbus/  ./
cp -r /home/river/.gconf/ ./
cp -r /home/river/.gnome/ ./
cp -r /home/river/.icons/ ./
cp -r /home/river/.local/ ./
cp -r /home/river/.mozilla/ ./
cp -r /home/river/.pki/ ./
cp -r /home/river/.themes/ ./ 
