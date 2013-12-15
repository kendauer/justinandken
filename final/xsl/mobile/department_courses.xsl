<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <!-- Call in the common xsl file to add header and footers to the document -->
    <xsl:import href="common.xsl"/>
    
    <xsl:variable name="title" select="distinct-values(/courses/course[department/@code eq $department]/department/dept_short_name)"/>
    
    <xsl:param name="department" />
    
  <xsl:template name="main">
    <xsl:apply-templates select="/courses/block" mode="pagednav"/>
    <div id="memberlist">
      <ul>
        <xsl:apply-templates select="courses/block/course"/>
      </ul>
    </div>
  </xsl:template>
    <xsl:template match="courses">
        
        <!-- uses distinct-values to pull the dept_short_name just once to create a H1 header for the page -->
        <h1>
            <xsl:value-of select="distinct-values(/courses/course[department/@code eq $department]/department/dept_short_name)" />
        </h1>
        
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
                    </ul>
            </div><br />
                 <!-- main for-each-group, selects all courses within the department, groups and sorts them by course_group
        and then lists them in a table with links-->
        <xsl:for-each-group select="/courses/course[department/@code eq $department]" group-by="course_group">
            <xsl:sort select="course_group" order="ascending"/>
            

            
            <!-- creates a h3 header with the current course_group name as the key -->
            <h3>
                <a id = "{course_group/@code}" >
                    <xsl:value-of select="current-grouping-key()"/> Courses
                </a>
            </h3>
            <ul>
                <xsl:for-each select="current-group()">
                      
                        <li>
                            <!-- this test checks to see if instructor approval is required and if it is, adds
                                an asterisk before the title. It also checks to see if the course is offered
                            during the current year and adds brackets around the course title if it is not.
                            This could be improved to execute in fewer lines in the future. -->
                            <xsl:choose>
                                <xsl:when test="instructor_approval_required = 'Y' and course/@offered = 'Y'">
                                    <a href = "{concat('/cocoon/final/mobile/courses/',@cat_num,'.html')}">
                                        *
                                        <xsl:value-of select="title"/>
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'Y' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/mobile/courses/',@cat_num,'.html')}">
                                        *
                                        [<xsl:value-of select="title"/>]
                                    </a>
                                </xsl:when>
                                <xsl:when test="instructor_approval_required = 'N' and @offered = 'N'">
                                    <a href = "{concat('/cocoon/final/mobile/courses/',@cat_num,'.html')}">
                                        [<xsl:value-of select="title"/>]
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a href = "{concat('/cocoon/final/mobile/courses/',@cat_num,'.html')}">
                                        <xsl:value-of select="title"/>
                                    </a>
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each-group>
    </xsl:template>
  <xsl:template match="block" mode="pagednav">
    <xsl:variable name="currentpage"><xsl:value-of select="//block[child::*]/@id"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="count(child::*) > 0">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$baselink}{replace($url,concat('page',$currentpage),concat('page',@id))}"><xsl:value-of select="@id"/></a>        
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()">
      <xsl:text> | </xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>