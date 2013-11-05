#!/usr/bin/perl
# This script parses the running dmesg queue
# It can then use normal perl regexs to filter and
# run specalized commands.
# This is used as a hack when udev events do not work
# correctly. eg the thinkpad undock shows up in dmesg,
# but not as a udev event

use strict;
use warnings;


my $PID_FILE="/tmp/dmesg_parser_pid";
my $FIFO_FILE="/tmp/dmesg_parser_fifo";

my $CMD="stdbuf -i 100 -o L -e L /usr/bin/dmesg -w > $FIFO_FILE";

if( -e $PID_FILE ){
	print "An instance is already running\n";
	exit 1;
}

open(PID,">",$PID_FILE) or die $!;
print PID "0";
close PID;

if(! -e $FIFO_FILE){
	my $output=`mkfifo $FIFO_FILE`;
}

my $start_time = int(`date +%s`);

my $pid = fork();
if($pid) {
	$SIG{'INT'} = 'CLEANUP';
	$SIG{__DIE__} = 'CLEANUP';
	print "Running: ".split(/ /,$CMD);
	system $CMD;
}elsif($pid == 0){
	open(FIFO,"<",$FIFO_FILE) or die $!;
	$SIG{'INT'} = 'CLEANUP';
	$SIG{__DIE__} = 'CLEANUP';
	while(<FIFO>){
		if($_ =~ "thinkpad_acpi: undocked"){
			my $now = int(`date +%s`);
			if($now - $start_time > 5){
				my $output = `/usr/bin/xscreensaver-command -lock`;
			}
		}
		elsif($_ =~ "thinkpad_acpi: docked"){
			my $now = int(`date +%s`);
			if($now - $start_time > 5){
				my $output = `/usr/local/src/docked.sh`;
			}
		}
		elsif($_ =~ m/UFW BLOCK.*SRC=([^\s]_).*DST=([^\s]_).*PROTO=([^\s]+).*SPT=([^\s]+).*DPT=([^\s]+).*/){
			my $cmd = "notify-send 'BLOCK: $1:$3-> $2:$4'";
			my $results = `$cmd`;
		}
	}
}

$SIG{'INT'} = 'CLEANUP';
$SIG{__DIE__} = 'CLEANUP';


sub CLEANUP {
	unlink($PID_FILE);
	exit(0);
}
