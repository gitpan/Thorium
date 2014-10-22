package Thorium::BuildConf::Roles::UI::FileSelect;
{
  $Thorium::BuildConf::Roles::UI::FileSelect::VERSION = '0.503';
}

# ABSTRACT: dialog file select role

use Thorium::Protection;

use Moose::Role;

has 'ui_type' => (
    'isa'     => 'Str',
    'is'      => 'ro',
    'default' => 'FileSelect'
);

no Moose::Role;

1;

__END__
=pod

=head1 NAME

Thorium::BuildConf::Roles::UI::FileSelect - dialog file select role

=head1 VERSION

version 0.503

=head1 AUTHOR

Adam Flott <adam@npjh.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Adam Flott <adam@npjh.com>, CIDC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

