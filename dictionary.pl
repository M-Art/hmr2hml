:- op(900, xfx, forKey).
:- op(850, xfx, inDict).

forKey(Value, Key inDict Dict) :-
    member(Key : Value, Dict).

