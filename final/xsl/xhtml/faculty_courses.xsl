<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <!-- Call in the common xsl file to add header and footers to the document -->
    <xsl:import href="common.xsl"/>
    <xsl:param name="name" />
    
    <!-- Set the page title to the name of the faculty member-->
    <xsl:variable name="title" select="distinct-values(/courses/course/faculty_list/faculty[@id eq $name]/name/first), distinct-values(/courses/course/faculty_list/faculty[@id eq $name]/name/last)"/>
    
    <xsl:template match="courses">
        <!-- uses distinct-values to pull the name of the faculty just once to create a H1 header for the page -->
        <h1>
            <xsl:value-of select="distinct-values(/courses/course/faculty_list/faculty[@id eq $name]/name/first)" />
            &#xA0;
            <xsl:value-of select="distinct-values(/courses/course/faculty_list/faculty[@id eq $name]/name/last)" />
        </h1>
        
        <!-- top level navigation -->
        <p>
        <a class ="pdflink" href = "{concat('/cocoon/final/faculty/',$name,'.pdf')}">PDF</a> 
        </p>
        
        <!-- main for-each-group, selects all courses taught by the faculty member, groups and sorts them by course_group
         and then lists them in a table with links-->
        <xsl:for-each-group select="/courses/course/faculty_list/faculty[@id eq $name]" group-by=".">
            <table border="1">
                <tr class = "tabletitles">
                    <th>Number</th>
                    <th>Term</th>
                    <th>Title</th>
                </tr>
                <xsl:for-each select="current-group()">
                    <tr>
                        
                        <!-- This test adds a class class value of oddrow or evenrow to each table row. CSS rules then
                     color odd rows -->
                        <xsl:choose>
                            <xsl:when test="position() mod 2">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="'oddrow'"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="class">
                                    <xsl:value-of select="'evenrow'"/>
                                </xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        <td>
                            <!-- Uses the course cat_num as a value to generate a link. This link activates
                        the course_detail template and generates a page describing the course -->
                            <a href = "{concat('/cocoon/assignment2/courses/',../../@cat_num,'.html')}">
                                <xsl:value-of select="../../course_group"/>
                                &#xA0;
                                <xsl:value-of select="../../course_number/num_int"/>
                            </a>
                        </td>
                        <td>
                            <xsl:value-of select="../../term"/>
                        </td>
                        <td>
                            
                            <!-- this test checks to see if instructor approval is required and if it is, adds
                        an asterisk before the title. It also checks to see if the course is offered
                        during the current year and adds brackets around the course title if it is not.
                        This could be improved to execute in fewer lines in the future. -->
                            <xsl:choose>
                                <xsl:when test="instructor_approval_required = 'Y' and course/@offered = 'Y'">
                                    <a href = "{concat('/cocoon/final/courses/',../../@cat_num,'.html')}">
                                        *
                                        <xsl:value-of select="../../title"/>
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'Y' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/courses/',../../@cat_num,'.html')}">
                                        *
                                        [
                                        <xsl:value-of select="../../title"/>
                                        ]
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'N' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/courses/',../../@cat_num,'.html')}">
                                        [
                                        <xsl:value-of select="../../title"/>
                                        ]
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a href = "{concat('/cocoon/final/courses/',../../@cat_num,'.html')}">
                                        <xsl:value-of select="../../title"/>
                                    </a>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
            <p/>
        </xsl:for-each-group>
        
    </xsl:template>
</xsl:stylesheet>