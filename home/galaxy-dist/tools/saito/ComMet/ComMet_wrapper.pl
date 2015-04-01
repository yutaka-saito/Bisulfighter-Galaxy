#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

print STDOUT join(" ", @ARGV), "\n";

my ($in, $outdmc, $outdmr) = ("", "", "");
#my $default_option = "--nobeta --nodual";
my $default_option = "";

my $tooldir = shift(@ARGV);
$tooldir = $FindBin::Bin;
my $intype_mapper = shift(@ARGV);

if ($intype_mapper eq "bsf-call") {
    my $in1 = shift(@ARGV);
    my $in2 = shift(@ARGV);
    my $tmp = "ComMet.tmp.$$";
    ($outdmc, $outdmr) = @ARGV;
    &invoke_command("$tooldir/bin/Bsf2ComMetIn.pl $in1 $in2 > $tmp");
    &invoke_command("$tooldir/bin/ComMet $default_option $tmp $outdmc $outdmr");
}
elsif ($intype_mapper eq "commet") {
    ($in, $outdmc, $outdmr) = @ARGV;
    &invoke_command("$tooldir/bin/ComMet $default_option $in $outdmc $outdmr");
}
else {
    die "never reach here\n";
}

sub invoke_command {
    my ($command) = @_;
    print "invoking: $command\n";
    system($command);
}

=pod
<!--
    <conditional name="advancedset">
      <param name="advancedset_use" type="select" label="use advanced setting">
        <option value="No" selected="true">No</option>
        <option value="Yes">Yes</option>
      </param>
      <when value="No">
      </when>
      <when value="Yes">
        <param name="beta" type="boolean" falsevalue="--nobeta" label="use beta mixture distributions"/>
        <param name="dual" type="boolean" falsevalue="--nodual" label="use dual HMM architectures"/>
        <param name="cpg" type="boolean" falsevalue="--noncpg" label="input files contain cytosine sites only in CpG context"/>
      </when>
    </conditional>    
-->
=cut
