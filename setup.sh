#!/bin/bash
echo '-----------------------------------------------------------------------------------------------'
echo '---- UPDATING THE SYSTEM FOR AWS EC2 MULTIUSER CLASSROOM SERVER'
echo '---- version 2016-08-03'
echo '---- run as root'
echo '-----------------------------------------------------------------------------------------------'

echo 'Starting shell script at:'
date
whoami
pwd

apt-get -qq update -y
apt-get -qq upgrade -y

echo '---- SETTING HOST NAME'
hostnamectl set-hostname localhost
hostnamectl
echo '--'

echo '---- INSTALLING UTILITY PROGRAMS'
apt-get -qq install -y git bzip2 zip unzip screen

echo '--'
echo '--'
echo '--'
echo '-----------------------------------------------------------------------------------------------'
echo '---- INSTALLING COMPILERS AND SERVERS'
echo '-----------------------------------------------------------------------------------------------'

echo '----PERL IS PREINSTALLED'
perl --version
echo '--'

echo '---- PYTHON AND PYTHON3 ARE PREINSTALLED'
python3 --version
echo '--'

echo '---- RUBY IS PREINSTALLED ON VAGRANT BUT NOT ON AWS'
apt-get -qq install -y ruby
ruby --version
echo '--'

echo '---- INSTALLING C AND C++ COMPILERS'
apt-get -qq install -y build-essential
gcc --version
g++ --version
echo '--'

#echo '---- INSTALLING C# COMPILER'
#apt-get -qq install -y mono-complete
#mono
#echo '--'

#echo '---- INSTALLING GO'
#apt-get -qq install -y golang
#go version
#echo '--'

echo '---- INSTALLING JAVA 8 COMPILER'
apt-get -qq install -y openjdk-8-jdk
javac -version
java -version

#echo '---- INSTALLING JAVA/MYSQL JDBC DRIVER'
#apt-get -qq install libmysql-java
#echo 'CLASSPATH=.:/usr/share/java/mysql-connector-java.jar' >> /etc/environment
#echo '--'

#echo '---- INSTALLING CLOJURE'
#apt-get install -y clojure1.6
#echo '--'

#echo '---- INSTALLING LEGACY COMPILERS'
#echo '--'

#echo '---- INSTALLING FORTRAN COMPILER'
#apt-get install -y gfortran
#gfortran --version
#echo '--'

#echo '---- INSTALLING COBOL COMPILER'
#apt-get install -y open-cobol
#cobc -V
#echo '--'

#echo '---- INSTALLING PL/I COMPILER'
#wget http://www.iron-spring.com/pli-0.9.9.tgz
#tar -xvzf pli-0.9.9.tgz
#cd pli-0.9.9
#make install
#cd ..
#rm -f pli-0.9.9.tgz
#plic -V

echo '--'
echo '--'
echo '--'
echo '-----------------------------------------------------------------------------------------------'
echo '---- INSTALLING LAMP: APACHE2, MYSQL, AND PHP'
echo '-----------------------------------------------------------------------------------------------'

apt-get -qq install -y apache2
echo '--'

#echo '---- INSTALLING PHP5'
#apt-get -qq install -y php5 php5-mysql libapache2-mod-php5 php5-gd php5-imagick php-pear php5-json
#echo '--'

#echo '---- INSTALLING MYSQL WITH NO ROOT PASSWORD'
#DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
#echo '--'

echo '---- CONFIGURE APACHE2 with CGI and User directories'
echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf
a2enconf servername.conf

sed -i 's/#AddHandler cgi-script .cgi/AddHandler cgi-script .cgi .pl .py .rb/' /etc/apache2/mods-available/mime.conf

sed -i 's/IncludesNoExec/ExecCGI/' /etc/apache2/mods-available/userdir.conf

sed -i 's/<IfModule mod_userdir.c>/#<IfModule mod_userdir.c>/' /etc/apache2/mods-available/php5.conf
sed -i 's/    <Directory/#    <Directory/' /etc/apache2/mods-available/php5.conf
sed -i 's/        php_admin_flag engine Off/#        php_admin_flag engine Off/' /etc/apache2/mods-available/php5.conf
sed -i 's/    <\/Directory>/#    <\/Directory>/' /etc/apache2/mods-available/php5.conf
sed -i 's/<\/IfModule>/#<\/IfModule>/' /etc/apache2/mods-available/php5.conf

a2enmod userdir
a2enmod cgid
a2disconf serve-cgi-bin

systemctl reload apache2
systemctl restart apache2
systemctl status apache2
echo '--'

