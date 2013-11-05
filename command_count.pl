#!/usr/bin/perl
# This script give you statistics on ran commands
# it parses your ~/.bash_history file and will report
# on individual commands as well as piped commands

open(FILE,"<",glob("~/.bash_history")) or die ("Cannot open $home/.bash_history\n");

%map = ();
while(<FILE>){
	chomp;

	($_ =~ m/^([^\s]+).*$/);

	if(exists($map{$1})){
		$map{$1} += 1;
	}else{
		$map{$1} = 1;
	}
	my @matches = ($_ =~ /\|\s*([^\s]+)/g);
	if(scalar(@matches)){
		foreach my $command (@matches){
			if(exists($map{$command})){
				$map{$command} += 1;
			}else{
				$map{$command} = 1;
			}
		}
	}
}

foreach (sort { int($map{$b}) <=> int($map{$a}) } keys %map) 
{
	    print "$map{$_}\t$_\n";
}
