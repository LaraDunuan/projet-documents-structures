<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" office:version="1.3"
    exclude-result-prefixes="xs meta text office"
    version="3.0">
    
    <xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="utf-8" indent="yes"/>
        
    <xsl:template match="office:text">
        <xsl:result-document href="Wuthering-Heights-content.xml" method="xml">
            <text>
                <body>
                    <xsl:apply-templates/>
                </body>
            </text>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="office:text/text:h">
        <xsl:if test="self::*[@text:style-name='Heading_20_1']">
            <div n="1">
                <head>
                    <xsl:value-of select="."/>
                </head>
            </div>
        </xsl:if>
        <xsl:if test="self::*[@text:style-name='Heading_20_2']">
            <div n="2">
                <head>
                    <xsl:value-of select="."/>
                </head>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="office:text/text:p">
        <xsl:if test="self::*[@text:style-name='Title']">
            <head>
                <xsl:value-of select="."/>
            </head>
        </xsl:if>
        <xsl:if test="self::*[@text:style-name='citation']">
            <div>
                <quote>
                    <xsl:apply-templates/>
                </quote>
            </div>
        </xsl:if>
        <xsl:if test="self::*[@text:style-name='Text_20_body']">
            <div>
                <p>
                    <xsl:apply-templates/>
                </p>
            </div>  
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="office:text/text:p/text:span">
        <xsl:if test="self::*[@text:style-name='gras']">
            <hi rend="bold">
                <xsl:value-of select="."/>
            </hi>
        </xsl:if>
        <xsl:if test="self::*[@text:style-name='italique']">
            <hi rend="italic">
                <xsl:value-of select="."/>
            </hi>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>