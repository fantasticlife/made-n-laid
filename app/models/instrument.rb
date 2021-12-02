class Instrument < ActiveRecord::Base
  
  def description
    description = ''
    description = description + self.title
    description = description + '. Made on '
    description = description + self.date_made.strftime( '%d-%m-%Y')
    description = description + ', laid on '
    description = description + self.date_laid.strftime( '%d-%m-%Y')
    description = description + '. Subject to the '
    description = description + self.procedure
    description = description + ' procedure.'
    description
  end
  
  def tweet_text
    tweet_text = ''
    tweet_text = tweet_text + self.short_title
    tweet_text = tweet_text + '. Made on '
    tweet_text = tweet_text + self.date_made.strftime( '%d-%m-%Y')
    tweet_text = tweet_text + ', laid on '
    tweet_text = tweet_text + self.date_laid.strftime( '%d-%m-%Y')
    tweet_text = tweet_text + '. Subject to the '
    tweet_text = tweet_text + self.procedure
    tweet_text = tweet_text + ' procedure. '
    tweet_text = tweet_text + self.url
    tweet_text
  end
  
  def short_title
    if self.title.length > 200
      title = self.title[0, 198] + '..'
    else
      title = self.title
    end
    title
  end
  
  def url
    'https://statutoryinstruments.parliament.uk/instrument/' + self.instrument_id + '/timeline/' + self.work_package_id + '/'
  end
  
  def instrument_id
    self.instrument_uri.split( '/' ).last
  end
  
  def work_package_id
    self.work_package_uri.split( '/' ).last
  end
end
