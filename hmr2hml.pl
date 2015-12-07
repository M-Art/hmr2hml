:- ensure_loaded(operators).

:- dynamic(file_stream/1).
:- dynamic(intent/1).

hmr2hml(InputFileName, OutputFileName) :-
    consult(InputFileName),

    open(OutputFileName, write, FileStream),

    assert(file_stream(FileStream)),
    assert(intent(0)),

    xml,
    hml_tag_open,
    hml_tag_close,
    
    close(FileStream).

xml :-
    writeln('<?xml version="1.0" encoding="UTF-8"?>').

hml_tag_open :-
    writeln('<hml version="2.0">').

hml_tag_close :-
    writeln('</hml>').

writeln(String) :-
    file_stream(FileStream),
    intent_string(IntentString),

    write(FileStream, IntentString),
    write(FileStream, String),
    write(FileStream, '\n').

add_intent :-
    intent(Intent),
    NewIntent is Intent + 1,
    retractall(intent(_)),
    assert(intent(NewIntent)).

remove_intent :-
    intent(Intent),
    Intent > 0,
    NewIntent is Intent - 1,
    retractall(intent(_)),
    assert(intent(NewIntent)).
remove_intent.

intent_string(String) :-
    intent(Intent),
    intent_string(Intent, String).
intent_string(0, '').
intent_string(Intent, String) :-
    Intent > 0,
    NewIntent is Intent - 1,
    intent_string(NewIntent, AccumulatedIntentString),
    string_concat(AccumulatedIntentString, '    ', String).

