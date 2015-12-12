xtt :-
    fwriteln '<xtt>',
    --> table,
    fwriteln '</xtt>'.

table :-
    xschm TableName : _ ==> _,
    fwriteln '<table id="tab_~w" name="~w">' ~ TableName ~ TableName,
    --> table_schema(TableName),
    fwriteln '</table>',
    !.
table.

table_schema(TableName) :-
    xschm TableName : Preconditions ==> Conclusions,
    fwriteln '<schm>',
    --> fwriteln '<precondition>',
    --> --> table_schema_precondition(Preconditions),
    --> fwriteln '</precondition>',
    --> fwriteln '<conclusion>',
    --> --> table_schema_conclusion(Conclusions),
    --> fwriteln '</conclusion>',
    fwriteln '</schm>'.

table_schema_precondition([]).
table_schema_precondition([Precondition|Preconditions]) :-
    fwriteln '<attref ref="attr_~w"/>' ~ Precondition.

table_schema_conclusion([Conclusion|Conclusions]) :-
    fwriteln '<attref ref="attr_~w"/>' ~ Conclusion.

