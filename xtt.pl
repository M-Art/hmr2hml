xtt :-
    fwriteln '<xtt>',
    --> table,
    fwriteln '</xtt>'.

table :-
    xschm TableName : _ ==> _,
    fwriteln '<table id="tab_~w" name="~w">' ~ TableName ~ TableName,
    --> table_schema(TableName),
    --> table_rules(TableName),
    fwriteln '</table>',
    fail.
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

table_rules(TableName) :-
    xrule TableName/Num : _ ==> _,
    fwriteln '<rule id="rul_~w_~w">' ~ TableName ~ Num,
    --> table_rule(TableName, Num),
    fwriteln '</rule>',
    fail.
table_rules(_).

table_rule(TableName, Num) :-
    xrule TableName/Num : Conditions ==> Decisions : Link,
    table_rule_conditions(Conditions),
    table_rule_link(Link),
    !.
table_rule(TableName, Num) :-
    xrule TableName/Num : Conditions ==> Decisions,
    table_rule_conditions(Conditions),
    !.

table_rule_conditions(Conditions) :-
    fwriteln '<condition>',
    --> table_rule_condition(Conditions),
    fwriteln '</condition>'.

table_rule_condition([]).
table_rule_condition([Condition|Conditions]) :-
    table_rule_condition_relation(Condition),
    table_rule_condition(Conditions).

table_rule_condition_relation(Condition) :-
    Condition =.. [Relation, Name, Value],
    fwriteln '<relation name="~w">' ~ Relation,
    --> fwriteln '<attref ref="attr_~w"/>' ~ Name,
    --> fwriteln '<set>',
    --> --> table_rule_condition_relation_set(Value),
    --> fwriteln '</set>',
    fwriteln '</relation>'.

table_rule_condition_relation_set([]).
table_rule_condition_relation_set([L to H]) :-
    fwriteln '<value from="~w" to="~w"/>' ~ L ~ H,
    !.
table_rule_condition_relation_set([Value|Values]) :-
    table_rule_condition_relation_set(Value),
    table_rule_condition_relation_set(Values),
    !.
table_rule_condition_relation_set(Value) :-
    fwriteln '<value is="~w"/>' ~ Value.

table_rule_link(Link) :-
    fwriteln '<link>',
    --> fwriteln '<tabref ref="tab_~w"/>' ~ Link,
    fwriteln '</link>'.
