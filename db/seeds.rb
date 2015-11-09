# User.create!([
#   {name: "Lewis Z Matos", age: nil, gender: "male", image: "http://graph.facebook.com/1485775778392162/picture", cover: "https://scontent.xx.fbcdn.net/hphotos-xap1/t31.0-8/s720x720/906044_1455612988075108_7604148912649146806_o.jpg", email: "lewm20@gmail.com", encrypted_password: "$2a$10$QwkThQ5MVGIReySdkldtNu3kRYNDxYM.RE/G3UwfsSok5Lss3Aavy", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2015-10-22 15:35:49", last_sign_in_at: "2015-10-22 15:08:46", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: "facebook", uid: "1485775778392162"}
# ])

#bio data taken from http://laurenhallden.com/datingipsum/
girl_bio = []
guy_bio = []
File.open("#{Rails.root}/public/seed_data/dtg_girl_bio_semi.csv") do |row|
  row.read.each_line do |line|
    girl_bio << line 
  end
end
File.open("#{Rails.root}/public/seed_data/dtg_guy_bio_semi.csv") do |row|
  row.read.each_line do |line|
    guy_bio << line 
  end
end
bio = [girl_bio, guy_bio]
turn_two = 0
turn = 0
28.times do |i|
	turn_two += turn
  turn = i % 2
	male_images = Dir.glob("#{Rails.root}/app/assets/images/stock_images/male/*.jpg")
  female_images = Dir.glob("#{Rails.root}/app/assets/images/stock_images/female/*.jpg")
  male_female_images = [female_images,male_images]
  array = [FactoryHelper::Name.female_first_name,FactoryHelper::Name.male_first_name]
User.create!([
	{name: array[turn], age: rand(20..50), gender: ["female","male"][turn], image: male_female_images[turn][turn_two].split('/images/')[1], cover: "https://scontent.xx.fbcdn.net/hphotos-xap1/t31.0-8/s720x720/906044_1455612988075108_7604148912649146806_o.jpg", bio: bio[turn].sample, email: FactoryHelper::Internet.email(array[turn]),password: Devise.friendly_token[0,20], reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2015-10-22 15:35:49", last_sign_in_at: "2015-10-22 15:08:46", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", provider: "facebook", uid: FactoryHelper::Internet.password(10)}
])
end

User.create!([name: "admin", admin: true,password: "12345678",email: "admin@admin.com"])


