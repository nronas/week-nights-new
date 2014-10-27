class ImdbSearchResult
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def results
    Nokogiri::HTML(data).css('table.findList tr.findResult').map do |result|
      build_result(result)
    end
  end

  private
  def build_result(result_data)
    {
      primary_photo: primary_photo_from(result_data),
      url: url_from(result_data),
      text: text_from(result_data)
    }
  end

  def text_from(result_data)
    result = result_data.css('.result_text')

    result.present? ? result.text.strip : ''
  end

  def url_from(result_data)
    url = result_data.css('.result_text a').first

    if url.present?
      url.attributes['href'].value
    else
      nil
    end
  end

  def primary_photo_from(result_data)
    primary_photo = result_data.css('.primary_photo a img').first

    if primary_photo.present?
      primary_photo.attributes['src'].value
    else
      nil
    end
  end
end
