use strict;
use warnings;
use Test::More;

use FindBin qw($Bin);
use lib "$Bin/lib";

use TZFTT02File;

my $file = TZFTT02File->new;
isa_ok($file, 'TZFTT02File');
is($file->tzil_content, 'This is another test with a TZFTT02File', 'Checking content of TZFTT02File');

done_testing;
