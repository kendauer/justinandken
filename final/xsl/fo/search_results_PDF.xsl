<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
    <xsl:attribute-set name="bold">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">1em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="italic">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
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
                        <xsl:value-of select="distinct-values(/courses/course/department/dept_short_name)" />
                    </fo:block>
                    
                    <!-- Table of Contents-->
                    <xsl:for-each-group select="/courses/course" group-by="course_group">
                        <xsl:sort select="course_group, title" order="ascending"/>
                        <fo:block xsl:use-attribute-sets="header">
                            <xsl:value-of select="current-grouping-key()"/>
                        </fo:block>
                        <xsl:for-each select="current-group()">
                            <xsl:sort select="course_group, title" order="ascending"/>
                            <fo:block text-align-last="justify" xsl:use-attribute-sets="table-of-contents">
                                <fo:basic-link>
                                    <xsl:attribute name="internal-destination">
                                        <xsl:value-of select="generate-id()"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="course_group"/>
                                    &#xA0;
                                    <xsl:value-of select="title"/>
                                    <fo:leader leader-pattern="dots"/>
                                    <fo:page-number-citation>
                                        <xsl:attribute name="ref-id">
                                            <xsl:value-of select="generate-id()"/>
                                        </xsl:attribute>
                                    </fo:page-number-citation>
                                </fo:basic-link>
                            </fo:block>
                        </xsl:for-each>
                    </xsl:for-each-group>
                    
                    <!-- Course Listing-->
                    <xsl:for-each-group select="/courses/course" group-by="course_group">
                        <xsl:sort select="course_group, title" order="ascending"/>
                        <fo:block xsl:use-attribute-sets="header">
                            <xsl:value-of select="current-grouping-key()"/>
                        </fo:block>
                        <xsl:for-each select="current-group()">
                            <fo:block id="{generate-id()}" xsl:use-attribute-sets="bold">
                                <xsl:value-of select="course_group"/>
                                &#xA0;
                                <xsl:value-of select="course_number"/>
                                &#xA0;
                                <xsl:value-of select="title"/>
                            </fo:block>
                            <fo:block>
                                Catalog Number: 
                                <xsl:value-of select="catalog_number"/>
                            </fo:block>
                            <fo:block xsl:use-attribute-sets="italic">
                                Term:
                                <xsl:value-of select="term"/>
                            </fo:block>
                            <fo:block>
                                Offered:
                                <xsl:when test="offered = 'Y'">
                                    Yes
                                </xsl:when>
                                <xsl:when test="offered = 'N'">
                                    No
                                </xsl:when>
                                <xsl:value-of select="offered"/>
                            </fo:block>
                            <fo:block xsl:use-attribute-sets="italic">
                                Course Type:
                                <xsl:value-of select="course_type"/>
                            </fo:block>
                            <fo:block>
                                Course Level:
                                <xsl:value-of select="course_level"/>
                            </fo:block>
                        </xsl:for-each>
                    </xsl:for-each-group>
                    
                    <!-- last block for "theEnd" id -->
                    <fo:block id="theEnd">  </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
        
    </xsl:template>
</xsl:stylesheet>