xml.item do
  xml.title( instrument.title )
  xml.description( instrument.description )
  xml.link( instrument.url )
  xml.pubDate( instrument.date_laid.rfc822 )
end