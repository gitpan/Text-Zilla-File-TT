use strict;
use warnings;
use Test::More;
use Test::Dirs;
use FindBin qw($Bin);

use FindBin qw($Bin);
use lib "$Bin/lib";

use TZFTT03Dir;
use TZFTT03File;

my $root = TZFTT03Dir->new(
	tzil_stash => {
		myvar => 1
	}
);
isa_ok($root, 'TZFTT03Dir');

my $testfile = TZFTT03File->new();
isa_ok($testfile, 'TZFTT03File');

$root->tzil_set_entry('test',$testfile);

my $subdir = TZFTT03Dir->new;

my $subdir_testfile = TZFTT03File->new();
isa_ok($subdir_testfile, 'TZFTT03File');

$subdir->tzil_set_entry('test',$subdir_testfile);
$root->tzil_set_entry('subdir',$subdir);

my $dir = File::Temp->newdir();
$root->tzil_to($dir);

is_dir($dir, $Bin.'/result-03', 'Checking resulting directory', [], 'verbose' );

done_testing;
