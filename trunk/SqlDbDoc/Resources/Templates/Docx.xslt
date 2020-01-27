<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output
      method="xml"
      indent="no"
      omit-xml-declaration="yes"
      encoding="UTF-8" />
  <xsl:template match="/">
    <w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
      xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
      xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
      xmlns:v="urn:schemas-microsoft-com:vml"
      xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
      xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
      xmlns:w10="urn:schemas-microsoft-com:office:word"
      xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
      xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
      xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
      xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
      xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
      xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
      xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 w15 wp14">
      <w:body>
        <w:p w:rsidR="004F5C73" w:rsidRDefault="004F5C73" w:rsidP="004F5C73">
          <w:pPr>
            <w:pStyle w:val="1"/>
            <w:divId w:val="2059545040"/>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
            <w:t>
              <xsl:value-of select="concat(/database/@name, ' Database Schema')" />
            </w:t>
          </w:r>
        </w:p>
        <!-- Process all objects -->
        <xsl:for-each select="/database/object">
        <w:p w:rsidR="004F5C73" w:rsidRDefault="004F5C73" w:rsidP="004F5C73">
          <w:pPr>
            <w:pStyle w:val="2"/>
            <w:divId w:val="2059545040"/>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
            <w:t>
              <xsl:choose>
                <xsl:when test="@type='USER_TABLE'">Table </xsl:when>
                <xsl:when test="@type='VIEW'">View </xsl:when>
              </xsl:choose>
              <xsl:value-of select="concat(@schema, '.', @name)"/>
            </w:t>
          </w:r>
        </w:p>
        <w:p w:rsidR="004F5C73" w:rsidRDefault="004F5C73" w:rsidP="004F5C73">
          <w:pPr>
            <w:pStyle w:val="Web"/>
            <w:divId w:val="2059545040"/>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
          </w:pPr>
          <w:r>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
            </w:rPr>
            <w:t>
              <xsl:value-of select="@description"/>
            </w:t>
          </w:r>
        </w:p>
        <w:tbl>
          <w:tblPr>
            <w:tblW w:w="5000" w:type="pct"/>
            <w:tblCellMar>
              <w:top w:w="15" w:type="dxa"/>
              <w:left w:w="15" w:type="dxa"/>
              <w:bottom w:w="15" w:type="dxa"/>
              <w:right w:w="15" w:type="dxa"/>
            </w:tblCellMar>
            <w:tblLook w:val="04A0" w:firstRow="1" w:lastRow="0" w:firstColumn="1" w:lastColumn="0" w:noHBand="0" w:noVBand="1"/>
          </w:tblPr>
          <w:tblGrid>
            <w:gridCol w:w="3745"/>
            <w:gridCol w:w="2496"/>
            <w:gridCol w:w="674"/>
            <w:gridCol w:w="3289"/>
          </w:tblGrid>
          <w:tr w:rsidR="006B45B2" w:rsidTr="006B45B2">
            <w:trPr>
              <w:divId w:val="2059545040"/>
              <w:tblHeader/>
            </w:trPr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:gridSpan w:val="4"/>
                <w:tcBorders>
                  <w:top w:val="nil"/>
                  <w:left w:val="nil"/>
                  <w:bottom w:val="nil"/>
                  <w:right w:val="nil"/>
                </w:tcBorders>
                <w:shd w:val="clear" w:color="auto" w:fill="CCCCCC"/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:vAlign w:val="center"/>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:spacing w:after="60"/>
                  <w:jc w:val="right"/>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="666666"/>
                    <w:sz w:val="16"/>
                    <w:szCs w:val="16"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="666666"/>
                    <w:sz w:val="16"/>
                    <w:szCs w:val="16"/>
                  </w:rPr>
                  <w:t>
                    <xsl:value-of select="concat('Table ID: ', @id)"/>
                    <xsl:value-of select="concat('; Created: ', msxsl:format-date(@dateCreated, 'MMMM dd, yyyy', 'en-US'), msxsl:format-time(@dateCreated, ', HH:mm:ss', 'en-US'))" />
                    <xsl:if test="@dateCreated != @dateModified">
                      <xsl:value-of select="concat('; Modified: ', msxsl:format-date(@dateModified, 'MMMM dd, yyyy', 'en-US'), msxsl:format-time(@dateModified, ', HH:mm:ss', 'en-US'))" />
                    </xsl:if>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
          </w:tr>
          <w:tr w:rsidR="006B45B2" w:rsidTr="006B45B2">
            <w:trPr>
              <w:divId w:val="2059545040"/>
              <w:tblHeader/>
            </w:trPr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="3600" w:type="dxa"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:shd w:val="clear" w:color="auto" w:fill="CCCCCC"/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>Name</w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="2400" w:type="dxa"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:shd w:val="clear" w:color="auto" w:fill="CCCCCC"/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>Type</w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="480" w:type="dxa"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:shd w:val="clear" w:color="auto" w:fill="CCCCCC"/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>NULL</w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:shd w:val="clear" w:color="auto" w:fill="CCCCCC"/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>Comment</w:t>
                </w:r>
              </w:p>
            </w:tc>
          </w:tr>
          <xsl:for-each select="column">
          <w:tr w:rsidR="006B45B2" w:rsidTr="006B45B2">
            <w:trPr>
              <w:divId w:val="2059545040"/>
            </w:trPr>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:noWrap/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <xsl:if test="primaryKey">
                  <w:r>
                    <w:rPr>
                      <w:rStyle w:val="pk1"/>
                      <w:rFonts w:ascii="Cambria Math" w:hAnsi="Cambria Math" w:cs="Cambria Math"/>
                      <w:b/>
                      <w:bCs/>
                    </w:rPr>
                    <w:t>◆</w:t>
                  </w:r>
                </xsl:if>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:b/>
                    <w:bCs/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>
                    <xsl:value-of select="@name"/>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:noWrap/>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>
                    <xsl:value-of select="@type"/>
                    <xsl:choose>
                      <xsl:when test="@length=-1">(MAX)</xsl:when>
                      <xsl:when test="@type='char' or @type='varchar' or @type='binary' or @type='varbinary'">
                        <xsl:value-of select="concat('(', @length, ')')"/>
                      </xsl:when>
                      <xsl:when test="@type='nchar' or @type='nvarchar'">
                        <xsl:value-of select="concat('(', @length div 2, ')')"/>
                      </xsl:when>
                      <xsl:when test="@type='decimal' or @type='numeric'">
                        <xsl:value-of select="concat('(', @precision, ', ', @scale, ')')"/>
                      </xsl:when>
                    </xsl:choose>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:jc w:val="center"/>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Segoe UI Symbol" w:hAnsi="Segoe UI Symbol" w:cs="Segoe UI Symbol"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>
                    <xsl:choose>
                      <xsl:when test="@nullable='true'">&#9746;</xsl:when>
                      <xsl:otherwise>&#9744;</xsl:otherwise>
                    </xsl:choose>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
            <w:tc>
              <w:tcPr>
                <w:tcW w:w="0" w:type="auto"/>
                <w:tcBorders>
                  <w:top w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:left w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                  <w:right w:val="single" w:sz="6" w:space="0" w:color="666666"/>
                </w:tcBorders>
                <w:tcMar>
                  <w:top w:w="36" w:type="dxa"/>
                  <w:left w:w="60" w:type="dxa"/>
                  <w:bottom w:w="36" w:type="dxa"/>
                  <w:right w:w="60" w:type="dxa"/>
                </w:tcMar>
                <w:hideMark/>
              </w:tcPr>
              <w:p w:rsidR="006B45B2" w:rsidRDefault="006B45B2" w:rsidP="008029FA">
                <w:pPr>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                </w:pPr>
                <w:r>
                  <w:rPr>
                    <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                    <w:color w:val="000000"/>
                  </w:rPr>
                  <w:t>
                    <xsl:value-of select="@description"/>
                  </w:t>
                </w:r>
              </w:p>
            </w:tc>
          </w:tr>
          </xsl:for-each>
        </w:tbl>
        </xsl:for-each>
        <!-- Footer -->
        <w:p w:rsidR="004F5C73" w:rsidRPr="0059776A" w:rsidRDefault="0059776A" w:rsidP="0059776A">
          <w:pPr>
            <w:spacing w:before="240"/>
            <w:jc w:val="center"/>
            <w:textAlignment w:val="center"/>
            <w:divId w:val="2059545040"/>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas" w:hint="eastAsia"/>
              <w:color w:val="000000"/>
              <w:sz w:val="19"/>
              <w:szCs w:val="19"/>
            </w:rPr>
          </w:pPr>
          <w:bookmarkStart w:id="0" w:name="_GoBack"/>
          <w:bookmarkEnd w:id="0"/>
          <w:r>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
              <w:sz w:val="19"/>
              <w:szCs w:val="19"/>
            </w:rPr>
            <w:t xml:space="preserve">Generated by </w:t>
          </w:r>
          <w:hyperlink w:history="1">
            <w:r>
              <w:rPr>
                <w:rStyle w:val="a3"/>
                <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
                <w:sz w:val="19"/>
                <w:szCs w:val="19"/>
              </w:rPr>
              <w:t>DB&gt;doc</w:t>
            </w:r>
          </w:hyperlink>
          <w:r>
            <w:rPr>
              <w:rFonts w:ascii="Consolas" w:hAnsi="Consolas"/>
              <w:color w:val="000000"/>
              <w:sz w:val="19"/>
              <w:szCs w:val="19"/>
            </w:rPr>
            <w:t xml:space="preserve"> on <xsl:value-of select="msxsl:format-date(/database/@dateGenerated, 'MMMM dd, yyyy', 'en-US')"/><xsl:value-of select="msxsl:format-time(/database/@dateGenerated, ', HH:mm:ss')"/></w:t>
          </w:r>
        </w:p>
        <w:sectPr w:rsidR="004F5C73" w:rsidRPr="004F5C73" w:rsidSect="000C41A2">
          <w:pgSz w:w="11906" w:h="16838"/>
          <w:pgMar w:top="851" w:right="851" w:bottom="851" w:left="851" w:header="851" w:footer="992" w:gutter="0"/>
          <w:cols w:space="425"/>
          <w:docGrid w:linePitch="360"/>
        </w:sectPr>
      </w:body>
    </w:document>
  </xsl:template>
</xsl:stylesheet>
