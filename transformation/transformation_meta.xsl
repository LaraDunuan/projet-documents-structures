<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" office:version="1.3"
    exclude-result-prefixes="xs meta text office"
    version="3.0">

    <xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="utf-8" indent="yes"/>
    
    <xsl:template match="office:meta">
        <xsl:result-document href="Wuthering-Heights-meta.xml" method="xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader xml:lang="en">
                    <fileDesc>
                        <titleStmt>
                            <title><xsl:value-of select="./meta:user-defined[@meta:name='Titre']"/></title>
                        </titleStmt>
                        <publicationStmt>
                            <authority/>
                            <availability>
                                <p><xsl:value-of select="./meta:user-defined[@meta:name='Licence']"/></p>
                            </availability>
                            <date><xsl:value-of select="./meta:user-defined[@meta:name='Date de publication']"/></date>
                        </publicationStmt>
                        <sourceDesc>
                            <bibl>
                                <title><xsl:value-of select="./meta:user-defined[@meta:name='Titre']"/></title>
                                <author><xsl:value-of select="./meta:user-defined[@meta:name='Auteur']"/></author>
                                <date><xsl:value-of select="./meta:user-defined[@meta:name='Date de la source']"/></date>
                                <bibl><xsl:value-of select="./meta:user-defined[@meta:name='Source']"/></bibl>
                            </bibl>
                        </sourceDesc>
                    </fileDesc>
                    
                    <encodingDesc>
                        <projectDesc>
                            <p><xsl:value-of select="./meta:user-defined[@meta:name='Description']"/></p>
                        </projectDesc>
                    </encodingDesc>
                    <profileDesc>
                        <creation>
                            
                        </creation>
                    </profileDesc>
                </teiHeader>
                <text>
                    <body>
                        <p>This is about the shortest TEI document imaginable.</p>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
