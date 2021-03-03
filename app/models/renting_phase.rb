class RentingPhase < ApplicationRecord
  belongs_to :contract
  has_one :invoice

  INVOICE_STATUS = [NOT = 0, YES = 1].freeze
  
  # @param [Class<Contract>] cot
  def self.create_infos_and_return_amount(cot)
    new_renting_phases cot
  end

  def self.all_save(renting_phases = [])
    RentingPhase.transaction do
      renting_phases.each(&:save!)
    end
  end

  # @param [Class<Contract>] cot
  def self.new_renting_phases(cot)
    renting_phases = []
    index = 0
    start_date = pay_date = cot.begin_date
    begin
      renting_phases.push(new_renting_phase(start_date, index, cot, pay_date))
      start_date = renting_phases[index].end_date.next_month.beginning_of_month
      pay_date = renting_phases[index].next_pay_date
      index += 1
    end while renting_phases[index - 1].end_date < cot.end_date
    renting_phases
  end

  def self.new_renting_phase(_start_date, _index, _cot, _pay_date)
    renting_phase = RentingPhase.new begin_date: _start_date,
                                     contract_index: _index,
                                     contract: _cot,
                                     invoice_status: NOT
    renting_phase.set_end_date _start_date, _cot.cycle, _cot.end_date
    renting_phase.calculate_pay _cot.amount_month
    renting_phase.pay_date = _pay_date
    renting_phase
  end

  def calculate_pay(month_money)
    self.amount_count = 0
    _end_date = _begin_date = begin_date
    begin
      _end_date = _begin_date.end_of_month
      _end_date = end_date if _end_date > end_date
      self.amount_count += ::PublicMethod.month_pay(_begin_date, _end_date, month_money)
      _begin_date = _begin_date.next_month.beginning_of_month
    end while _end_date != end_date
  end

  def next_pay_date
    Date.new end_date.year, end_date.month, 15
  end

  def set_end_date(_start_date, cycle, over_date)
    self.end_date = _start_date.next_month(cycle - 1).end_of_month
    min_end_date over_date
  end

  private
  def min_end_date(other_end_date)
    self.end_date = other_end_date if end_date > other_end_date
  end

  def months(date)
    date.year * 12 + date.month
  end

end
