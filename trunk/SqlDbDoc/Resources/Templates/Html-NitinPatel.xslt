<?xml version="1.0" encoding="utf-8"?>
<!-- XSL Template for converting the XML documentation to HTML -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output
        method="html"
        indent="yes"
        omit-xml-declaration="yes"
        media-type="text/html"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        encoding="utf-8" />

    <xsl:template match="/">
        <html>
        <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>
            <xsl:value-of select="concat(/database/@name, ' Database Schema')" />
        </title>
            <style>
                body {
                font-family:verdana;
                font-size:10pt;
                }
                td {
                font-family:verdana;
                font-size:10pt;
                }
                th {
                font-family:verdana;
                font-size:10pt;
                background:#d3d3d3;
                }
                table
                {
                background:#d3d3d3;
                }
                tr
                {
                background:#ffffff;
                }
            </style>
        </head>
        <body>
            <!-- Table of contents -->
            <xsl:call-template name="TableOfContents"/>
            <!-- Process all schemas -->
            <xsl:for-each select="/database/schema">
                <xsl:sort select="@name"/>
                <xsl:variable name="SchemaName" select="@name" />
                <!-- Process tables in schema -->
                <xsl:for-each select="/database/object[@type='USER_TABLE' and @schema=$SchemaName]">
                    <xsl:sort select="@name"/>
                    <xsl:call-template name="SingleDbTableOrView" />
                </xsl:for-each>
                <xsl:for-each select="/database/object[@type='VIEW' and @schema=$SchemaName]">
                    <xsl:sort select="@name"/>
                    <xsl:call-template name="SingleDbTableOrView" />
                </xsl:for-each>

            </xsl:for-each>
            
        </body>
        </html>
    </xsl:template>

    <xsl:template name="TableOfContents">
        <div id="toc">
            <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center"><tr><td colspan="4" style="height:50px;font-size:14pt;text-align:center;"><a name="index"></a><b>Index</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%" align="center">
                <tr><th>No.</th><th style="width:300px;">Object</th><th>Description</th><th>Type</th></tr>
                <xsl:for-each select="/database/object[@type='USER_TABLE']">
                    <xsl:sort select="@name"/>
                    <tr class="table">
                        <td width="65px" align="center">
                            <xsl:value-of select="position()"/>
                        </td>
                        <td>
                            <a href="#{@id}">
                                <xsl:value-of select="concat('[', @schema, '].[', @name, ']')"/>
                            </a>
                        </td>
                        <td>
                            <xsl:value-of select="@description"/>
                        </td>
                        <td>
                            Table
                        </td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="/database/object[@type='VIEW']">
                    <xsl:sort select="@name"/>
                    <tr class="view">
                        <td width="65px" align="center">
                            <xsl:value-of select="count(/database/object[@type='USER_TABLE']) + position()"/>
                        </td>
                        <td>
                            <a href="#{@id}">
                                <xsl:value-of select="concat('[', @schema, '].[', @name, ']')"/>
                            </a>
                        </td>
                        <td>
                            <xsl:value-of select="@description"/>
                        </td>
                        <td>
                            View
                        </td>
                    </tr>
                </xsl:for-each>
            </table><br />
        </div>
    </xsl:template>

    <xsl:template name="SingleDbTableOrView">
        <br /><br /><br />
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr><td align="right"><a href="#index">Index</a></td></tr>
            <tr><th align="left"><a name="{@id}"></a><b><xsl:choose>
                    <xsl:when test="@type='USER_TABLE'">Table:</xsl:when>
                    <xsl:when test="@type='VIEW'">View:</xsl:when>
                </xsl:choose>
                <xsl:value-of select="concat('[', @schema, '].[', @name, ']')"/></b></th></tr>
        </table><br />
        <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Description</b></td></tr><tr><td><xsl:value-of select="@description"/></td></tr></table><br />
        <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Table Columns</b></td></tr></table>
        <table border="0" cellspacing="1" cellpadding="0" width="100%">
            <tr><th>No.</th><th>Name</th><th>Datatype</th><th>Nullable</th><th>Description</th></tr>
            <xsl:for-each select="column">
                <tr>
                    <td width="7%" align="center"><xsl:value-of select="position()"/></td>
                    <td width="20%"><xsl:value-of select="@name"/></td>
                    <td class="type" width="20%">
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
                    </td>
                    <td class="null" width="10%" align="center">
                        <xsl:choose>
                            <xsl:when test="@nullable='true'">Y</xsl:when>
                            <xsl:otherwise>N</xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td width="43%">
                        <!-- <xsl:if test="@identity='true'">
                            <span class="flag">IDENTITY</span>
                        </xsl:if> -->
                        <!-- <xsl:if test="@computed='true'">
                            <span class="flag">COMPUTED</span>
                        </xsl:if> -->
                        <!-- <xsl:if test="default">
                            <span class="flag">
                                <xsl:value-of select="concat('DEFAULT ', default/@value)"/>
                            </span>
                        </xsl:if> -->
                        <xsl:value-of select="@description"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table><br />
        <!-- reference key -->
        <xsl:if test="count(refrence) > 0">
            <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Refrence Keys</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%"><tr><th>No.</th><th>Name</th><th>Column</th><th>Reference To</th></tr>
                <xsl:for-each select="refrence">
                <tr>
                    <td width="7%" align="center">
                        <xsl:value-of select="position()"/>
                    </td>
                    <td width="20%">
                        <xsl:value-of select="@name"/>
                    </td>
                    <td width="10%">
                        <xsl:value-of select="@columnName"/>
                    </td>
                    <td width="63%">
                        <xsl:value-of select="concat('[', @referenceObjectName, '].[', @referenceColumnName, ']')"/>
                    </td>
                </tr>
                </xsl:for-each>
            </table><br />
        </xsl:if>
        <!-- Default Constraints -->
        <xsl:if test="count(defaultConstraint) > 0">
            <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Default Constraints</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%"><tr><th>No.</th><th>Name</th><th>Column</th><th>Value</th></tr>
            <xsl:for-each select="defaultConstraint">
                <tr>
                    <td width="7%" align="center">
                        <xsl:value-of select="position()"/>
                    </td>
                    <td width="20%">
                        <xsl:value-of select="@name"/>
                    </td>
                    <td width="20%">
                        <xsl:value-of select="@columnName"/>
                    </td>
                    <td width="53%">
                        <xsl:value-of select="@definition"/>
                    </td>
                </tr>
            </xsl:for-each>
            </table><br />
        </xsl:if>
        <!-- Check Constraints -->
        <xsl:if test="count(checkConstraint) > 0">
            <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Check  Constraints</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%"><tr><th>No.</th><th>Name</th><th>Column</th><th>Definition</th></tr>
                <xsl:for-each select="checkConstraint">
                    <tr>
                        <td width="7%" align="center">
                            <xsl:value-of select="position()"/>
                        </td>
                        <td width="20%">
                            <xsl:value-of select="@name"/>
                        </td>
                        <td width="20%">
                            <xsl:value-of select="@columnName"/>
                        </td>
                        <td width="53%">
                            <xsl:value-of select="@definition"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </table><br />
        </xsl:if>
        <!-- Triggers -->
        <xsl:if test="count(trigger) > 0">
            <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Triggers</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%"><tr><th>No.</th><th>Name</th><th>Description</th></tr>
                <xsl:for-each select="trigger">
                    <tr>
                        <td width="7%" align="center">
                            <xsl:value-of select="position()"/>
                        </td>
                        <td width="350px">
                            <xsl:value-of select="@name"/>
                        </td>
                        <td></td>
                    </tr>
                </xsl:for-each>
            </table><br />
        </xsl:if>
        <!-- Indexes -->
        <xsl:if test="count(index) > 0">
            <table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td><b>Indexes</b></td></tr></table>
            <table border="0" cellspacing="1" cellpadding="0" width="100%"><tr><th>No.</th><th>Name</th><th>Type</th><th>Columns</th></tr>
            <xsl:for-each select="index">
                <tr>
                    <td width="7%" align="center">
                        <xsl:value-of select="position()"/>
                    </td>
                    <td width="20%">
                        <xsl:value-of select="@name"/>
                    <td width="20%">
                        <xsl:value-of select="@type"/>
                    </td>
                    </td>
                    <td width="53%">
                        <xsl:for-each select="column">
                            <xsl:value-of select="@name"/><br/>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:for-each>
            </table><br />
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
