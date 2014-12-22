<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>

<xsl:template match="/coding_standards">
	<xsl:apply-templates select="title" mode="title"/>
	<xsl:apply-templates select="title" mode="toc"/>
	<xsl:apply-templates select="section" mode="toc"/>
	<xsl:text>&#xa;</xsl:text>
	<xsl:apply-templates select="section"/>
</xsl:template>

<xsl:template match="section">
	<xsl:text>&#xa;</xsl:text>
	<xsl:variable name="section_title"><xsl:value-of select="translate(@title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
	<a name="{$section_title}"></a>
	<xsl:value-of select="@title"/><xsl:text>&#xa;</xsl:text>
	<xsl:value-of select="substring('----------------------------------------------------------------------------------------------------------------------------------------', 1, string-length(@title))"/>
	
	<xsl:apply-templates mode="content"/>
</xsl:template>


<xsl:template match="h2" mode="content">
	<xsl:text>&#xa;### </xsl:text>
	<xsl:variable name="h2"><xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
	<a name="{$h2}"></a>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="h3" mode="content">
	<xsl:text>&#xa;#### </xsl:text>
	<xsl:variable name="h3"><xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/></xsl:variable>
	<a name="{$h3}"></a>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="p" mode="content">
	<xsl:text>&#xa;</xsl:text><xsl:apply-templates mode="content"/><xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template match="code" mode="content">
	<xsl:choose>
		<xsl:when test="@style = 'block'">
			<xsl:text>&#xa;```</xsl:text><xsl:value-of select="@lang"/>
			<xsl:value-of select="text()" disable-output-escaping="yes"/>
			<xsl:text>&#xa;```&#xa;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text> `</xsl:text><xsl:value-of select="text()" disable-output-escaping="yes"/><xsl:text>` </xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="ul" mode="content">
	<xsl:apply-templates select="li" mode="content"/>
</xsl:template>

<xsl:template match="li" mode="content">
	<xsl:text>&#xa;</xsl:text>
	<xsl:text>- </xsl:text><xsl:value-of select="text()"/>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template match="a" mode="content">
	<xsl:text>[&lt;</xsl:text><xsl:value-of select="@href"/>&gt;, <xsl:value-of select="text()"/><xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="em" mode="content">
	<xsl:text>*</xsl:text><xsl:value-of select="text()"/><xsl:text>*</xsl:text>
</xsl:template>

<xsl:template match="strong" mode="content">
	<xsl:text>**</xsl:text><xsl:value-of select="text()"/><xsl:text>**</xsl:text>
</xsl:template>




<!-- main title -->
<xsl:template match="title" mode="title">
<xsl:value-of select="text()"/>
<xsl:text>&#xa;</xsl:text>
<xsl:value-of select="substring('================================================================================================================================================', 1, string-length(text()))"/>
</xsl:template>

<!-- table of content templates -->
<xsl:template match="title" mode="toc">
	<xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>## Contents
</xsl:template>

<xsl:template match="section" mode="toc">
	<xsl:text>&#xa;1. [</xsl:text>
	<xsl:value-of select="@title"/>](#<xsl:value-of select="translate(@title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/><xsl:text>)</xsl:text>
	<xsl:apply-templates select="h2" mode="toc"/>
	<xsl:apply-templates select="h3" mode="toc"/>
</xsl:template>

<xsl:template match="h2" mode="toc">
	<xsl:text>&#xa;&#09;1. [</xsl:text>
	<xsl:value-of select="text()"/>](#<xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="h3" mode="toc">
	<xsl:text>&#xa;&#09;&#09;1. [</xsl:text>
	<xsl:value-of select="text()"/>](#<xsl:value-of select="translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/><xsl:text>)</xsl:text>
</xsl:template>

</xsl:stylesheet>
