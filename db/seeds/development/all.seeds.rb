FactoryGirl.create(:user, :confirmed)

Provider.create(name: '2degrees', image: '/assets/two_degrees_logo.png')
Provider.create(name: 'Vodafone', image: '/assets/vodafone_marker.png')
Provider.create(name: 'Spark', image: '/assets/missing.png')
