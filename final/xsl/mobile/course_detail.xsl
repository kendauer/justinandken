<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dir="http://apache.org/cocoon/directory/2.0"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  
  <!-- Call in the common xsl file to add header and footers to the document -->
  <xsl:import href="common.xsl"/>
  
  <!-- Sets the title varliable -->
  <xsl:variable name="title" select="/courses/course[@cat_num eq $cat_num]/title"/>
  
  <!-- the cat_num parameter is taken from the URL and is the unique identifier for the course -->
  <xsl:param name="cat_num" />
  
  <xsl:template match="courses">
    <xsl:for-each-group select="/courses/course[@cat_num eq $cat_num]" group-by="course_group">
      <xsl:sort select="course_group" order="ascending"/>
      
      <div class = "course_container">
        
        <!-- This detailnav div provides breadcrum navigation back to the department listing and the department_courses page-->
        <div class="detailnav">
          <a href="/cocoon/assignment3/mobile/index.html">Departments</a>&#xA0;>&#xA0;

          <a href="{concat('/cocoon/final/mobile/departments/',department/@code,'.html')}">
            <xsl:value-of select="department/dept_short_name"/>
          </a>&#xA0;>&#xA0;
          <p>
            <xsl:value-of select="title"/>
          </p>
        </div>
        
        <h1>
          <xsl:value-of select="title"/>
        </h1>
        <h3>
          <xsl:value-of select="course_group"/>&#xA0;
          
          <xsl:value-of select="course_number/num_int"/>.
          
          <xsl:value-of select="title"/>
        </h3>
        <p>
          Catalog Number: 
          <xsl:value-of select="@cat_num"/>
        </p>
        <p>
          <i>
            <xsl:value-of select="faculty_text"/>
          </i>
        </p>
        <p>
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
          
          <xsl:value-of select="meeting_text"/>.
          
        </p>
        <p>
          <strong>
            <xsl:value-of select="course_level"/>
            /
            <xsl:value-of select="course_type"/>
          </strong>
        </p>
        <div class="description">
          <p>
            <xsl:value-of select="description"/>
          </p>
          <p>
            <i>
              Note:
            </i>
            <xsl:value-of select="notes"/>
          </p>
        </div>
      </div>
    </xsl:for-each-group>
  </xsl:template>
</xsl:stylesheet>