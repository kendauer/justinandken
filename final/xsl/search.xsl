<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <!-- these are the parameters passed in form the URI -->
    <xsl:variable name="default_param" select="'*'"/>
    <xsl:param name="keyword" select="$default_param"/>
    <xsl:param name="course_group" select="$default_param"/>
    <xsl:param name="term" select="$default_param"/>
    <xsl:param name="time" select="$default_param"/>
    <xsl:param name="day" select="$default_param"/>
    <xsl:param name="offered" select="$default_param"/>
    <xsl:param name="course_level" select="$default_param"/>
    <xsl:param name="course_type" select="$default_param"/>
    <xsl:output method="xml"/>
    
    <xsl:template match="courses">      
        <courses>
            
            <!-- this for each group filters based upon parameters based in the URI -->
            <xsl:for-each-group select="/courses/course[
                (contains(lower-case(.), lower-case(replace($keyword,'\+', ' '))) 
                or contains(lower-case(replace(.,'\s.\.','')), lower-case(replace($keyword,'\+', ' ')))
                or $keyword = '' or $keyword = '*'
                ) 
                and
                (course_group/@code=$course_group or $course_group='' or $course_group='*')
                and 
                (term/@term_pattern_code = $term or $term='' or $term='*')
                and
                (@offered = $offered or $offered = '' or $offered='*')
                and
                (course_level/@code = $course_level or $course_level = '' or $course_level='*')
                and
                (course_type = $course_type or $course_type = '' or $course_type='*')
                and
                (schedule/meeting/@day = $day or $day = '' or $day='*')
                and
                (schedule/meeting/@begin_time = $time or $time = '' or $time='*')
                ]"
                group-by="@cat_num">
                
                <!-- this sextion creates all of the XML content -->
                <course>
                    <catalog_number>
                        <xsl:value-of select="@cat_num" />
                    </catalog_number>
                    <course_group>
                        <xsl:value-of select="course_group" />
                    </course_group>
                    <term>
                        <xsl:value-of select="term" />
                    </term>
                    <offered>
                        <xsl:value-of select="@offered" />
                    </offered>
                    <course_type>
                        <xsl:value-of select="course_type" />
                    </course_type>
                    <course_level>
                        <xsl:value-of select="course_level" />
                    </course_level>
                    <title>
                        <xsl:value-of select="title" />
                    </title>
                    <course_number>
                        <xsl:value-of select="course_number/num_int" />
                    </course_number>
                </course>
            </xsl:for-each-group>
        </courses>
        
    </xsl:template>
</xsl:stylesheet>