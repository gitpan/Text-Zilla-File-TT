use strict;
use warnings;
use Test::More;

use FindBin qw($Bin);
use lib "$Bin/lib";

use TZFTT01File;

my $file = TZFTT01File->new;
isa_ok($file, 'TZFTT01File');
is($file->tzil_content, 'This is a test', 'Checking content of TZFTT01File');

done_testing;
