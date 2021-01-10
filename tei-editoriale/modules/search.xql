xquery version "3.1";

module namespace search="http://exist-db.org/apps/tei-editoriale/search";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace transform="http://exist-db.org/xquery/transform" ;
import module namespace config="http://exist-db.org/apps/tei-editoriale/config" at "config.xqm";
import module namespace app="http://exist-db.org/apps/tei-editoriale/templates" at "app.xql";
import module namespace kwic = "http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";
import module namespace ft = "http://exist-db.org/xquery/lucene";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = 'http://www.functx.com';

(: Trouver les documents ayant pour titre  :)
declare function search:get_title($node as node(), $model as map (*), $titre as xs:string?, $case as xs:boolean?) {
    if ($titre) then
        if ($case = 'sensitive') then
            for $doc in collection($config:app-root, '/data')//tei:titleStmt/tei:title[contains(text(), $titre)]
                return <p>{$doc/string()}</p>
        else
            for $doc in collection($config:app-root, '/data')//tei:titleStmt/tei:title[contains(lower-case(./text()), lower-case($titre))]
                return <p>{$doc/string()}</p>
    else
        ()
};

(: Trouver le nom du document :)
declare function search:find_doc($node as node(), $model as map (*), $document as xs:string?) {
    if ($document) then
        for $doc in collection($config:app-root, '/data')//tei:titleStmt/tei:title[text() = $document]
            return <p>"{$document}" est dans {util:document-name($doc)}</p>
    else
        ()
};

(: Afficher les titres, auteurs disponibles dans la base de données XML :)
declare function search:find_meta($node as node(), $model as map (*), $metaName as xs:string?) {
    if ($metaName) then
        if ($metaName = "title") then
            for $doc in collection($config:app-root || "/data")
                return <p>{distinct-values($doc//tei:sourceDesc/tei:bibl/tei:title/string())}</p>
        else if ($metaName = "author") then
            for $doc in collection($config:app-root || "/data")
                return <p>{distinct-values($doc//tei:sourceDesc/tei:bibl/tei:author/string())}</p>
        else
            ()
    else
        ()
};

declare function functx:substring-after-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {
    replace ($arg,concat('^.*',$delim),'')
 };

(: Concordance  :)
declare function search:concordance($node as node(), $model as map (*)) {
    if (request:get-parameter("searchexpr", "") !="") then
    let $searchterm as xs:string:= request:get-parameter("searchexpr", "")
    for $hit in collection(concat($config:app-root, '/data'))//tei:p[ft:query(.,$searchterm)]
       let $href := concat(search:hrefToDoc($hit), "&amp;searchexpr=", $searchterm)
       let $score as xs:float := ft:score($hit)
       order by $score descending
       return
       <tr>
           <td>{$score}</td>
           <td>{kwic:summarize($hit, <config width="40" link="{$href}" />)}</td>
           <td>{search:getDocName($hit)}</td>
       </tr>
    else
       <div>No search results</div>
 };

(: Renvoie le nom du document :) 
declare function search:getDocName($node as node()){
    let $name := functx:substring-after-last(document-uri(root($node)), '/')
    return $name
};

(: Renvoie une chaîne qui contient un lien vers affiche.html avec le nom d'un document :)
declare function search:hrefToDoc($node as node()){
    let $name := functx:substring-after-last($node, '/')
    let $href := concat('affiche.html','?document=', search:getDocName($node))
        return $href
};

 (: Effectuer une recherche plein texte sur tous les documents ou un document particulier :)
declare function search:byauthor($node as node(), $model as map (*)) {
    if (request:get-parameter("searchExpr", "") !="" and request:get-parameter("authorName", "") !="") then
        if (request:get-parameter("authorName", "") = "tous") then
            let $searchterm as xs:string:= request:get-parameter("searchExpr", "")
            let $searchauthor as xs:string:= request:get-parameter("authorName", "")
            for $hit in collection(concat($config:app-root, '/data'))//tei:p[ft:query(.,$searchterm)]
            let $href := concat(search:hrefToDoc($hit), "&amp;searchExpr=", $searchterm)
            let $score as xs:float := ft:score($hit)
            order by $score descending
            return
               <tr>
                   <td>-</td>
                   <td>{$score}</td>
                   <td>{kwic:summarize($hit, <config width="40" link="{$href}" />)}</td>
                   <td>{search:getDocName($hit)}</td>
               </tr>
        else
            let $searchterm as xs:string:= request:get-parameter("searchExpr", "")
            let $searchauthor as xs:string:= request:get-parameter("authorName", "")
            for $hit in collection(concat($config:app-root, '/data'))//tei:p[preceding::tei:author[$searchauthor] and ft:query(.,$searchterm)]

            let $href := concat(search:hrefToDoc($hit), "&amp;searchExpr=", $searchterm)
            let $score as xs:float := ft:score($hit)
            order by $score descending
            return
               <tr>
                   <td>{$searchauthor}</td>
                   <td>{$score}</td>
                   <td>{kwic:summarize($hit, <config width="40" link="{$href}" />)}</td>
                   <td>{search:getDocName($hit)}</td>
               </tr>
    else
       <div>No search results</div>
 };