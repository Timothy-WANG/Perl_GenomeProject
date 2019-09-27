#!/usr/bin/perl

# Usage: split the scaffold into contig

use strict;
use warnings;

my $k=1;
my $genome = shift;
die "\n\tperl $0 <genome>\n\n" unless $genome ;
$/ = ">";
open(GE,$genome) or die "Can't open for $!\n";
while(<GE>){
	chomp;
	if ($_){
		my @a = split /\n/;
		my $id = shift @a;
		my $seq = join("", @a);
		$seq =~ s/(N+)/&/g;
		my @b = split /&/, $seq;
		for(my $i=0; $i<=$#b; $i++){
			print ">C$k\n$b[$i]\n";
#			my $len = length $b[$i];
#			print "$len\n";
		#	if($len>=100){
			#print ">C$k\n$b[$i]\n";
			$k++;
		#	}
		}

	}
}
close GE;
