<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>
<xsl:output omit-xml-declaration="yes"/>

<xsl:template match="/coding_standards">
	<xsl:apply-templates select="title" mode="title"/>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<xsl:text>&#xa;== </xsl:text>
	<xsl:value-of select="@title"/>
	<xsl:text> ==&#xa;</xsl:text>
		
	<xsl:apply-templates mode="content"/>
</xsl:template>

<xsl:template match="h2" mode="content">
	<xsl:text>&#xa;=== </xsl:text><xsl:value-of select="text()"/><xsl:text> ===</xsl:text>
</xsl:template>

<xsl:template match="h3" mode="content">
	<xsl:text>&#xa;==== </xsl:text><xsl:value-of select="text()"/><xsl:text> ====</xsl:text>
</xsl:template>

<xsl:template match="p" mode="content">
	<xsl:text>&#xa;</xsl:text>
	<xsl:apply-templates mode="content"/>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template match="code" mode="content">
	<xsl:choose>
		<xsl:when test="@style = 'block'">
			<xsl:text>&#xa;</xsl:text>
			<pre>
			<xsl:value-of select="text()" disable-output-escaping="yes"/>
			</pre>
			<xsl:text>&#xa;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<code><xsl:value-of select="text()" disable-output-escaping="yes"/></code>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>



<xsl:template match="ul" mode="content">
	<xsl:text>&#xa;</xsl:text>
	<xsl:apply-templates select="li" mode="content"/>
</xsl:template>

<xsl:template match="li" mode="content">
	<xsl:text>* </xsl:text><xsl:value-of select="text()"/>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template match="a" mode="content">
	<xsl:text>[</xsl:text><xsl:value-of select="@href"/>, <xsl:value-of select="text()"/><xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="em" mode="content">
	<em><xsl:value-of select="text()"/></em>
</xsl:template>

<xsl:template match="strong" mode="content">
	<strong><xsl:value-of select="text()"/></strong>
</xsl:template>


<!-- main title -->
<xsl:template match="title" mode="title">
	<xsl:text>= </xsl:text>
	<xsl:value-of select="text()"/>
	<xsl:text> =&#xa;</xsl:text>
</xsl:template>

</xsl:stylesheet>