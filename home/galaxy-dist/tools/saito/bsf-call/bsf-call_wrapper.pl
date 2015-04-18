#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

print STDOUT "The tool script is called with:\n", join(" ", ($0, @ARGV)), "\n\n";

my ($idx, $in) = ("", "");
my $default_option = "-o bsf-call.out -W bsfwork";

my $tooldir = shift(@ARGV);
$tooldir = $FindBin::Bin;
$ENV{PATH} = "$tooldir/bin:" . $ENV{PATH};
my $reference_source = shift(@ARGV);
my $read_end = shift(@ARGV);
my $gslot = shift(@ARGV);
#$idx = "$tooldir/data/chrX.sub.fa";

if ($reference_source eq "indexed") {
    $idx = shift(@ARGV);
}
elsif ($reference_source eq "history") {
    my $own = shift(@ARGV);
    $idx = "reference.fa";
    &invoke_command("ln -s $own reference.fa");
}
else {
    die "never reach here\n";
}

if ($read_end eq "single-end") {
    $in = shift(@ARGV);
    &invoke_command("$tooldir/bin/bsf-call $default_option -p $gslot $idx $in");
}
elsif ($read_end eq "paired-end") {
    my $in1 = shift(@ARGV);
    my $in2 = shift(@ARGV);
    $in = $in1 . "," . $in2;
    &invoke_command("$tooldir/bin/bsf-call $default_option -p $gslot $idx $in");
}
else {
    die "never reach here\n";
}

sub invoke_command {
    my ($command) = @_;
    print "invoking: $command\n";
    system($command);
}
