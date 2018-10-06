use v6.c;

use Map::Agnostic:ver<0.0.1>:auth<cpan:ELIZABETH>;

role Map::Ordered:ver<0.0.1>:auth<cpan:ELIZABETH>
  does Map::Agnostic
{
    has str @!keys;
    has %!hash; #  handles <AT-KEY BIND-KEY>;  # not supported yet

#--- Mandatory method required by Map::Agnostic --------------------------------
    method INIT-KEY(\key, \value) {
        my str $key = key.Str;
        @!keys.push($key);
        %!hash.BIND-KEY($key,value);
    }
    method AT-KEY(\key)     { %!hash.AT-KEY(key)     }
    method EXISTS-KEY(\key) { %!hash.EXISTS-KEY(key) }

    method keys() { @!keys.List }

#---- Methods needed for consistency -------------------------------------------
    method gist() {
        '{' ~ self.pairs.map( *.gist).join(", ") ~ '}'
    }

    method Str() {
        self.pairs.join(" ")
    }

    method perl() {
        self.perlseen(self.^name, {
          ~ self.^name
          ~ '.new('
          ~ self.pairs.map({$_<>.perl}).join(',')
          ~ ')'
        })
    }

#---- Optional methods for performance -----------------------------------------
    method values()   { @!keys.map: { %!hash{$_} } }
    method pairs()    { @!keys.map: { $_ => %!hash{$_} } }
}

=begin pod

=head1 NAME

Map::Ordered - role for ordered Maps

=head1 SYNOPSIS

  use Map::Ordered;

  my %m is Map::Ordered = a => 42, b => 666;

=head1 DESCRIPTION

Exports a C<Map::Ordered> role that can be used to indicate the implementation
of a C<Map> in which the keys are ordered the way the C<Map> got initialized.

Since C<Map::Ordered> is a role, you can also use it as a base for creating
your own custom implementations of maps.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Map-Ordered .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: ft=perl6 expandtab sw=4
