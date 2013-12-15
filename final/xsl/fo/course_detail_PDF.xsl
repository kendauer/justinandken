<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml"/>
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
    
    <xsl:param name="cat_num" />
    
    <xsl:template match="courses">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin-top="1.0in" margin-bottom="1.0in" margin-left="1.25in" margin-right="1.25in">
                    <fo:region-body margin-top="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <!-- Main for-each-group that pull all courses matching the course number -->
            <xsl:for-each-group select="/courses/course[@cat_num eq $cat_num]" group-by="course_group">
                <xsl:sort select="course_group" order="ascending"/>
                <fo:page-sequence master-reference="simple">
                    
                    <!--  fo:static-content for header  -->
                    <fo:static-content flow-name="xsl-region-before">
                        <fo:block font-size="8pt" text-align="end">
                            <xsl:value-of select="department/dept_short_name"/>
                            , Page
                            <fo:page-number/>
                            <xsl:text> of </xsl:text>
                            <fo:page-number-citation ref-id="theEnd"/>
                        </fo:block>
                    </fo:static-content>
                    
                    <fo:flow flow-name="xsl-region-body">
                        <fo:block font-size="18pt" font-family="sans-serif" line-height="24pt" space-after.optimum="15pt" background-color="blue" color="white" text-align="center" 
                            padding-top="3pt">
                            <xsl:value-of select="title"/>
                        </fo:block>
                        
                        <!-- Course description -->
                        <fo:block id="{generate-id()}" xsl:use-attribute-sets="bold">
                            <xsl:value-of select="course_group"/>
                            &#xA0;
                            <xsl:value-of select="course_number/num_int"/>
                            &#xA0;
                            <xsl:value-of select="title"/>
                        </fo:block>
                        <fo:block>
                            Catalog Number: 
                            <xsl:value-of select="@cat_num"/>
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="italic">
                            <xsl:value-of select="faculty_text"/>
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="italic">
                            <xsl:value-of select="credit"/>
                            
                            <!-- A simple set of tests to see if the course is offerred in the spring and/or fall -->
                            <xsl:choose>
                                <xsl:when test="term/@fall_term = 'Y'">
                                    (fall term).
                                </xsl:when>
                                <xsl:when test="term/@spring_term = 'Y'">
                                    (spring term).
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="meeting_text"/>
                            .
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="bold">
                            <xsl:value-of select="course_level"/>
                            /
                            <xsl:value-of select="course_type"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="description"/>
                        </fo:block>
                        <fo:block font-style="italic">Note:</fo:block>
                        <fo:block>
                            <xsl:value-of select="notes"/>
                        </fo:block>
                        
                        <!-- last block for "theEnd" id, used for figuring out how many pages there are  -->
                        <fo:block id="theEnd">  </fo:block>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each-group>
            
        </fo:root>
        
    </xsl:template>
</xsl:stylesheet>