Event.create!([
  {title: "House of Vans: Television, Viet Cong, Lower Dens", venue: "House of Vans", street_number: 25, street_name: "Franklin Street", city: "Brooklyn", state: "NY", zip: 11222, description: "House of Vans Presents: the final event of the carnival and light-themed series brings brings forth a rare performance by heavyweight New York rock icons Television. Television will be joined by Canadian post-punks Viet Cong and the genre-bending synth-pop of Baltimore's Lower Dens. DJ Brandon Stosuy from Pitchfork will set the vibe of an evening filled with music, art and good times. Guests can keep summer alive with carnival treats, games and prizes, and free beer. ", cost: "free", tickets: "rsvp: https://houseofvansbrooklyn.queueapp.com/events/13097", url: "http://www.vans.com/article_detail/hov-presents-event3.html", image: "/assets/id1-HOV_Presents_Event3_Flyer.jpeg", category: "Concert", date: "2015-10-08", time: "2000-01-01 20:00:00"},
  {title: "The Art of John Lennon 75th Anniversary Exhibition", venue: "AFA Gallery", street_number: 54, street_name: "Green Street", city: "New York", state: "NY", zip: 10013, description: "Opening reception for an exhibition of the extraordinary artworks of John Lennon. All artwork is on exhibition and available for acquisition October 1st through October 31st of 2015. All events are complimentary and open to the public. This presentation is significant in its curation, celebrating the 75th Birthday Anniversary of John Lennon, and will feature programming throughout the exhibition period.", cost: "free", tickets: "rsvp: rsvp@afanyc.com", url: "http://afanyc.com/john-lennon/john-lennon-press-release/", image: "/assets/id2-self-portrait.jpg", category: "Art", date: "2015-10-01", time: "2000-01-01 18:00:00"},
  {title: "Monegraph Release Party", venue: "The New Museum", street_number: 235, street_name: "Bowery Street", city: "New York", state: "NY", zip: 10002, description: "Monegraph is redefining how media will be consumed, created and distributed. We are excited to extend this invitation for you and your guests to join our celebration. This will be a monumental event in history - and the beginning of a media revolution. Exclusive DJ Set: Slava", cost: "free", tickets: "rsvp: https://monegraphreleaseparty.splashthat.com/", url: "https://monegraphreleaseparty.splashthat.com/", image: "/assets/id3-monegraph.png", category: "Art, Party", date: "2015-09-28", time: "2000-01-01 19:30:00"},
  {title: "Fable featuring Blonde Redhead / Prince Rama", venue: "The Knockdown Center", street_number: 52, street_name: "Flushing Ave", city: "Queens", state: "NY", zip: 11378, description: "Filmmaker Derrick Belcham (La Blogotheque, A Story Told Well) and choreographer Emily Terndrup (Sleep No More) present FABLE, a new evening-length production set in Knockdown’s sprawling 50,000-square-foot space. The production features a giant, sound-reactive enclosure that showcases a different, acclaimed musician for each of the six performances, a 360-degree sound environment and an expansive array of transforming light systems from floor to ceiling. In a shifting proscenium, an unpredictable choreographic and theatrical narrative immerses the audience.", cost: "$25.00", tickets: "http://www.ticketweb.com/snl/VenueListings.action?venueId=279334", url: "http://knockdown.center/event/fable/", image: "/assets/id4-fable.jpg", category: "Concert, Art", date: "2015-10-16", time: "2000-01-01 20:00:00"},
  {title: "Fable featuring Skyler Skjelset (Fleet Foxes, Beach House) / Julianna Barwick", venue: "The Knockdown Center", street_number: 52, street_name: "Flushing Ave", city: "Queens", state: "NY", zip: 11378, description: "Filmmaker Derrick Belcham (La Blogotheque, A Story Told Well) and choreographer Emily Terndrup (Sleep No More) present FABLE, a new evening-length production set in Knockdown’s sprawling 50,000-square-foot space. The production features a giant, sound-reactive enclosure that showcases a different, acclaimed musician for each of the six performances, a 360-degree sound environment and an expansive array of transforming light systems from floor to ceiling. In a shifting proscenium, an unpredictable choreographic and theatrical narrative immerses the audience.", cost: "$25.00", tickets: "http://www.ticketweb.com/snl/VenueListings.action?venueId=279334", url: "http://knockdown.center/event/fable/", image: "/assets/id5-fable-box.jpg", category: "Concert, Art", date: "2015-10-17", time: "2000-01-01 20:00:00"},
  {title: "High Line Open Studios", venue: "The High Line, Chelsea", street_number: 526, street_name: "West 26th Street", city: "New York", state: "NY", zip: 10001, description: "The artists of High Line Open Studios invite the public to step inside their private studios during the Fall 2015 art season.  On this self-guided tour, visitors will have exclusive access to private artists' studios based in the heart of the West Chelsea Arts District, where visitors will have access to over 50 private artists' studios in more than 10 buildings. The artists will open their doors to the public on Saturday, Sunday, October 17-18, 2015.  The self guided tour begins at the West Chelsea Arts Building on West 26th Street. Pick up the MAP and event information in the lobbies at 508 and 516 West 26th St.", cost: "free", tickets: "none", url: "http://highlineopenstudios.org/", image: "/assets/id6-HLOS-October2015-6x6.jpg", category: "Art", date: "2015-10-18", time: "2000-01-01 12:00:00"},
  {title: "Laurie Anderson: Habeus Corpus", venue: "Park Avenue Armory", street_number: 643, street_name: "Park Ave", city: "New York", state: "NY", zip: 10065, description: "Former Guantánamo Bay detainee Mohammed el Gharani—imprisoned for seven years beginning when he was just fourteen—is the subject of this new work by iconic musician and performance artist Laurie Anderson. Gharani, who still can't travel to the US despite never having been charged, is live-streamed into the massive Armory drill hall onto a statue that replicates his body. Filling the space is a soundscape originally created by Anderson's late husband Lou Reed, and in the evenings, a musical performance co-created with tUnE-yArDs' Merrill Garbus takes place.", cost: "$15", tickets: "https://commerce.armoryonpark.org/single/PSDetail.aspx?psn=806", url: "http://armoryonpark.org/programs_events/detail/laurie_anderson", image: "/assets/id8-habeas-corpus.jpg", category: "Art", date: "2015-10-02", time: "2000-01-01 20:00:00"},
  {title: "St. Marks Is Dead", venue: "Cooper Union", street_number: 7, street_name: "East 7th Street", city: "New York", state: "NY", zip: 10003, description: "Ada Calhoun's new book St. Marks Is Dead: The Many Lives of America's Hippest Street is and being celebrated with a release party at Cooper Union. Hear about the street’s history, have a free beer from Brooklyn Brewery, and listen to a performance by the St. Mark’s Zeroes ( a one-night-only punk cover band featuring Ada's husband, aka rapper/performance artist Champagne Jerry, Champagne Jerry's collaborator Adam Horovitz aka Ad-Rock of Beastie Boys, and Carmine Covelli of Adam's wife Kathleen Hanna's band The Julie Ruin. Special guests are promised, including drag king legend Murray Hill.", cost: "free", tickets: "none", url: "https://adacalhoun.files.wordpress.com/2009/09/adacalhoun_invite.jpg", image: "/assets/id9-st-marks-dead.jpg", category: "Reading, Party, Concert", date: "2015-11-02", time: "2000-01-01 18:00:00"},
  {title: "Tequila Partida & Whitewall", venue: "Soho Arts Club", street_number: 76, street_name: "Wooster Street", city: "New York", state: "NY", zip: 10003, description: "Tequila Partida and Whitewall invite you to preview Partida Loteria, a collaboration with artist Alejandro Vigilante celebrating the vibrant colors and flavors of Mexico, at the former SoHo residence of Andy Warhol.", cost: "rsvp", tickets: "rsvp: partidatequila@whitewallmag.com", url: "http://www.whitewallmag.com/lifestyle/partida-loteria-blending-premium-tequila-a-game-of-chance-and-pop-art", image: "/assets/id10-partida-loteria.png", category: "Art, Party", date: "2015-10-28", time: "2000-01-01 19:00:00"},
  {title: "Party United, Ray-Ban", venue: "Bushwick", street_number: 23, street_name: "Meadow Street", city: "Brooklyn", state: "NY", zip: 11206, description: "Ray-Ban presents Party United with performances by: Blood Orange, Empress Of, and Jonathan Toubin. In partnership with VICE and Campaign4Change. Open bar.", cost: "free", tickets: "rsvp: http://partyunited-rsvp.vice.com/?em=537", url: "http://partyunited-rsvp.vice.com/?em=537", image: "/assets/id11-ray-ban.jpg", category: "Concert, Party", date: "2015-10-22", time: "2000-01-01 21:00:00"},
  {title: "El Jimador Wall Brawl", venue: "Freehold", street_number: 45, street_name: "South 3rd Street", city: "Brooklyn", state: "NY", zip: 11249, description: "Watch New York's top street artist battle it out live during El Jimador's Wall Brawl New York where they'll compete against each other for the piece that best represents and celebrates El Jimador's Mexican heritage through Day of The Dead inspired art. Cast your vote to help determine the champion of Wall Brawl while enjoying complimentary cocktails provided by El Jimador.", cost: "free", tickets: "rsvp: https://www.squadup.com/events/eljimador-wallbrawl", url: "https://www.squadup.com/events/eljimador-wallbrawl", image: "/assets/id12-jimador.png", category: "Art, Party", date: "2015-11-02", time: "2000-01-01 20:00:00"}

])

