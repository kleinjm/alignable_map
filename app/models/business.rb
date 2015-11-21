# A wrapper for our API data that we are consuming but not persisting
class Business
  include ActiveModel::Model

  attr_accessor(
    :id,
    :name,
    :latitude,
    :longitude,
    :address1,
    :address2,
  )

  validates :id, presence: true

  # sometimes we only have address1 or address2 so handle the comma appropriately (a little fizzbuzz-ish)
  def full_address
    "#{address1}#{', ' unless address1.blank? or address2.blank?}#{address2}"
  end
end