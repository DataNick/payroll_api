FactoryBot.define do
    factory :job_group do
        group_code {'A'}
        hourly_wage {BigDecimal(20)}
    end
  end
  