#!/usr/bin/perl

use strict;
use warnings;

print STDOUT "This is a test script.\n";

sub invoke_command {
    my ($command) = @_;
    print "invoking: $command\n";
    system($command);
}
