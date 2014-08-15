#!/usr/bin/perl -w
print "Content-type: text/html\n\n";
use DBI;
# Connecting to the database
# Replace DATABASENAME with the name of the database,
# HOSTNAME with the hostname/ip address of the MySQL server.
$drh = DBI->install_driver("mysql");
$dsn = "DBI:mysql:database=test;host=noc6.corp.inmobi.com";
$dbh = DBI->connect($dsn,'mysql','');
# Select the data and display to the browser
my $sth = $dbh->prepare("SELECT * FROM customers");
$sth->execute();
print "<table border cellpadding=1 cellspacing=1><tr><td><b>Name</b></td><td><b>Phone</b></td></tr>";
print "<tr><td>--------</b></td><td><b>--------</b></td></tr>";
while (my $ref = $sth->fetchrow_hashref()) {
    print " <tr><td> $ref->{'CUSTID'} </td> <td> $ref->{'CUSTNAME'}</td></tr>";
}
print "</table>";
$sth->finish();
# Disconnect from the database.
 $dbh->disconnect();