echo '---- FIXING APACHE ERROR LOG SO ALL USERS CAN READ IT'
chmod 644 /var/log/apache2/error.log
chmod 755 /var/log/apache2
sed -i 's/create 640 root adm/create 644 root adm/' /etc/logrotate.d/apache2
echo '--'


#echo '---- INSTALLING TOMCAT JAVA WEB SERVER'
#apt-get -qq install -y tomcat8 tomcat8-docs tomcat8-admin tomcat8-examples
#systemctl status tomcat8
#echo '--'

#echo '---- CONFIGURE TOMCAT'
#echo '---- SET THE TOMCAT ADMIN USER: tomcat'
#echo '---- SET THE TOMCAT ADMIN PASSWORD: tomcatpw'
#echo '---- UPLOAD AND RUN JSP PROGRAMS AT BROWSER URL OF: ipaddress:8080'
#sed -i 's/<\/tomcat-users>/  <user username="tomcat" password="mucis" roles="manager-gui,admin-gui"\/><\/tomcat-users>/' #systemctl restart tomcat8

echo '--'
echo '--'
echo '--'
    echo '-----------------------------------------------------------------------------------------------'
    echo '---- INSTALLING GUI ENVIRONMENT'
    echo '-----------------------------------------------------------------------------------------------'

    echo '---- INSTALLING REMOTE DESKTOP AND MATE GUI'
    apt-get -qq install -y xrdp
    sed -i 's/.*\/etc\/X11\/Xsession/mate-session/' /etc/xrdp/startwm.sh

    apt-get -qq install -y mate-core
    apt-get -qq install -y mate-desktop-environment-core
    apt-get -qq install -y mate-tweak
    apt-get -qq install -y mate-user-guide mate-utils-common mate-menu mate-control-center-common
    #apt-get -qq install -y mate-core mate-desktop-environment mate-notification-daemon
    apt-get install -y mate-themes ubuntu-mate-wallpapers-utopic ubuntu-mate-wallpapers-vivid
    apt-get install -y fonts-inconsolata fonts-dejavu fonts-droid-fallback fonts-liberation fonts-ubuntu-font-family-console
    apt-get install -y xterm vim-gnome gdebi-core pluma
    apt-get install -y firefox
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    gdebi -n google-chrome-stable_current_amd64.deb
    rm -f google-chrome-stable_current_amd64.deb
    echo '--'

        #wget https://github.com/atom/atom/releases/download/v1.7.4/atom-amd64.deb
        #gdebi -n atom-amd64.deb

        #add-apt-repository -y ppa:webupd8team/atom
        #apt-get -y update
        #apt-get install -y atom

        #wget https://github.com/adobe/brackets/releases/download/release-1.6/Brackets.Release.1.6.64-bit.deb
        #wget http://archive.ubuntu.com/ubuntu/pool/main/libg/libgcrypt11/libgcrypt11_1.5.3-2ubuntu4_amd64.deb
        #gdebi -n libgcrypt11_1.5.3-2ubuntu4_amd64.deb
        #gdebi -n Brackets.Release.1.6.64-bit.deb

        #wget https://www.dropbox.com/install

        #apt-get install -y synaptic

    echo '---- INSTALLING PYTHON3 TK GRAPHICS LIBRARY'
    apt-get install -y python3-tk
    echo '--'


    echo '-----------------------------------------------------------------------------------------------'
    echo '---- INSTALLING GUI IDEs'
    echo '-----------------------------------------------------------------------------------------------'

#    echo '---- INSTALLING C, C++, C# Mono IDE'
#    apt-get install -y monodevelop
#    echo '--'
#
#    echo '---- INSTALLING SPRING STS / ECLIPSE IDE'
#    wget http://dist.springsource.com/release/STS/3.7.2.RELEASE/dist/e4.5/spring-tool-suite-3.7.2.RELEASE-e4.5.1-linux-gtk-x86_64                            .tar.gz
#    tar xvzf spring-tool-suite-3.7.2.RELEASE-e4.5.1-linux-gtk-x86_64.tar.gz
#    rm -f spring-tool-suite-3.7.2.RELEASE-e4.5.1-linux-gtk-x86_64.tar.gz
#    echo 'RUN AS: ~/sts-bundle/sts-3.7.2.RELEASE/STS'
#    echo '--'
#
    #echo '---- INSTALLING NETBEANS IDE (as of 20160118 installing older version 8.0.2)'
    #apt-get install -y netbeans

echo '--'
echo '--'
echo '--'
echo '-----------------------------------------------------------------------------------------------'
echo '---- CREATING FILES FOR THE USERS'
echo '-----------------------------------------------------------------------------------------------'

