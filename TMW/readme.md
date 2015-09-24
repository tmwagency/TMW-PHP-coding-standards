#TMW PHP Coding Standard Rules for CodeSniffer

The contained ruleset.xml and Sniffs directory contain rules for CodeSniffer that conform to the TMW PHP Coding Standards. These rules should be run before committing code to any TMW repository.

To run the rules, check out the TMW directory to a location on your local system, e.g.:

```
/home/username/coding_standards/TMW/
```

Then, from within your ternminal, before committing, run the following (this assumes you have CodeSniffer installed):

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml /directory/of/your/project /another/directory /etc
```

You can ignore specific files from being checked (such as ones that are part of third-party modules) with the `--ignore` parameter, which takes a comma-delimited list of paths (the * wildcard is accepted). So, for example, to check all the PHP code in a Laravel app, but exclude a Twitter library, you might use the following on the command line:

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml --ignore=*/TwitterOAuth.php laravel/app/{models,controllers}
```

If you wish to hide warnings from the report, then you can use the `-n` parameter:

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml -n --ignore=*/TwitterOAuth.php laravel/app/{models,controllers}
```
