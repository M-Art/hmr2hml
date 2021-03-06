:- ensure_loaded(operators).
:- ensure_loaded(fwrite).
:- ensure_loaded(dictionary).
:- ensure_loaded(types).
:- ensure_loaded(attributes).
:- ensure_loaded(xtt).

hmr2hml(InputFileName, OutputFileName) :-
    consult(InputFileName),
    fopen OutputFileName,

    xml,
    hml_tag_open,
    --> types,
    --> attributes,
    --> xtt,
    hml_tag_close,
    
    fclose.

xml :-
    fwriteln '<?xml version="1.0" encoding="UTF-8"?>'.

hml_tag_open :-
    fwriteln '<hml version="2.0">'.

hml_tag_close :-
    fwriteln '</hml>'.

