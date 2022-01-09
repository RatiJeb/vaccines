class Booking < ApplicationRecord
  include AASM

  aasm :column => 'step_state', whiny_persistance: true do
    state :pending, initial: true
    state :patient_upserted, :reserved, :finished

    event :upsert_patient do
      transitions from: :pending, to: :patient_upserted
    end
    
    event :reserve do
      transitions from: :patient_upserted, to: :reserved
    end

    event :cancel_reserve do
      transitions from: :reserved, to: :patient_upserted
    end

    event :finish do
      transitions from: :reserved, to: :finished
    end
  end

  scope :with_patients, -> { where(patient: present?) }

  belongs_to :vaccine, class_name: 'VaccineItem', foreign_key: :vaccine_id
  belongs_to :patient, optional: true
end
