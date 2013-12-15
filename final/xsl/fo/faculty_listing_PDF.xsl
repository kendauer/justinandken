<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml"/>
    
    <xsl:attribute-set name="table-of-contents">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">0em</xsl:attribute>
        <xsl:attribute name="margin-left">1em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:param name="department" />
    <xsl:template match="courses">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin-top="1.0in" margin-bottom="1.0in" margin-left="1.25in" margin-right="1.25in">
                    <fo:region-body margin-top="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simple">
                
                <!--  fo:static-content for header  -->
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="8pt" text-align="end">
                        Page
                        <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="theEnd"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="18pt" font-family="sans-serif" line-height="24pt" space-after.optimum="15pt" background-color="blue" color="white" text-align="center" 
                        padding-top="3pt">
                        Harvard University Course Catalog
                    </fo:block>
                    <fo:block xsl:use-attribute-sets="header">
                        Faculty Listing
                    </fo:block>
                    
                    <!-- List all faculty members -->
                    <xsl:for-each-group select="course/faculty_list/faculty/name" group-by=".">
                        <xsl:sort select="last" order="ascending"/>
                        <fo:block xsl:use-attribute-sets="table-of-contents">
                            <xsl:value-of select="first"/>
                            &#xA0;
                            <xsl:value-of select="last"/>
                        </fo:block>
                    </xsl:for-each-group>
                    
                    <!-- last block for "theEnd" id -->
                    <fo:block id="theEnd">  </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
</xsl:stylesheet>