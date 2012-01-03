<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output 
  method="html" 
  media-type="text/html" 
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="DTD/xhtml1-strict.dtd" 
  cdata-section-elements="script style" 
  indent="yes" encoding="ISO-8859-1"/>
  <xsl:template match="/">
    <html>
      <head>
        <xsl:apply-templates select="//meta" mode="head"/>
        <link href="doc.css" rel="stylesheet" type="text/css"/>
        <style type="text/css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <!-- head items -->
  <xsl:template match="meta" mode="head">
    <title>
      <xsl:value-of select="title"/>
    </title>
    <meta name="author" content="{author}"/>
    <meta name="updated" content="{updated}"/>
  </xsl:template>
  
  <xsl:template match="text()" mode="head"/>

  <!-- body items -->
  <xsl:template match="content">
    <h1>
      <xsl:value-of select="//meta/title"/>
    </h1>
    <address>      
      Updated: 
      <xsl:value-of select="//meta/updated"/>
      by 
      <xsl:value-of select="//meta/author"/>
    </address>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="section">
    <div class="section">
      <xsl:if test="title!=''">
        <h2>
          <xsl:value-of select="title"/>
        </h2>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="text">
    <span>
      <xsl:value-of select="normalize-space(.)"/>
    </span>
  </xsl:template>

  <xsl:template match="eol">
    <br/>
  </xsl:template>

  <!-- outboud link -->
  <xsl:template match="LO">
    <a href="{@href}" title="{@label}" rel="{@CL}">
      <xsl:value-of select="@label"/>
    </a>
  </xsl:template>

  <!-- embedded link -->
  <xsl:template match="LE">
    <xsl:choose>
      <xsl:when test="@CR!=''">
        <iframe src="{@href}" title="{@label}" rel="{@CL}"/>
      </xsl:when>
      <xsl:otherwise>
        <img src="{@href}" title="{@label}" rel="{@CL}"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- query template -->
  <xsl:template match="LT">
    <form method="get" action="{@href}" rel="{@CL}">
      <xsl:if test="@CR!=''">
        <xsl:attribute name="accept">
          <xsl:value-of select="@CR"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
      <input type="submit"/>
    </form>
  </xsl:template>

  <!-- idempotent operation -->
  <xsl:template match="LI">
    <form action="{@href}" method="{@CM}" rel="{@CL}">
      <xsl:if test="@CU!=''">
       <xsl:attribute name="enctype">
          <xsl:value-of select="@CU"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
      <input type="submit"/>
    </form>
  </xsl:template>

  <!-- non-idempotent update -->
  <xsl:template match="LN">
    <form method="post" action="{@href}" rel="{@CL}">
      <xsl:if test="@CU!=''">
        <xsl:attribute name="enctype">
          <xsl:value-of select="@CU"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
      <input type="submit"/>
    </form>
  </xsl:template>

  <!-- data element/prompt for templates -->
  <xsl:template match="data">
    <xsl:if test="@label!=''">
      <label>
        <xsl:value-of select="@label"/>
      </label>
    </xsl:if>
    <input name="{@name}" value="{@value}"/>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>