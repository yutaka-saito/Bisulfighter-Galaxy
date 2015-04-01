#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

print STDOUT join(" ", ($0, @ARGV)), "\n";

my ($in, $outres) = ("", "");
my $default_option = "";

my $tooldir = shift(@ARGV);
$tooldir = $FindBin::Bin;
my $intype_read = shift(@ARGV);
my $idx = shift(@ARGV);
$idx = "$tooldir/data/chrX.sub.fa";

if ($intype_read eq "single-end") {
    ($in, $outres)  = @ARGV;
    &invoke_command("$tooldir/bin/bsf-call $idx $in > $outres");
}
elsif ($intype_read eq "paired-end") {
    my $in1 = shift(@ARGV);
    my $in2 = shift(@ARGV);
    $in = $in1 . "," . $in2;
    $outres = shift(@ARGV);
    &invoke_command("$tooldir/bin/bsf-call $idx $in > $outres");
}
else {
    die "never reach here\n";
}

sub invoke_command {
    my ($command) = @_;
    print "invoking: $command\n";
    system($command);
}
