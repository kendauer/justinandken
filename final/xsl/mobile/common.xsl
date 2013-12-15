<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
       
    <xsl:variable name="displaytitle">
        <xsl:value-of select="$title"/>
    </xsl:variable>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="$displaytitle"/>
                </title>
                <link rel="stylesheet" type="text/css" href="/cocoon/final/css/site.css"/>
            </head>
            <body>
                <xsl:call-template name="header"/>
                <xsl:apply-templates/>
                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- a simple header  -->
    <xsl:template name="header">
        <div class="header">
            <h1>Harvard University</h1>
            <h3><a href="/cocoon/final/mobile/index.html">Course Catalog</a></h3>
        </div>
    </xsl:template>
    
    <!-- A footer with links to other Harvard pages. CSS rules have the links grayed out and no line wrap, so it 
    all appears on one line. -->
    <xsl:template name="footer">
        <hr/>
        <div class="footerlinks">
            <a href = "http://localhost:8080/cocoon/final/index.html">Full Site</a>
            <p>|</p>
            <a href = "http://www.harvard.edu">Harvard University</a>
            <p>|</p>
            <a href = "http://www.fas.harvard.edu/">Faculty of Arts and Sciences</a>
            <p>|</p>
            <a href ="http://www.college.harvard.edu/icb/icb.do">Harvard College</a>
            <p>|</p>
            <a href = "http://www.gsas.harvard.edu/">Graduate School of Arts and Sciences</a>
        </div>
    </xsl:template>
</xsl:stylesheet>