#!/usr/bin/perl 
# PERL MODULES WE WILL BE USING
use DBI;
use DBD::mysql;
# Content Header
print "Content-type: text/html\n\n";

    local ($buffer, @pairs, $pair, $name, $value, %FORM);
    # Read in text
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "POST")
    {
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    }else {
	$buffer = $ENV{'QUERY_STRING'};
    }
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs)
    {
	  ($name, $value) = split(/=/, $pair);
	  $value =~ tr/+/ /;
	  $value =~ s/%(..)/pack("C", hex($1))/eg;
	  $FORM{$name} = $value;
    }
    $name = $FORM{name};
    $phone = $FORM{contact};

# CONFIG VARIABLES
#$platform = "mysql";
#$database = "test";
#$port = "3306";
#$host = "noc6.corp.inmobi.com";
#$user = "mysql";
#$pw = "";
$drh = DBI->install_driver("mysql");
#DATA SOURCE NAME
$dsn = "dbi:mysql:database=test;host=noc6.corp.inmobi.com";
# PERL DBI CONNECT
$dbh = DBI->connect($dsn,'mysql','')or die "unable to connect:$DBI::errstr\n";

#$name=$_POST['name'];
#$phone=$_POST['contact'];
#print "Name:";
#print $name;

#PREPARE THE QUERY
$query = "INSERT INTO customers (CUSTID, CUSTNAME) VALUES ('$name','$phone')";
$query_handle = $dbh->prepare($query); 
# EXECUTE THE QUERY
$query_handle->execute() or die $DBI::errstr;
$query_handle->finish();
#$dbh->commit or die $DBI::errstr;
#print "Submitted";
$sth = $dbh->prepare("select * from customers");
$sth->execute() or die $DBI::errstr;

while (my @row = $sth->fetchrow_array()) {
       my ($CUSTID, $CUSTNAME ) = @row;
          print "Name = $CUSTID, Phone = $CUSTNAME\n<br>";
      }
$sth->finish();
