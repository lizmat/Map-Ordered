[![Actions Status](https://github.com/lizmat/Map-Ordered/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Map-Ordered/actions) [![Actions Status](https://github.com/lizmat/Map-Ordered/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Map-Ordered/actions) [![Actions Status](https://github.com/lizmat/Map-Ordered/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Map-Ordered/actions)

NAME
====

Map::Ordered - role for ordered Maps

SYNOPSIS
========

```raku
use Map::Ordered;

my %m is Map::Ordered = a => 42, b => 666;
```

DESCRIPTION
===========

Exports a `Map::Ordered` role that can be used to indicate the implementation of a `Map` in which the keys are ordered the way the `Map` got initialized.

Since `Map::Ordered` is a role, you can also use it as a base for creating your own custom implementations of maps.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Map-Ordered . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2021, 2023, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

