BASE             <http://example.org/kulturarena/>
PREFIX rdfs:     <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf:      <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xsd:      <http://www.w3.org/2001/XMLSchema#>
PREFIX http:     <http://www.w3.org/2011/http#>
PREFIX bd:       <http://www.bigdata.com/rdf#>
PREFIX wd:       <http://www.wikidata.org/entity/>
PREFIX wdt:      <http://www.wikidata.org/prop/direct/>
PREFIX wikibase: <http://wikiba.se/ontology#>

INSERT {
   ?musician <hasMusicBrainzId> ?musicBrainzArtistId ;
            <hasGenre> ?genreLabel;
            <hasBirthYear> ?geburtsjahr.
}
WHERE {
  ?concert <performedBy> ?musician .
  ?musician a <Musician>;
            <hasName> ?name;
            <comesFrom> ?country.
   ?country <hasName> ?countryLabel.
  SERVICE <https://query.wikidata.org/sparql> {
    SELECT DISTINCT ?name ?musicBrainzArtistId  ?genreLabel ?geburtsdatum
    WHERE {
      ?darbieter wdt:P106/(wdt:P279*) wd:Q639669 ;  #darbieter is instance of musician
              rdfs:label ?name .   
            OPTIONAL{?darbieter wdt:P136 ?genre .}
            OPTIONAL { ?darbieter wdt:P434 ?musicBrainzArtistId . }
            OPTIONAL{?darbieter wdt:P569 ?geburtsdatum . }
        FILTER (?darbieter != wd:Q1403672 )
        SERVICE wikibase:label { bd:serviceParam wikibase:language "de" .
            ?genre rdfs:label ?genreLabel .

        }
    }  
  }
  BIND(YEAR(?geburtsdatum) AS ?geburtsjahr)
} 


