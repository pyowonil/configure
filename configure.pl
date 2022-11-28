#!/usr/bin/perl
# file: configure.pl
# configure.pl makes a filename.ext from a filename.ext.template.
# (c.f. filename.ext <- ./configure.pl filename.ext.template)
# configure.pl just replaces {{variable name}} to value.
# (c.f. bar <- {{foo}} ; export foo=bar)
use strict;
use warnings;

sub main {
	my $template_path = $ARGV[0];
	die "usage: ./configure.pl <template path>" if not defined $template_path;

	if ($template_path !~ /\.template$/) {
		die "extension of template path ($template_path) is not template";
	}
	my $file_path = $template_path;
	$file_path =~ s/\.template//;

	print "template_path: $template_path\n";
	print "file_path: $file_path\n";

	my $error = 0;
	my $l = 0;
	my $text = "";
	open(TEMPLATE, '<', $template_path) || die "do not open file $template_path";
	while (my $line = <TEMPLATE>) {
		$l = $l + 1;
		while ($line =~ /\{\{([_a-zA-Z][_a-zA-Z0-9]*)\}\}/) {
			my $variable_name = $1;
			my $var = $ENV{$variable_name};
			if (not defined $var) {
				die "variable '$variable_name' is not defined";
			}
			print "$l >>> $line";
			$line =~ s/\{\{$variable_name\}\}/$var/g;
			print "$l <<< $line";
		}
		$text = $text.$line;
	}
	close(TEMPLATE);

	open(FILE, '>', $file_path) || die "do not open file $file_path";
	print FILE "$text";
	close(FILE);
}

main();
