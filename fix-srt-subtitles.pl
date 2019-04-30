#!/usr/bin/perl
use strict;
use warnings;
use Carp;
use Time::Piece;

sub addtime {
  my $time = shift;
  my $seconds = shift;
  return $time += $seconds;
}

sub reducetime {
  my $time = shift;
  my $seconds = shift;
  return $time -= $seconds;
}

sub fixtime {
  my $time = shift;
  my $direction = shift;
  my $seconds = shift;
  my $newtime;
  print "$time -> ";
  my $t1 = Time::Piece->strptime( $time, '%H:%M:%S' );
  if ($direction eq "+") { $newtime = addtime($t1, $seconds); }
  else { $newtime = reducetime($t1, $seconds); }
  print $newtime->hms;
  print "\n";
  return $newtime->hms;
}

my $usage = "USAGE:
$0 source destination modifier seconds

source and destination should be input and output srt subtitles files
modifier should be either + or -
seconds should be the number of seconds to add or subtract
";
if (@ARGV != 4) { croak $usage; }

my $sourceFilename = $ARGV[0];
my $outputFilename = $ARGV[1];
my $fixDirection = $ARGV[2];
my $fixSeconds = $ARGV[3];

open (my $sourcefh, "<", $sourceFilename)
  or die "Can't open < '$sourceFilename': $!";
open (my $outputfh, ">", $outputFilename)
  or die "Can't open > '$outputFilename': $!";
while (my $line = <$sourcefh>) {
  chomp($line);
  if ($line =~ /^(\d{2}:\d{2}:\d{2})(,\d{3} --> )(\d{2}:\d{2}:\d{2})(,\d{3})/) {
    my $first = $1;
    my $mid = $2;
    my $second = $3;
    my $end = $4;
    my $newfirst = fixtime($first, $fixDirection, $fixSeconds);
    my $newsecond = fixtime($second, $fixDirection, $fixSeconds);
    print $outputfh "$newfirst$mid$newsecond$end\n";
  }
  else {
    print $outputfh "$line\n";
  }
}
