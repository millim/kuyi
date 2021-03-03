class Invoice < ApplicationRecord
  belongs_to :contract
  belongs_to :renting_phase
  has_many :line_items

  # @param [Class<RentingPhase>] renting_phase
  def self.get_invoice_by_renting_phase(renting_phase)
    contract = renting_phase.contract
    invoice = Invoice.new begin_date: renting_phase.begin_date,
                          end_date: renting_phase.end_date,
                          pay_date: renting_phase.pay_date,
                          amount_count: renting_phase.amount_count
    invoice.contract = contract
    invoice.line_items = LineItem.get_line_items_by_invoice invoice, contract.amount_month
    invoice
  end


end
