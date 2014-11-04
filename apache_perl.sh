apt-get update -y
apt-get install perl apache2 libapache2-mod-perl2 curl -y
sudo apache2ctl restart
a2enmod cgi
chown -R www-data:www-data /usr/lib/cgi-bin/
/etc/init.d/apache2 restart
cat > /usr/lib/cgi-bin/sample.pl << EOM
#!/usr/bin/perl 

print "Content-type: text/html\n\n";
print "Hello HTML\n\n";

EOM
chmod a+x /usr/lib/cgi-bin/sample.pl
chown -R www-data:www-data /usr/lib/cgi-bin/sample.pl
curl http://localhost/cgi-bin/sample.pl
