use Test::More tests => 1 + 3;
BEGIN {
    use_ok('Text::Outdent', qw/
        outdent
    /);
}

###############################################################################

use strict;

sub f { my ($str) = @_; $str =~ tr/./ /; return $str }
sub g { my ($str) = @_; $str =~ tr/ /./; return $str }

sub isg {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    is(g($_[0]), g($_[1]), $_[2]);
}

my ($in, $out);

($in, $out) = (<<'_IN_', <<'_OUT_');
..this
......is
......a
....
..string
......that
....
_IN_
this
....is
....a
....
string
....that
....
_OUT_

isg(outdent(f($in)), f($out));
isg(outdent(f("\n$in\n")), f("\n$out\n"));
isg(outdent(f(".\n$in\n")), f(".\n$out\n"));
