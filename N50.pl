#!/usr/bin/perl
# Usage: calculate basic information of an assembled genome, like N50, longest, contig number

use strict;
use warnings;

my $i = 0;
my @contig_length;
my $genome_size = 0;
my $sum01 = 0;

my $assemble_fa = shift;
die "\n\tperl $0 <assemble_result>\n\n" unless ( $assemble_fa );
open (AF, $assemble_fa) || die "Can't open file $assemble_fa for $!";
$/ = ">";
while ( <AF> ) {
        chomp;
        if ( $_ ){
#        $_ =~ s/^.*\n?//g;
#        $_ =~ s/\n//g;
	my @a = split /\n/;
	shift @a;
	my $seq = join("", @a);
 	$contig_length[$i] = length $seq;
        $genome_size += $contig_length[$i];
        $i++;
        }
}
close ( AF );

# print "@contig_length\n";
print "The contigs number is: $i\n";

my @seq_length_sorted = sort { $b <=> $a } @contig_length;

# print "@seq_length_sorted\n";

print "The longest contig is: $seq_length_sorted[0]\n";
print "The genome size is: $genome_size bp\n";

for ( my $k = 0; $k < $#seq_length_sorted; $k++ ){
        $sum01 += $seq_length_sorted[$k];
        if ( $sum01 >= $genome_size/2 ){
                print "The N5O of the assemble is:$seq_length_sorted[$k] bp\n";
                last;
                }
        }
