class Contract < ApplicationRecord

  has_many :renting_phases
  has_many :invoices

  validates_presence_of :user_name, message: '必须填写名字信息'
  validates_presence_of :begin_date, message: '必须选择开始日期'
  validates_presence_of :end_date, message: '必须选择结束日期'
  validates :cycle, presence: { message: '必须填写交付周期' }
  validates :amount_month, presence: { message: '必须填写每月租金' }


  validate :end_time_be_greater_than_begin_time


  before_create do
    renting_phases = RentingPhase.create_infos_and_return_amount self
    self.amount_count = renting_phases.map(&:amount_count).sum
    self.renting_phases = renting_phases
  end

  PRICE_UNIT = 1_000

  def end_time_be_greater_than_begin_time
    return if begin_date.nil? || end_date.nil?

    errors.add(:end_time, '结束日期必须大于开始日期') if begin_date > end_date
  end

  def price=(price)
    return if price.blank?

    self.amount_month = (price.to_f * PRICE_UNIT).to_i
  end


end
