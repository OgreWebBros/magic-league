namespace :cards do
  desc "populate cards of passed in set_code"
  task :populate, [:set_code] => [:environment] do|task, args|
    #get cards from passed in set_code
    response = {"has_more" => true, "next_page" => "https://api.scryfall.com/cards/search?order=name&q=e:#{args[:set_code]}"}
    until !response['has_more'] do
      response = JSON.parse(RestClient.get(response['next_page']))
      response['data'].each do |card|
        puts "Processing #{card['name']}"
        resource = Card.find_or_create_by(name: card['name'])
        resource.description = card['text']
        if card['image_uris']
          resource.image_url = card['image_uris']['png']
        elsif card['card_faces']
          first_face = card['card_faces'].first
          if first_face['image_uris']
            resource.image_url = first_face['image_uris']['png']
          else
            puts "Couldn't find an image_url for #{card['name']}"
          end
        else
          puts "Couldn't find an image_url for #{card['name']}"
        end
        resource.multiverse_id = card['multiverse_ids'].first
        resource.set = args[:set_code]
        resource.oracle_text = card['oracle_text']
        resource.type_line = card['type_line']
        resource.mana_cost = card['mana_cost']
        resource.cmc = card['cmc']
        resource.colors = card['colors']
        resource.rarity = card['rarity']
        resource.save!
      end
    end
    
  end
end
