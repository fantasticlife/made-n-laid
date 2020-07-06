require 'net/http'
require 'uri'
require 'json'

task :import => [
  :import_from_sparql] do
end

task :import_from_sparql => :environment do
  puts "importing raw data from sparql query"
  from_date = 5.days.ago.to_date
  to_date = Date.today

  uri = URI.parse("https://api.parliament.uk/sparql")
  
  request = Net::HTTP::Post.new(uri)
  
  request["Accept"] = "application/sparql-results+json"
  
  request.set_form_data(
    "query" => "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                PREFIX : <https://id.parliament.uk/schema/>
                PREFIX id: <https://id.parliament.uk/>
                select distinct ?SI ?SIname ?workPackage ?procedureId ?Procedure ?layingBodyName ?Madedate ?LaidDate ?Link where {
                  ?SI a :StatutoryInstrumentPaper .  
                ?SI rdfs:label ?SIname ;
                :laidThingHasLaying/:layingHasLayingBody/:name ?layingBodyName;
                :laidThingHasLaying/:layingDate ?LaidDate.
                OPTIONAL { ?SI :workPackagedThingHasWorkPackagedThingWebLink ?Link .}
                OPTIONAL { ?SI :statutoryInstrumentPaperMadeDate ?Madedate .}
      	        ?SI :workPackagedThingHasWorkPackage ?workPackage .
    	          ?workPackage :workPackageHasProcedure ?procedureId.
                ?procedureId :name ?Procedure.
                FILTER (?procedureId IN (id:iWugpxMn, id:5S6p4YsP))
                FILTER ( str(?LaidDate) >= '#{from_date}' && str(?LaidDate) <= '#{to_date}')
                }",
  )

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  
  json = JSON( response.body )
  puts "found #{json['results']['bindings'].size} instruments"
  json['results']['bindings'].each do |instrument_json|
    instrument = Instrument.where( instrument_uri: instrument_json["SI"]["value"].strip ).first
    unless instrument
      instrument = Instrument.new
      instrument.title = instrument_json["SIname"]["value"].strip
      instrument.procedure = instrument_json["Procedure"]["value"].strip.split(" ").last
      instrument.laying_body = instrument_json["layingBodyName"]["value"].strip
      instrument.date_made = instrument_json["Madedate"]["value"].strip
      instrument.date_laid = instrument_json["LaidDate"]["value"].strip
      instrument.instrument_uri = instrument_json["SI"]["value"].strip
      instrument.work_package_uri = instrument_json["workPackage"]["value"].strip
      instrument.tna_uri = instrument_json["Link"]["value"].strip
      #instrument.save
    end
  end
end