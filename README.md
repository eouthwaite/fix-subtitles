# fix-subtitles

This is a Perl script to fix srt subtitles

Basically, I found an srt format subtitles file which were taken from a DVD rip of a TV show - dialogue in the version of the show on YouTube started 12 seconds earlier, so this script currently takes 12 seconds off.

USAGE:

    fix-srt-subtitles.pl source destination modifier seconds

eg:

    perl fix-srt-subtitles.pl LaPiovraS01E01_eng.srt LaPiovraS01E01.srt - 12

source and destination should be input and output srt subtitles files
modifier should be either + or -
seconds should be the number of seconds to add or subtract
