#TMW PHP Coding Standard Rules for CodeSniffer

The contained ruleset.xml and Sniffs directory contain rules for CodeSniffer that conform to the TMW PHP Coding Standards. These rules should be run before committing code to any TMW repository.

##Installation
You should check out the TMW directory to a location on your local system, e.g.:

```
/home/username/coding_standards/TMW/
```

##Running the rules
From within your terminal, before committing, run the following (this assumes you have CodeSniffer installed):

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml /directory/of/your/project /another/directory /etc
```

Or, if you prefer, set this as the default coding standard with the following (*note: you will need root permissions to do this*):

```shell
phpcs --config-set default_standard /home/username/coding_standards/TMW/ruleset.xml
```

Then you can run the rules with just a simple:

```shell
phpcs /directory/of/your/project /another/directory /etc
```

*Note that you can use shell expansion here. The following would test all PHP files within `laravel/app/controllers/` and `laravel/app/models/`:*

```shell
phpcs laravel/app/{controllers,models}
```

##Ignoring specific files

You can ignore specific files from being checked (such as ones that are part of third-party modules) with the `--ignore` parameter, which takes a comma-delimited list of paths (the * wildcard is accepted). So, for example, to check all the PHP code in a Laravel app, but exclude a Twitter library, you might use the following on the command line:

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml --ignore=*/TwitterOAuth.php laravel/app/{models,controllers}
```

##Only show errors not warnings

If you wish to hide warnings from the report, then you can use the `-n` parameter:

```shell
phpcs --standard=/home/username/coding_standards/TMW/ruleset.xml -n --ignore=*/TwitterOAuth.php laravel/app/{models,controllers}
```

##Change the report type
By default, CodeSniffer will produce a full report. You can change the type of report by using the `report` argument:

```shell
phpcs report=csv /laravel/app/{controllers,models}
```

There are several types of reports:

* `full` - the default which contains full information on each issue found and the file it was found within
* `xml` - outputs the report in XML format
* `checkstyle` - an alternative XML format
* `json` - outputs the report in JSON format
* `csv` outputs the report in CSV format
* `source` - outputs a list of issues with the number of occurences and which rule the issues were triggered from, e.g. a PEAR rule, or TMW rule
* `notifysend` - the issues found won't output to standard output but instead will use a system notification
* `summary` - a simple summary of number of issues found per file
* `diff` - a list of issues and the diff commands that can be run to fix them
* `svnblame`/`gitblame` - a report of issues, with each one attributed to a user who committed the code wherever an issue exists in committed code


