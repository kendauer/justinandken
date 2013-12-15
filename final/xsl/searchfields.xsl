<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">
  <xsl:output method="xml"/>
  
  <!-- this template pulls distinct values from the xml data to generate values for the search fields -->
  <xsl:template match="courses">
    <search_fields>
      <xsl:call-template name="course_group_nav" />
      <xsl:call-template name="term_nav"         />
      <xsl:call-template name="day_nav"         />
      <xsl:call-template name="time_nav"         />
      <xsl:call-template name="offered_nav"      />
      <xsl:call-template name="level_nav"      />
      <xsl:call-template name="type_nav"      />
    </search_fields>
  </xsl:template>
  <xsl:template name="course_group_nav" >
    <course_groups>
      <xsl:for-each-group select="course/course_group" group-by="@code">
        <xsl:sort select="current-group()[1]/text()"/>
        <course_group code="{current-grouping-key()}">
          <xsl:value-of select="current-group()[1]/text()" />
        </course_group>
      </xsl:for-each-group>
    </course_groups>
  </xsl:template>
  <xsl:template name="term_nav" >
    <terms>
      <xsl:for-each-group select="course/term" group-by="@term_pattern_code">
        <xsl:sort select="@term_pattern_code"/>
        <term code="{current-grouping-key()}">
          <xsl:value-of select="current-group()[1]/text()" />
        </term>
      </xsl:for-each-group>
    </terms>
  </xsl:template>
  <xsl:template name="day_nav" >
    <days>
      <day code="1">Mon</day>
      <day code="2">Tue</day>
      <day code="3">Wed</day>
      <day code="4">Thu</day>
      <day code="5">Fri</day>
      <day code="6">Sat</day>
    </days>
  </xsl:template>
  <xsl:template name="time_nav" >
    <times>
      <xsl:for-each-group select="course/schedule/meeting" group-by="@begin_time">
        <xsl:sort select="@begin_time"/>
        <time code="{current-grouping-key()}">
          <xsl:value-of select="current-grouping-key()" />
        </time>
      </xsl:for-each-group>
    </times>
  </xsl:template>
  <xsl:template name="offered_nav" >
    <offereds>
      <offered code="Y">Yes</offered>
      <offered code="N">No</offered>
    </offereds>
  </xsl:template>
  <xsl:template name="type_nav" >
    <course_types>
      <xsl:for-each-group select="course/course_type" group-by=".">
        <xsl:sort select="."/>
        <course_type code="{current-grouping-key()}">
          <xsl:value-of select="." />
        </course_type>
      </xsl:for-each-group>
    </course_types>
  </xsl:template>
  <xsl:template name="level_nav" >
    <course_levels>
      <xsl:for-each-group select="course/course_level" group-by="@code">
        <xsl:sort select="index-of(('P','O','T','G'),.)"/>
        <course_level code="{current-grouping-key()}">
          <xsl:value-of select="current-group()[1]/text()" />
        </course_level>
      </xsl:for-each-group>
    </course_levels>
  </xsl:template>
  <xsl:template match="text()"/>
</xsl:stylesheet>