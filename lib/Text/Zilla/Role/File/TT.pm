package Text::Zilla::Role::File::TT;
BEGIN {
  $Text::Zilla::Role::File::TT::AUTHORITY = 'cpan:GETTY';
}
BEGIN {
  $Text::Zilla::Role::File::TT::VERSION = '0.001';
}
# ABSTRACT: Role for giving a file a Template-Toolkit template

use Moose::Role;

with qw(
	Text::Zilla::Role::File::Stash
);

use Template;

has tzil_tt => (
	isa => 'Template',
	is => 'rw',
	lazy_build => 1,
	builder => 'build_tzil_tt',
);

has tzil_extension => (
	isa => 'Str',
	is => 'rw',
	default => sub {'.tt'},
);

has tzil_config => (
	isa => 'HashRef',
	is => 'rw',
	default => sub {{}},
);

sub build_tzil_tt { Template->new(shift->tzil_config) }

has tzil_template => (
	is => 'rw',
	predicate => 'has_tzil_template',
	lazy_build => 1,
	builder => 'build_tzil_template',
);

sub tzil_template_filename {
	my ( $self ) = @_;
	my $ref = ref $self;
	$ref =~ s!::!/!g;
	return $ref.$self->tzil_extension;
}

sub build_tzil_template {
	my ( $self ) = @_;
	return $self->tzil_template_filename;
}

sub tzil_content {
	my ( $self ) = @_;
	my %stash = %{$self->tzil_stash};
	$stash{self} = $self;
	my $content;
	$self->tzil_tt->process($self->tzil_template, \%stash, \$content);
	return $content;
}

1;
__END__
=pod

=head1 NAME

Text::Zilla::Role::File::TT - Role for giving a file a Template-Toolkit template

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Torsten Raudssus.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

