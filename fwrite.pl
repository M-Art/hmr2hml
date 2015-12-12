:- dynamic(file_stream/1).
:- dynamic(intent/1).
:- dynamic(intent_factor/1).

:- op(900, fx, fopen).
:- op(900, fx, fwrite).
:- op(900, fx, fwriteln).
:- op(910, fy, -->).
:- op(850, xfy, ~).

fopen(FileName) :-
    open(FileName, write, FileStream),

    assert(file_stream(FileStream)),
    assert(intent(0)),
    assert(intent_factor(1)).

fclose :-
    file_stream(FileStream),
    close(FileStream).

fwrite(Format ~ Arguments) :-
    writeln_argument_list(Arguments, ArgumentList),
    format(atom(String), Format, ArgumentList),
    fwrite String, !.
fwrite(String) :-
    file_stream(FileStream),
    intent_string(IntentString),

    write(FileStream, IntentString),
    write(FileStream, String),
    retractall(intent_factor(_)),
    assert(intent_factor(0)).

fwriteln(Content) :-
    file_stream(FileStream),
    fwrite(Content),
    write(FileStream, '\n'),
    retractall(intent_factor(_)),
    assert(intent_factor(1)).

-->(Goal) :-
    add_intent,
    call(Goal),
    remove_intent.

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
    NewIntent is Intent - 1,
    retractall(intent(_)),
    assert(intent(NewIntent)).

intent_string(String) :-
    intent(Intent),
    intent_factor(IntentFactor),
    IntentWithFactor is Intent * IntentFactor,
    intent_string(IntentWithFactor,  String).
intent_string(0, '').
intent_string(Intent, String) :-
    Intent > 0,
    NewIntent is Intent - 1,
    intent_string(NewIntent, AccumulatedIntentString),
    string_concat(AccumulatedIntentString, '    ', String).

