<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <!-- Call in the common xsl file to add header and footers to the document -->
    <xsl:import href="common.xsl"/>
    
    <xsl:variable name="title" select="'Harvard University Course Catalog'"/>
    
    <xsl:template match="courses">
        <h2>Departments</h2>
        
        <!-- very simple for-each-group statement. Selects each department and sorts them by dept_short_name. 
            Lists each department only once and use the department code to generate a link -->
        <ul>
            <xsl:for-each-group select="course/department" group-by="dept_short_name">
                <xsl:sort select="dept_short_name" order="ascending"/>
                <li>
                    <a href = "{concat('course_groups/',@code,'.html')}">
                        <xsl:value-of select="current-grouping-key()"/>
                    </a>
                    <br/>
                </li>

            </xsl:for-each-group>
        </ul>
    </xsl:template>
</xsl:stylesheet>