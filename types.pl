types :-
    fwriteln '<types>',
    --> type,
    fwriteln '</types>'.

type :-
    xtype Dict,
    Name forKey name inDict Dict,
    Base forKey base inDict Dict,

    fwrite '<type id="tpe_~w" name="~w" base="~w"' ~ Name ~ Name ~ Base,
    type_length(Dict),
    type_scale(Dict),
    fwriteln '>',
    --> type_description(Dict),
    --> type_domain(Dict),
    fwriteln '</type>',
    fail.
type.

type_length(Dict) :-
    Length forKey length inDict Dict,
    fwrite ' length="~w"' ~ Length, !.
type_length(_).
type_scale(Dict) :-
    Scale forKey scale inDict Dict,
    fwrite ' scale="~w"' ~ Scale, !.
type_scale(_).

type_description(Dict) :-
    Desc forKey desc inDict Dict,
    fwriteln '<desc>~w</desc>' ~ Desc,
    !.
type_description(_).

type_domain(Dict) :-
    _ forKey domain inDict Dict,
    fwrite '<domain',
    type_domain_ordered(Dict),
    fwriteln '>',
    --> type_domain_value(Dict),
    fwriteln '</domain>',
    !.
type_domain(_).

type_domain_ordered(Dict) :-
    Ordered forKey ordered inDict Dict,
    fwrite ' ordered="~w"' ~ Ordered,
    !.
type_domain_ordered(_).

type_domain_value(Dict) :-
    Domain forKey domain inDict Dict,
    Domain = [L to H],
    fwriteln '<value from="~w" to="~w"/>' ~ L ~ H,
    !.
type_domain_value(Dict) :-
    Domain forKey domain inDict Dict,
    is_list(Domain),
    type_domain_value_list(Domain),
    !.
type_domain_value(_).

type_domain_value_list([]).
type_domain_value_list([Val/Num|ValueList]) :-
    !, fwriteln '<value is="~w" num="~w"/>' ~ Val ~ Num,
    type_domain_value_list(ValueList).
type_domain_value_list([Val|ValueList]) :-
    !, fwriteln '<value is="~w"/>' ~ Val,
    type_domain_value_list(ValueList).

