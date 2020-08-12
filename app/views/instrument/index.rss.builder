xml.rss( :version => '2.0') do
  xml.channel do
    xml.title( 'Made Statutory Instruments laid before the UK Parliament' )
    xml.description( 'Updates whenever a negative or affirmative Statutory Instrument is laid before a House in the UK Parliament' )
    xml.link( 'https://made-n-laid.herokuapp.com/' )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.managingEditor( 'somervillea@parliament.uk' )
    xml.pubDate( @instruments.first.date_laid.rfc822 )
    xml << render(:partial => 'instrument', :collection => @instruments )
  end
  
end

