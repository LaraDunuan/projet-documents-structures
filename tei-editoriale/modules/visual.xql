xquery version "3.1";

module namespace visual="http://exist-db.org/apps/tei-editoriale/visual";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace transform="http://exist-db.org/xquery/transform" ;
import module namespace config="http://exist-db.org/apps/tei-editoriale/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

(: Créer une table des matières dérivée des documents TEI stockés dans '/data' :)
declare function visual:toc($node as node(), $model as map(*)) {
    for $doc in collection($config:app-root || "/data")/tei:TEI
        return
        <li><a href="{concat('http://localhost:8080/exist/apps/tei-editoriale/affiche.html?document=',util:document-name($doc))}">{util:document-name($doc)}</a></li>   
};

(: Transformer un fichier XML en fichier HTML avec XSLT :)
declare function visual:XMLtoHTML ($node as node(), $model as map (*)) {
let $ref := xs:string(request:get-parameter("document", ()))
let $xml := doc(concat("/db/apps/tei-editoriale/data/",$ref))
let $xsl := doc(concat($config:app-root, "/resources/visual.xsl"))
let $params :=
<parameters>
   {for $p in request:get-parameter-names()
    let $val := request:get-parameter($p,())
    where  not($p = ("document","directory","stylesheet"))
    return
       <param name="{$p}"  value="{$val}"/>
   }
</parameters>

return
    transform:transform($xml, $xsl, $params)
};
