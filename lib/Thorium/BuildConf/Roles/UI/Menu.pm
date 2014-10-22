package Thorium::BuildConf::Roles::UI::Menu;
{
  $Thorium::BuildConf::Roles::UI::Menu::VERSION = '0.508';
}
BEGIN {
  $Thorium::BuildConf::Roles::UI::Menu::AUTHORITY = 'cpan:AFLOTT';
}

# ABSTRACT: dialog menu role

use Thorium::Protection;

use Moose::Role;

has 'ui_type' => (
    'isa'     => 'Str',
    'is'      => 'ro',
    'default' => 'Menu'
);

no Moose::Role;

1;

__END__
=pod

=head1 NAME

Thorium::BuildConf::Roles::UI::Menu - dialog menu role

=head1 VERSION

version 0.508

=head1 AUTHOR

Adam Flott <adam@npjh.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Adam Flott <adam@npjh.com>, CIDC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