echo '---- CONFIGURE SKEL WITH TEST FILES FOR ALL USERS'
mkdir /etc/skel/public_html
mkdir /etc/skel/public_html/test

echo "<html><body>Hello from HTML</body></html>" > /etc/skel/public_html/test/htmltest.html

#echo "<?php phpinfo(); ?>" > /etc/skel/public_html/test/phptest.php

#echo "#!/usr/bin/perl" > /etc/skel/public_html/test/perltest.pl
#echo 'print "Content-type: text/html\n\n";' >> /etc/skel/public_html/test/perltest.pl
#echo 'print "Hello from Perl\n";' >> /etc/skel/public_html/test/perltest.pl
#chmod 755 /etc/skel/public_html/test/perltest.pl

echo "#!/usr/bin/python3" > /etc/skel/public_html/test/pythontest.py
echo 'print ("Content-type: text/html\n\n")' >> /etc/skel/public_html/test/pythontest.py
echo 'print ("Hello from Python\n")' >> /etc/skel/public_html/test/pythontest.py
chmod 755 /etc/skel/public_html/test/pythontest.py

#echo "#!/usr/bin/ruby" > /etc/skel/public_html/test/rubytest.rb
#echo 'print "Content-type: text/html\n\n"' >> /etc/skel/public_html/test/rubytest.rb
#echo 'print "<html><body><p>Hello using Ruby!</p></body></html>"' >> /etc/skel/public_html/test/rubytest.rb
#chmod 755 /etc/skel/public_html/test/rubytest.rb
#echo '--'

#echo "import java.sql.Connection;" > /etc/skel/public_html/test/JDBCTest.java
#echo "import java.sql.DriverManager;" >> /etc/skel/public_html/test/JDBCTest.java
#echo "class JDBCTest {" >> /etc/skel/public_html/test/JDBCTest.java
#echo "public static void main(String[] args) {" >> /etc/skel/public_html/test/JDBCTest.java
#echo '  try(Connection con=DriverManager.getConnection("jdbc:mysql://localhost","yourdbusername","yourdbuserpassword")){' >> /etc/skel/public_html/test/JDBCTest.java
#echo '  System.out.println("Connected");' >> /etc/skel/public_html/test/JDBCTest.java
#echo '} catch (Exception e) {' >> /etc/skel/public_html/test/JDBCTest.java
#echo '  e.printStackTrace();' >> /etc/skel/public_html/test/JDBCTest.java
#echo '}}}' >> /etc/skel/public_html/test/JDBCTest.java

echo '---- ADDING TEST USER jdoe'
useradd -m jdoe -c 'Jane Doe' -s '/bin/bash'
echo '--'

echo '---- SETTING PASSWORD FOR USER jdoe TO mucis'
echo jdoe:mucis | sudo chpasswd
echo '--'

echo '---- ALLOWING PASSWORD LOGINS - BE SURE TO SET AWS FIREWALL CORRECTLY TO LIMIT ACCESS BY IP'
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo '--'

#echo '---- CREATING A TEST DATABASE FOR jdoe'
#mysql -uroot -e "create database jdoe"
#mysql -uroot -e "GRANT ALL PRIVILEGES ON jdoe.* TO jdoe@localhost IDENTIFIED BY 'mucis'"
#mysql -ujdoe -pmucis -e "use jdoe;drop table if exists address;create table address(name varchar(50) not null, street varchar(50) not null, primary key(name));"
#mysql -ujdoe -pmucis -e "use jdoe;insert into address values('Jane', '123 Main Street');insert into address values('Bob', '222 Oak Street');insert into address values('Sue', '555 Trail Street');"
#echo '--'


echo '-----------------------------------------------------------------------------------------------'
echo '--- REMINDERS'
echo '-----------------------------------------------------------------------------------------------'
echo '---- Do not forget to set AWS firewall to limit SSH connections to just a few specific ip addresses'
echo '---- Admin user: ubuntu password: none, log in using AWS private key'
echo '---- Test user: jdoe password: mucis'
echo '---- MySQL admin user: root password: none'
echo '---- MySQL jdoe user: jdoe password: mucis'
echo '---- Tomcat admin user: tomcat password: mucis'
echo '---- SECURE MYSQL USING: sudo mysql_secure_installation'
echo '---- REPLACE THE ABOVE PASSWORDS'
echo '---- REBOOT THE SERVER FROM THE AWS CONTROL PANEL'
echo '--'
echo 'Ending shell script at:'
date

