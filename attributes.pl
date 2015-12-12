attributes :-
    fwriteln '<attributes>',
    --> attribute,
    fwriteln '</attributes>'.

attribute :-
    xattr Dict,
    Name forKey name inDict Dict,
    Abbrev forKey abbrev inDict Dict,
    Class forKey class inDict Dict,
    Type forKey type inDict Dict,
    Comm forKey comm inDict Dict,
    attribute_comm(Comm, HmlComm),
    fwriteln '<attr id="attr_~w" type="tpe_~w" name="~w" abbrev="~w" class="~w" comm="~w"/>' ~ Name ~ Type ~ Name ~ Abbrev ~ Class ~ HmlComm,
    fail.
attribute.

attribute_comm(inter, io) :- !.
attribute_comm(Comm, Comm).
