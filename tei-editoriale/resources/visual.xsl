<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="3.0">
    <xsl:template match="/">
        <br/>
        
        <div class="panel panel-default">
            <div class="panel-heading">
                    <h3 class="panel-title" align="right">
                        <xsl:for-each select="//tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </h3>
                    <h3 class="panel-author" align="right">
                        <xsl:for-each select="//tei:fileDesc/tei:sourceDesc/tei:bibl/tei:author">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </h3>
                    <h3 class="panel-date" align="right">
                        <xsl:for-each select="//tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </h3>
                </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <h4>
                            Jump to :
                        </h4>
                        <xsl:element name="ul">
                            <xsl:for-each select="//tei:body//tei:head">
                                <xsl:element name="li">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            <xsl:text>#text_</xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">
                                            <xsl:text>nav_</xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </div>
                    <div class="col-md-8">
                        <p>
                            <xsl:apply-templates select="//tei:body"/>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:if test="parent::*[@n='1']">
            <xsl:element name="h3">
                <xsl:element name="a">
                    <xsl:attribute name="id">
                        <xsl:text>text_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>#nav_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
        <xsl:if test="parent::*[@n='2']">
            <xsl:element name="h4">
                <xsl:element name="a">
                    <xsl:attribute name="id">
                        <xsl:text>text_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>#nav_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
        <xsl:if test="not(parent::*[@n='1']) and not(parent::*[@n='2'])">
            <xsl:element name="h2">
                <xsl:element name="a">
                    <xsl:attribute name="id">
                        <xsl:text>text_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>#nav_</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <xsl:element name="q">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:if test="self::*[@rend='bold']">
            <xsl:element name="b">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="self::*[@rend='italic']">
            <xsl:element name="i">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>