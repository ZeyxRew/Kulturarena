PREFIX :         <http://example.org/kulturarena/>
PREFIX xsd:      <http://www.w3.org/2001/XMLSchema#>
PREFIX bd:       <http://www.bigdata.com/rdf#>
PREFIX rdfs:     <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wd:       <http://www.wikidata.org/entity/>
PREFIX wdt:      <http://www.wikidata.org/prop/direct/>
PREFIX wikibase: <http://wikiba.se/ontology#>

INSERT {
  ?musician :hasMember ?memberIRI . 
  ?memberIRI a :Artist.
}
WHERE {
  ?concert :performedBy ?musician .
    ?musician :hasName ?name.
  SERVICE <https://query.wikidata.org/sparql> {
        ?darbieter rdfs:label ?name .   
        {
          ?darbieter wdt:P31 wd:Q5;    #darbieter is a person
               wdt:P106/(wdt:P279*) wd:Q639669.  #instance of musician
        } UNION{
            ?darbieter wdt:P31/wdt:P279* wd:Q2088357; #part of a Ensemble
                        wdt:P527 ?memberWiki.  #consists of memberwiki
         }
          SERVICE wikibase:label {bd:serviceParam wikibase:language "de".
              ?memberWiki rdfs:label ?memberNameLabel
          }
      }
  BIND(IRI(CONCAT("http://example.org/kulturarena/", LCASE(REPLACE(?memberNameLabel, " ", "" )))) AS ?memberIRI)
}