<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="XSLT-compat"/>

<xsl:template match="/">
<html>
	<head>
		<title><xsl:apply-templates select="/coding_standards/title" mode="title"/></title>
		<!-- add any css and js includes as necessary here, they must be xml-compatible -->
	</head>
	<body>
		<xsl:apply-templates/>
	</body>
</html>
</xsl:template>

<xsl:template match="/coding_standards">
	<h1><xsl:apply-templates select="title" mode="title"/></h1>
	
	<xsl:apply-templates select="title" mode="toc"/>
	<xsl:apply-templates select="section" mode="toc"/>
	
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<section>
		<xsl:variable name="section_title"><xsl:value-of select="translate(@title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
		<h1 id="{$section_title}"><xsl:value-of select="@title"/></h1>
		
		<xsl:apply-templates mode="content"/>
	</section>
</xsl:template>

<xsl:template match="h2" mode="content">
	<xsl:variable name="h2"><xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
	<h2 id="{$h2}"><xsl:value-of select="text()"/></h2>
</xsl:template>

<xsl:template match="h3" mode="content">
	<xsl:variable name="h3"><xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
	<h3 id="{$h3}"><xsl:value-of select="text()"/></h3>
</xsl:template>

<xsl:template match="p" mode="content">
	<p><xsl:apply-templates mode="content"/></p>
</xsl:template>

<xsl:template match="code" mode="content">
	<xsl:choose>
		<xsl:when test="@style = 'block'">
			<pre>
			<xsl:value-of select="text()" disable-output-escaping="yes"/>
			</pre>
		</xsl:when>
		<xsl:otherwise>
			<code><xsl:value-of select="text()" disable-output-escaping="yes"/></code>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="ul" mode="content">
	<ul><xsl:apply-templates select="li" mode="content"/></ul>
</xsl:template>

<xsl:template match="li" mode="content">
	<li><xsl:value-of select="text()"/></li>
</xsl:template>

<xsl:template match="a" mode="content">
	<a href="{@href}" target="_blank"><xsl:value-of select="text()"/></a>
</xsl:template>

<xsl:template match="em" mode="content">
	<em><xsl:value-of select="text()"/></em>
</xsl:template>

<xsl:template match="strong" mode="content">
	<strong><xsl:value-of select="text()"/></strong>
</xsl:template>



<!-- main title -->
<xsl:template match="title" mode="title">
	<xsl:value-of select="text()"/>
</xsl:template>

<!-- table of content templates -->
<xsl:template match="title" mode="toc">
	<h2>Contents</h2>
</xsl:template>

<xsl:template match="section" mode="toc">
	<ul>
		<li><a href="#{translate(@title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')}"><xsl:value-of select="@title"/></a>
			<ul>
				<xsl:apply-templates select="h2" mode="toc"/>
				<ul><xsl:apply-templates select="h3" mode="toc"/></ul>
			</ul>
		</li>
	</ul>
</xsl:template>

<xsl:template match="h2" mode="toc">
	<li><a href="#{translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')}"><xsl:value-of select="text()"/></a></li>
</xsl:template>

<xsl:template match="h3" mode="toc">
	<li><a href="#{translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')}"><xsl:value-of select="text()"/></a></li>
</xsl:template>

</xsl:stylesheet>
