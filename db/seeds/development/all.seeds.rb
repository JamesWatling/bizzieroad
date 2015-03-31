FactoryGirl.create(:user, :confirmed)

Provider.create(name: '2degrees', logo: '/assets/two_degrees_logo.png')
Provider.create(name: 'Vodafone', logo: '/assets/vodafone_marker.png')
Provider.create(name: 'Spark', logo: '/assets/missing.png')
