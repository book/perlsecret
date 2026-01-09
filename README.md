# Perl Secret Operators and Constants

Perl has a long tradition of giving nicknames to some of its operators
(possibly a form of Huffmanisation). These nicknames are based on the
appearance of the operator, rather than its function.
The well-known examples are the "diamond operator" (`<>`) and the "spaceship
operator" (`<=>`).

The Perl "secret operators" have been discovered (or created) by Perl
obfuscators and golfers, usually when looking for a shorter way to
perform a given operation.

Secret operators are not actually secret, and they are not actually
operators either. The perl parser does not specifically recognise them,
and no one is trying to hide them from you. They are like operators
in the sense that these Perl programmers see them often enough to
recognize them without thinking about their smaller parts, and eventually
add them to their toolbox. And they are like secrets in the sense that
they have to be discovered by their future user (or be transmitted by
a fellow programmer), because they are not explicitly documented.

Because secret operators are not operators they don't have real names,
and so they need nicknames. Like the above Perl operators, their name
is usually related to their shape.

The term "secret operator" was probably coined by Abigail in a
comp.lang.perl.misc post in January 2003.

This manual page describes and explains the main Perl secret operators.

# Author

This documentation is the work of Philippe Bruhat (BooK),
supported by many other enthusiasts. See the ACKNOWLEDGMENTS
section for a (hopefully) complete list.

# Copyright

Copyright 2010-2026 Philippe Bruhat (BooK).

# License

This documentation is free; you can redistribute it and/or modify it
under the same terms as Perl itself.

