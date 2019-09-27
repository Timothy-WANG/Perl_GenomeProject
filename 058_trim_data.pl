#!/usr/bin/perl

# Usage: get to know what in the quality line in fastq file, trim the low quality base with the quality is #%&' symbol

use strict;
use warnings;

my %hash;

my $quality = "";
die "Syntax: \n\t\tperl $0 <fastq>\n\n" unless $ARGV[0];
$/ = "\@NS";
open( FQ, $ARGV[0]) || die "Can't open $ARGV[0] for $!\n";

while( <FQ> ) {
        chomp;
        if( $_ ){
        my @seq = split /\n/;
        my $seq_length = length $seq[1];
#       print "$seq_length\n";
        if ( $seq[1] =~ m/(^.*GTTCAGAGTTCTACAGTCCGACGATC)(.*?)(AACTGTAGGCACCATCAAT.*$)/ ) {
#		print "$1\t$2\t$3\n";
                my $head_length = length $1;
                my $tail_length = length $3;
		my $high_seq_length = $seq_length - $head_length - $tail_length;
		my $seq1 = substr( $seq[1], $head_length, $high_seq_length );
		my $seq3 = substr( $seq[3], $head_length, $high_seq_length );
			my $flag = length $seq1;
			if ( $flag > 15 ){
				print "\@NS$seq[0]\n$seq1\n$seq[2]\n$seq3\n"; 
                        }
	}

        elsif ( $seq[1] =~ m/(AACTGTAGGCACCATCAAT.*?$)/ ) {  							# Match only tail  && $seq[3] =~ m/(^[^#%&']+)/
#		print "$1\n";
		my $tail_length = length $1;
		my $high_seq_length = $seq_length - $tail_length;
		my $seq1 = substr( $seq[1], 0, $high_seq_length );
                my $seq3 = substr( $seq[3], 0, $high_seq_length );
			my $flag = length $seq1;
#print "test\n";
			if ( $flag > 15 ){
		                print "\@NS$seq[0]\n$seq1\n$seq[2]\n$seq3\n";
         		}
	}

        elsif ( $seq[1] =~ m/(^.*?GTTCAGAGTTCTACAGTCCGACGATC)/ ) {						# Match only head   && $seq[3] =~ m/([^#%&']+$)/ 
#		print "$1\n";
		my $head_length = length $1;
		my $high_seq_length = $seq_length - $head_length;
		my $seq1 = substr( $seq[1], $head_length, $high_seq_length );
                my $seq3 = substr( $seq[3], $head_length, $high_seq_length );
			my $flag = length $seq1;	
			if ( $flag > 15 ){
				print "\@NS$seq[0]\n$seq1\n$seq[2]\n$seq3\n";
        	        }
	}

#        else { print "\n";}
	}
}

close FQ;
