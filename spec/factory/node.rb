FactoryBot.define do 
	factory :node do 
		sequence(:parent_id) { |n| n }
	end
end
