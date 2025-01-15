use Map::Agnostic:ver<0.0.11+>:auth<zef:lizmat>;

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

# vim: expandtab shiftwidth=4
