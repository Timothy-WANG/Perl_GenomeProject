#!/usr/bin/perl

# Usage: get to know what in the quality line in fastq file, trim the low quality base with the quality is #%&' symbol

use strict;
use warnings;

my %hash;

my $quality = "";
die "Syntax: \n\t\tperl $0 <fastq>\n\n" unless $ARGV[0];
$/ = "\@NS";
open( FQ, $ARGV[0]) || die "Can't open $ARGV[0] for $!\n";

my $q=0;
my $w=0;
my $e=0;


while( <FQ> ) {
        chomp;
        if( $_ ){
        my @seq = split /\n/;
#        my $seq_length = length $seq[1];
#       print "$seq_length\n";
        if ( $seq[1] =~ m/(^.*GTTCAGAGTTCTACAGTCCGACGATC)(.*?)(AACTGTAGGCACCATCAAT.*$)/ ) {
			$q++;
                       }

        elsif ( $seq[1] =~ m/(AACTGTAGGCACCATCAAT.*?$)/ ) {  							# Match only tail  && $seq[3] =~ m/(^[^#%&']+)/
			$w++;
	}

        elsif ( $seq[1] =~ m/(^.*?GTTCAGAGTTCTACAGTCCGACGATC)/ ) {						# Match only head   && $seq[3] =~ m/([^#%&']+$)/ 
			$e++;
	}

	}
}

print "both $q\n";
print "3 $w\n";
print "5 $e\n";


close FQ;
