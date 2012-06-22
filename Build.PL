use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'perlsecret',
    license           => 'perl',
    dist_author       => 'Philippe Bruhat (BooK) <book@cpan.org>',
    dist_version_from => 'lib/perlsecret.pm',
    build_requires    => { 'Test::More' => '0.94', },
    requires          => { },
    meta_merge => {
        resources =>
            { repository => 'http://github.com/book/perlsecret', },
    },
    add_to_cleanup => ['perlsecret-*'],
);

$builder->create_build_script();
