<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dir="http://apache.org/cocoon/directory/2.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <!-- Call in the common xsl file to add header and footers to the document -->
    <xsl:import href="common.xsl"/>
    

    
    <xsl:param name="department" />
    
    <xsl:variable name="title" select="distinct-values(/courses/course[department/@code eq $department]/department/dept_short_name)"/>
    
    <xsl:template match="courses">
        
        <!-- uses distinct-values to pull the dept_short_name just once to create a H1 header for the page -->
        <h1 class = "top">
            <xsl:value-of select="distinct-values(/courses/course[department/@code eq $department]/department/dept_short_name)" />
        </h1>
        
        <!-- pdf link -->
        <div><p>
            <a class = "pdflink" href = "{concat('/cocoon/final/course_groups/',$department,'.pdf')}">PDF</a> 
            </p> <br/><br/><br/>
        </div>
        
        <!-- main for-each-group, selects all courses within the department, groups and sorts them by course_group
        and then lists them in a table with links-->
        <xsl:for-each-group select="/courses/course[department/@code eq $department]" group-by="course_group">
            <xsl:sort select="course_group" order="ascending"/>
            
            <!-- Lists all of the groups as part of a navigation bar -->
            <div class="grouplisting">
                    <ul>
                <xsl:for-each-group select="/courses/course[department/@code eq $department]" group-by="course_group">
                    <xsl:sort select="course_group" order="ascending"/>
                    <xsl:for-each select="course_group">
                        <xsl:sort select="num_int, num_char, title" order="ascending"/><!--
                            <xsl:if test="position() != last()">
                                <a href="{concat('#', @code)}">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </a>
                                <p>|</p>
                            </xsl:if>
                            <xsl:if test="position() = last()">-->
                                <li><a href="{concat('#', @code)}">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </a></li>
                            <!-- </xsl:if> -->
                    </xsl:for-each>
                </xsl:for-each-group>
                    </ul><br /> <br/>
            </div>
            
            <!-- creates a h3 header with the current course_group name as the key -->
            <h3>
                <a id = "{course_group/@code}" >
                    <xsl:value-of select="current-grouping-key()"/>
                </a>
            </h3>
            <table border="1">
                <tr class = "tabletitles">
                    <th>Number</th>
                    <th>Term</th>
                    <th>Title</th>
                    <th>Meeting Times</th>
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
                            <a href = "{concat('/cocoon/final/courses/',@cat_num,'.html')}">
                                <xsl:value-of select="course_group"/>
                                &#xA0;
                                <xsl:value-of select="course_number/num_int"/>
                            </a>
                        </td>
                        <td>
                            <xsl:value-of select="term"/>
                        </td>
                        
                        <td>
                            <!-- this test checks to see if instructor approval is required and if it is, adds
                                an asterisk before the title. It also checks to see if the course is offered
                            during the current year and adds brackets around the course title if it is not.
                            This could be improved to execute in fewer lines in the future. -->
                            <xsl:choose>
                                <xsl:when test="instructor_approval_required = 'Y' and course/@offered = 'Y'">
                                    <a href = "{concat('/cocoon/final/courses/',@cat_num,'.html')}">
                                        *
                                        <xsl:value-of select="title"/>
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'Y' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/courses/',@cat_num,'.html')}">
                                        *
                                        [<xsl:value-of select="title"/>]
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'N' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/courses/',@cat_num,'.html')}">
                                        [<xsl:value-of select="title"/>]
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a href = "{concat('/cocoon/final/courses/',@cat_num,'.html')}">
                                        <xsl:value-of select="title"/>
                                    </a>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td>
                            <xsl:value-of select="meeting_text"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </xsl:for-each-group>
       <p/>
    </xsl:template>
</xsl:stylesheet>