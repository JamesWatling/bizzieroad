# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service, :class => 'Services' do
    company nil
    provider nil
  end
end
