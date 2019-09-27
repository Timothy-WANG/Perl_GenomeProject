#!/usr/bin/perl
# Usage: calculate basic information of an assembled genome, like N50, longest, contig number

use strict;
use warnings;

my $i = 0;
my @seq_length;
my $genome_size = 0;

my $genome_fa = shift;
die "\n\tperl $0 <genome.fasta>\n\n" unless ( $genome_fa );
open (GF, $genome_fa) || die "Can't open file $genome_fa for $!";
$/ = ">";
while ( <GF> ) {
        chomp;
        if ( $_ ){
	my @a = split /\n/;
	my $ori_id = shift @a;
	my $seq = join("", @a);
 	$seq_length[$i] = length $seq;
        $genome_size += $seq_length[$i];
        $i++;
        }
}
close ( GF );

print "\tThe genome size is:\t\t$genome_size bp\n";

my ( $number, $longest, $N50 ) = &report_length ( @seq_length );
print "\n\tThe sequence number is:\t\t$number\n";
print "\tThe longest sequence is:\t$longest bp\n";
print "\tThe N5O of the assemble is:\t$N50 bp\n\n";

sub report_length {
	my @array = @_ ;
	my $number = scalar @array;
	my $sum01 = 0;
	my @seq_length_sorted = sort { $b <=> $a } @array;

	for ( my $k = 0; $k < $#seq_length_sorted; $k++ ){
        	$sum01 += $seq_length_sorted[$k];
	        if ( $sum01 >= $genome_size/2 ){
			return ( $number, $seq_length_sorted[0], $seq_length_sorted[$k]);
                	last;
                }
        }
}
