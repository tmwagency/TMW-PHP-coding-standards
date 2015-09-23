#TMW PHP Coding Standard Rules for CodeSniffer

The contained ruleset.xml and Sniffs directory contain rules for CodeSniffer that conform to the TMW PHP Coding Standards. These rules should be run before committing code to any TMW repository.

To run the rules, check out the TMW directory to a location on your local system, e.g.:

```
/home/username/coding_standards/TMW/
```

Then, from within your ternminal, before committing, run the following (this assumes you have CodeSniffer installed):

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml /directory/of/your/project
```
