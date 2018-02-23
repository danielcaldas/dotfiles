#!/usr/bin/perl

use warnings; # Semantic erros are caught by the compiler
use strict;
use utf8::all; # :: separator for perl, puts all entry stuff like files int utf8 encoding
               # known as "The Hammer"
use Data::Dumper;
use LWP::Simple;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;
use HTML::Element;
use Set::Object qw(set);

# Declare local variables in perl my $x;
# Declare global variables our $x;
# No types
my (%oco);
my ($c);
my $pm = qr{[[:upper:]]\w+};
# v1. my $np = qr{$pm( $pm)*};

my $prep = qr{d[eoa]s?};
my $np = qr{$pm( ($prep )?$pm)*};

# my ($a, $b); more then one we need ()
# Diamond operator: reads input and sends to somewhere else
while (<>) {
  # print $_ --> The thing, it holds stuff
  # if we print with no args, perl gets the value of the thing

  # \w = [a-zA-Z0-9_áã...]
  # \W = [^...above] -> The opposite of \w
  # =~ it means 'do match with'
  # Regex in perl are limited with /REGEX/
  # /g it means global match
  next if /^</;
  $_ =~ s/^\w+(-\w+)*//;
  while( /\w+(-\w+)*/g ) {
  	$oco{lc($&)}{$&}++;
  }
}

print Dumper(\%oco);

# After __END__ mark Perl does not process anymore
__END__
foreach my $p (sort{ mycompare($a, $b) } keys %oco) {
	print "$p: $oco{$p}\n";
}

sub mycompare{my($a, $b)=@_;
	if($oco{$a} < $oco{$b}) {return 1}
	if($oco{$a} > $oco{$b}) {return -1}
	return $a cmp $b;
}

$tree = HTML::TreeBuilder->new();
$site_content = get($url);
$tree->parse($site_content);

...

$tree = HTML::TreeBuilder::XPath->new();
$tree->parse($site_content);

my $title = $tree->look_down('_tag', 'h1');
my $author = $tree->findvalue('/html/body//div[@class="ArticleAuthor"]');
