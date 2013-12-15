<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <!-- Call in the common xsl file to add header and footers to the document -->
    <xsl:import href="common.xsl"/>
    
    <xsl:variable name="title" select="'Faculty Listing'"/>
    
    <xsl:template match="courses">
        <h2 class="top">Faculty Directory</h2>
    
        <!-- link to pdf -->
        <div>
            <p> 
                <a class ="pdflink" href="facultylisting.pdf">PDF</a>
            </p>
            <br/><br/>
        </div>
        
        <!-- very simple for-each-group statement. Selects each department and sorts them by dept_short_name. 
            Lists each department only once and use the department code to generate a link -->
        <ul>
            <xsl:for-each-group select="course/faculty_list/faculty/name" group-by=".">
                <xsl:sort select="last" order="ascending"/>
                <li>                   
                    <a href = "{concat(../@id,'.html')}">
                        <xsl:value-of select="first"/>&#xA0;
                        <xsl:value-of select="last"/>
                    </a>
                </li>
            </xsl:for-each-group>
        </ul>
        
    </xsl:template>
</xsl:stylesheet>