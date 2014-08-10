#!/usr/bin/perl -w

print "ContentType: text/html\n\n";
use DBI;

#my $dbh = DBI->connect('dbi:mysql:database=test;host=localhost','mysql','', {AutoCommit=>1,RaiseError=>1,PrintError=>0});
#my $abc = $dbh->prepare("SELECT * from customers");
#$abc->execute();
#while (my $ref = $abc->fetchrow_hashref()) {
#print "Found a row: id = $ref->{'CUSTID'}, name = $ref->{'CUSTNAME'}";
#}
#
#$abc->finish();
#$dbh->disconnect();
# Connecting to the database
# Replace DATABASENAME with the name of the database,
# HOSTNAME with the hostname/ip address of the MySQL server.
$drh = DBI->install_driver("mysql");
$dsn = "DBI:mysql:database=test;host=localhost";
$dbh = DBI->connect($dsn,'mysql','');

# Select the data and display to the browser

my $sth = $dbh->prepare("SELECT * FROM customers");
$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
print "Found a row: id = $ref->{'CUSTID'}, name = $ref->{'CUSTNAME'}\n";
}

$sth->finish();

# Disconnect from the database.

$dbh->disconnect();
