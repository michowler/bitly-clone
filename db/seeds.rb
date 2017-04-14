require 'csv'

def shorten
	return ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(7).join
end

values = []

CSV.foreach("db/urls.csv") do |row|

  long_url = row[0].match(/http:\/\/.+\)/).to_s.delete(")")
  short_url = shorten
  click_count = 0
  values << "('#{long_url}','#{short_url}', '#{click_count}')"

end

values = values.join(",") + ";"

Url.transaction do
  Url.connection.execute "INSERT INTO urls (long_url, short_url, click_count) VALUES #{values}"
end 