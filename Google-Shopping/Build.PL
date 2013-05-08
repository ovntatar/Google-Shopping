use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Google::Shopping',
    license             => 'perl',
    dist_author         => q{Ovidiu Nita Tatar <ovn.tatar@gmail.com>},
    dist_version_from   => 'lib/Google/Shopping.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Google-Shopping-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
