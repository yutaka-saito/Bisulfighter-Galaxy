#!/usr/bin/perl

use strict;
use warnings;

my ($infile, $outdmc, $outdmr) = ("", "", "");
my $default_option = "--nobeta --nodual";

print STDOUT join(" ", @ARGV), "\n";




my $intype_intype_mapper = shift(@ARGV);



if ($intype_intype_mapper eq "commet") {
    ($infile, $outdmc, $outdmr) = @ARGV;
    invoke_command "ComMet $default_option $infile $outdmc $ourdmr"

}




sub invoke_command {
    my ($command) = @_;
    print "invoking: $command\n";
    system($command);
}
