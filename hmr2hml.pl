:- ensure_loaded(operators).

:- dynamic(file_stream/1).
:- dynamic(intent/1).
:- op(900, fx, writeln).
:- op(910, fy, -->).
:- op(850, xfy, ~).

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
    writeln '<?xml version="1.0" encoding="UTF-8"?>'.

hml_tag_open :-
    writeln '<hml version="2.0">'.

hml_tag_close :-
    writeln '</hml>'.

writeln(Format ~ Arguments) :-
    writeln_argument_list(Arguments, ArgumentList),
    format(atom(String), Format, ArgumentList),
    writeln String.
writeln(String) :-
    file_stream(FileStream),
    intent_string(IntentString),

    write(FileStream, IntentString),
    write(FileStream, String),
    write(FileStream, '\n').

writeln_argument_list(Argument ~ Arguments, [Argument|ArgumentList]) :-
    writeln_argument_list(Arguments, ArgumentList), !.
writeln_argument_list(Argument, [Argument]).

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

-->(Goal) :-
    add_intent,
    call(Goal),
    remove_intent.
