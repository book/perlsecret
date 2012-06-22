use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'perlsecret',
    AUTHOR              => 'Philippe Bruhat (BooK) <book@cpan.org>',
    VERSION_FROM        => 'lib/perlsecret.pm',
    ABSTRACT            => 'Perl secret operators and constant',
    PL_FILES            => {},
    BUILD_REQUIRES => {
        'Test::More' => 0.94,
    },
    PREREQ_PM => { },
    META_MERGE => {
        resources => {
            repository => 'http://github.com/book/perlsecret',
        },
    },
    LICENSE             => 'perl',
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'perlsecret-*' },
);
