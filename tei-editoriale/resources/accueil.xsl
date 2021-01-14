<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    
    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="doc">
        <xsl:result-document href="index.html" method="html">
        <div xmlns="http://www.w3.org/1999/xhtml" data-template="templates:surround" data-template-with="templates/page.html" data-template-at="content">
            <xsl:apply-templates/>
        </div>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="info">
        <div class="row">
            <div class="col-md-12">
                <div id="header">
                    <h1>
                        <xsl:value-of select="//info/titre"/>
                    </h1>
                    <h4>
                        <xsl:value-of select="//info/formation"/>
                    </h4>
                    <h4>
                        <xsl:value-of select="//info/auteur"/>
                    </h4>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="contenu">
        <div id="contenu">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="art">
        <div class="row">
            <div class="col-md-12">
                <div>
                    <xsl:if test="self::*[@nom='welcome']">
                        <h3>
                            <xsl:value-of select="./@titre"/>
                        </h3>
                    </xsl:if>
                    <xsl:if test="self::*[@nom='site']">
                        <h3>
                            <xsl:value-of select="./@titre"/>
                        </h3>
                    </xsl:if>
                    <xsl:if test="self::*[@nom='navi']">
                        <h3>
                            <xsl:value-of select="./@titre"/>
                        </h3>
                    </xsl:if>
                    <xsl:if test="self::*[@nom='diff']">
                        <h3>
                            <xsl:value-of select="./@titre"/>
                        </h3>
                    </xsl:if>
                    <xsl:apply-templates/>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="texte">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="lien">
        <a href="{./@url}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
</xsl:stylesheet>