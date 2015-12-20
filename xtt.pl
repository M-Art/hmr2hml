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
    table_rule_decisions(Decisions),
    table_rule_link(Link),
    !.
table_rule(TableName, Num) :-
    xrule TableName/Num : Conditions ==> Decisions,
    table_rule_conditions(Conditions),
    table_rule_decisions(Decisions),
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

table_rule_link(Link/_) :-
    fwriteln '<link>',
    --> fwriteln '<tabref ref="tab_~w"/>' ~ Link,
    fwriteln '</link>',
    !.
table_rule_link(Link) :-
    fwriteln '<link>',
    --> fwriteln '<tabref ref="tab_~w"/>' ~ Link,
    fwriteln '</link>'.

table_rule_decisions(Decisions) :-
    fwriteln '<decision>',
    --> table_rule_decision(Decisions),
    fwriteln '</decision>'.

table_rule_decision([]).
table_rule_decision([Decision|Decisions]) :-
    table_rule_decision_trans(Decision),
    table_rule_decision(Decisions).

table_rule_decision_trans(Attr set Value) :-
    fwriteln '<trans>',
    --> fwriteln '<attref ref="attr_~w"/>' ~ Attr,
    --> table_rule_decision_trans_value(Value),
    fwriteln '</trans>'.

table_rule_decision_trans_value(Value) :-
    atom(Value),
    fwriteln '<set>',
    --> fwriteln '<value is="~w"/>' ~ Value,
    fwriteln '</set>',
    !.
table_rule_decision_trans_value(Value) :-
    table_rule_decision_trans_value_expr(Value).

table_rule_decision_trans_value_expr(Value) :-
    table_rule_decision_trans_value_expr_binary(Value, Name, Val1, Val2),
    fwriteln '<expr name="~w">' ~ Name,
    --> table_rule_decision_trans_value_expr(Val1),
    --> table_rule_decision_trans_value_expr(Val2),
    fwriteln '</expr>',
    !.
table_rule_decision_trans_value_expr(Value) :-
    number(Value),
    fwriteln '<value is="~w"/>' ~ Value,
    !.
table_rule_decision_trans_value_expr(Value) :-
    fwriteln '<attref ref="attr_~w"/>' ~ Value,
    !.

table_rule_decision_trans_value_expr_binary(Val1 + Val2, add, Val1, Val2).
table_rule_decision_trans_value_expr_binary(Val1 - Val2, sub, Val1, Val2).
table_rule_decision_trans_value_expr_binary(Val1 * Val2, mul, Val1, Val2).
table_rule_decision_trans_value_expr_binary(Val1 / Val2, div, Val1, Val2).

