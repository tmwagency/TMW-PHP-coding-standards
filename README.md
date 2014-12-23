TMW-PHP-coding-standards
========================

TMW PHP coding standards

Use the XML as a source document, and convert to a format with the following syntax:

```bash
xsltproc md.xsl php\ coding\ standards.xml
```

And just exchange the `.xsl` for the specific format translation you require.

To have this saved to a document just pipe it into a file on the command line:

```bash
xsltproc md.xsl php\ coding\ standards.xml > output.md
```
