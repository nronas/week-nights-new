class MovieParser
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def parse
    return nil if data.blank?

    parsed_data = Nokogiri::HTML(data)

    payload(parsed_data)
  end

  private

  def payload(parsed_data)
    {
      image_url: primary_image_from(parsed_data),
      title: title_from(parsed_data),
      rating: rating_from(parsed_data),
      description: description_from(parsed_data)
    }
  end

  def description_from(parsed_data)
    description = parsed_data.css('p[itemprop=description]')

    if description.present?
      description.text.strip
    else
      nil
    end
  end

  def rating_from(parsed_data)
    rating = parsed_data.css('.titlePageSprite.star-box-giga-star')

    if rating.present?
      rating.text.strip
    else
      nil
    end
  end

  def title_from(parsed_data)
    title = parsed_data.css('h1.header')

    if title.present?
      title.text.strip.gsub(/\s+/, ' ')
    else
      ''
    end
  end

  def primary_image_from(parsed_data)
    primary_photo = parsed_data.css('#title-overview-widget #img_primary .image a img').first

    if primary_photo.present?
      primary_photo.attributes['src'].value
    else
      nil
    end
  end
end
