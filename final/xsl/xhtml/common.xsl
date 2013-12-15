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
    
    <!-- a simple header with the Harvard shield and a description. CSS rules have the shield floating to the left -->
    <xsl:template name="header">
        <div class="header">
            <h1><a href="/cocoon/final/index.html"><img src="/cocoon/final/images/harvard_shield.png" alt="Harvard Shield"/>
                Harvard University, Faculty of Arts and Sciences Course Catalog</a></h1>
            <br/>
        </div>
        
        <!-- Navigation menu, design courtesy of cssmenumaker.com -->
        <div id='cssmenu'>
            <ul>
                <li class='active'><a href = "/cocoon/final/index.html">Catalog Home</a></li>
                <li class='has-sub'><a href="/cocoon/final/web/search.html">Course Search</a></li>
                <li class='has-sub'><a href="/cocoon/final/faculty/index.html">Faculty Directory</a></li>
                <li class='has-sub'><a href="/cocoon/final/mobile/index.html">Mobile Page</a></li>
                <li class='has-sub'><a href='#'><span>Courses by Day</span></a>
                    <ul>
                        <li><a href="/cocoon/final/day_courses/1.html"><span>Monday Courses</span></a></li>
                        <li><a href="/cocoon/final/day_courses/2.html"><span>Tuesday Courses</span></a></li>
                        <li><a href="/cocoon/final/day_courses/3.html"><span>Wednesday Courses</span></a></li>
                        <li><a href="/cocoon/final/day_courses/4.html"><span>Thursday Courses</span></a></li>
                        <li><a href="/cocoon/final/day_courses/5.html"><span>Friday Courses</span></a></li>
                        <li class='last'><a href="/cocoon/final/day_courses/6.html"><span>Saturday Courses</span></a></li>
                    </ul>                
                </li>
            </ul>
        </div>
        
    </xsl:template>
    
    <!-- A footer with links to other Harvard pages. CSS rules have the links grayed out and no line wrap, so it 
    all appears on one line. -->
    <xsl:template name="footer">
        <hr/>
        <div class="footerlinks">
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