xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( 'Made Statutory Instruments laid before the UK Parliament' )
    xml.description( 'Updates whenever a negative or affirmative Statutory Instrument is laid before a House in the UK Parliament' )
    xml.link( 'https://made-n-laid.herokuapp.com/' )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.managingEditor( 'somervillea@parliament.uk (Anya Somerville)' )
    xml.pubDate( @instruments.first.date_laid.rfc822 )
    xml.tag!( 'atom:link', { :href => "https://made-n-laid.herokuapp.com/instruments.rss", :rel => 'self', :type => 'application/rss+xml' } )
    xml.item do
      xml.guid( "https://api.parliament.uk/made-n-laid/rss" )
      xml.title( "House move" )
      xml.description( "This RSS feed has moved home." )
      xml.link( "https://api.parliament.uk/made-n-laid/rss" )
      xml.pubDate( "Sat 8 Jan 2022 00:00:00 +0000" )
    end
    xml << render(:partial => 'instrument', :collection => @instruments )
  end
end


