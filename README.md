# hmr2hml

## Prerequisites

In order to use `hml2hmr`, you need to install Prolog interpreter `swipl`:

    apt-get install swi-prolog

## Usage

    ./hmr2hml <input_file> <output_file>

## Known issues

### All rules must be unified
The following example will **not** work:

    xrule 'Table1'/1: [a > 0] ==> [_] : 'Table2'

because the conclusion is not unified. The correct version is:

    xrule 'Table1'/1: [a > 0] ==> [a set a] : 'Table2'

### `rule->rule` links
All `rule->rule` links are interpreted as `rule->table` links. If you need this functionality, please report an `enhancement`.
