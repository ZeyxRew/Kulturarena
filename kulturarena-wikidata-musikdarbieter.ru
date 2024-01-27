BASE             <http://example.org/kulturarena/>
PREFIX xsd:      <http://www.w3.org/2001/XMLSchema#>
PREFIX bd:       <http://www.bigdata.com/rdf#>
PREFIX rdfs:     <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wd:       <http://www.wikidata.org/entity/>
PREFIX wdt:      <http://www.wikidata.org/prop/direct/>
PREFIX wikibase: <http://wikiba.se/ontology#>

INSERT {
  ?musician <hasMusicBrainzId> ?musicBrainzArtistId ;
      <hasGenre> ?genreLabel .
}
WHERE {
    ?concert <performedBy> ?musician .
    ?musician <hasName> ?name;
              <comesFrom> ?country.
     ?country <hasName> ?countryLabel.
  SERVICE <https://query.wikidata.org/sparql> {
    SELECT DISTINCT ?name ?musicBrainzArtistId  ?genreLabel 
    WHERE {
      ?darbieter wdt:P31 wd:Q5 ;   
          wdt:P106/wdt:P279* wd:Q639669 ;
              rdfs:label ?name .   
            OPTIONAL{?darbieter wdt:P136 ?genre .}
            OPTIONAL { ?darbieter wdt:P434 ?musicBrainzArtistId . }
        FILTER (?darbieter != wd:Q1403672 )
        SERVICE wikibase:label { bd:serviceParam wikibase:language "de" .
            ?genre rdfs:label ?genreLabel .
        }
    }  
  }
} 


