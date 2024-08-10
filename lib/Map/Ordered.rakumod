use v6.c;

use Map::Agnostic:ver<0.0.10>:auth<zef:lizmat>;

role Map::Ordered does Map::Agnostic {
    has %!indices;  # handles <EXISTS-KEY>   # alas, not supported for role yet
    has Str @!keys;
    has Mu  @!values;

#--- Mandatory method required by Map::Agnostic --------------------------------
    method INIT-KEY(Str() $key, \value) {
        my int $index = @!values.elems;
        %!indices.BIND-KEY(  $key, $index);
        @!keys   .BIND-POS($index, $key);
        @!values .BIND-POS($index, value<>);
    }
    method AT-KEY(\key) {
        with %!indices.AT-KEY(key) {
            @!values.AT-POS($_)
        }
        else {
            Nil
        }
    }
    method EXISTS-KEY(\key) { %!indices.EXISTS-KEY(key) }

    method keys() { @!keys }

#---- Methods needed for consistency -------------------------------------------
    multi method gist(::?ROLE:D:) {
        '{' ~ self.pairs.map( *.gist).join(", ") ~ '}'
    }

    multi method Str(::?ROLE:D:) {
        self.pairs.join(" ")
    }

    multi method raku(::?ROLE:D:) {
        self.rakuseen(self.^name, {
          ~ self.^name
          ~ '.new('
          ~ self.pairs.map({$_<>.raku}).join(',')
          ~ ')'
        })
    }

#---- Optional methods for performance -----------------------------------------
    method values()   { @!values }
    method pairs() {
        @!keys.map: { Pair.new($_, @!values.AT-POS(%!indices.AT-KEY($_))) }
    }
}

=begin pod

=head1 NAME

Map::Ordered - role for ordered Maps

=head1 SYNOPSIS

=begin code :lang<raku>

use Map::Ordered;

my %m is Map::Ordered = a => 42, b => 666;

=end code

=head1 DESCRIPTION

Exports a C<Map::Ordered> role that can be used to indicate the implementation
of a C<Map> in which the keys are ordered the way the C<Map> got initialized.

Since C<Map::Ordered> is a role, you can also use it as a base for creating
your own custom implementations of maps.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Map-Ordered .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2021, 2023, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: ft=raku expandtab sw=4
