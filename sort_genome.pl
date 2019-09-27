#!/usr/bin/perl

# Usage: format the genome list from large length to small

use strict;
use warnings;

my %hash;
my $genome = shift;
die "\n\tperl $0 <genome>\n\n" unless $genome;
$/ = ">";
open ( GE, $genome ) || die "Can't open $genome for $!\n";

while( <GE> ){
	chomp;
	if($_){
		my @a = split /\n/;
		shift @a;
		my $seq = join "", @a;
		my $len = length $seq;
		if ( not exists $hash{$len} ) {
			$hash{$len} = $seq;
			}
		else {
			my $r = rand(1);
			$len = $len + $r;
			$hash{$len} = $seq
		}
		
		}
	}
close GE;
# print scalar keys %hash;

my $n = 1;
foreach my $a ( sort { $b <=> $a } keys %hash ){
	print ">Scaffold$n\n$hash{$a}\n";
	$n++
	}
