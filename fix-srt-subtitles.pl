#/usr/bin/perl
use strict;
use warnings;
use Time::Piece;

sub fixtime {
  my $time = shift;
  print "$time -> ";
  my $t1 = Time::Piece->strptime( $time, '%H:%M:%S' );
  # subtract 12 seconds
  $t1 -= 12;
  print $t1->hms;
  print "\n";
  return $t1->hms;
}

open (INFILE, "LaPiovraS01E01_eng.srt");
open (OUTFILE, ">LaPiovraS01E01.srt");
while (my $line = <INFILE>) {
  chomp($line);
  if ($line =~ /^(\d{2}:\d{2}:\d{2})(,\d{3} --> )(\d{2}:\d{2}:\d{2})(,\d{3})/) {
    my $first = $1;
    my $mid = $2;
    my $second = $3;
    my $end = $4;
    my $newfirst = fixtime($first);
    my $newsecond = fixtime($second);
    print OUTFILE "$newfirst$mid$newsecond$end\n";
  }
  else {
    print OUTFILE "$line\n";
  }
}

