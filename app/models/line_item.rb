class LineItem < ApplicationRecord
  belongs_to :invoice


  DATE_TYPE = [DAYS = 0, MONTH = 1].freeze

  # @param [Class<Invoice>] invoice
  def self.get_line_items_by_invoice(invoice, amount_month)
    _begin_date = invoice.begin_date
    line_items = []
    begin
      _end_date = _begin_date.end_of_month
      _end_date = invoice.end_date if _end_date > invoice.end_date
      line_items.push new_line_item_by_invoice(_begin_date,
                                               _end_date,
                                               amount_month)
      _begin_date = _begin_date.next_month.beginning_of_month
    end while _end_date != invoice.end_date
    line_items
  end

  def self.new_line_item_by_invoice(begin_date, end_date, amount_month)
    line_item = LineItem.new begin_date: begin_date,
                             end_date: end_date
    line_item.data_update(amount_month)
    line_item
  end

  def data_update(amount_month)
    self.date_type = is_month_type? ? MONTH : DAYS
    self.amount_count = self.unit_price = amount_month if is_month?
    if is_days?
      self.unit_price = (amount_month * 12 / 365).round(-1)
      # 这里不考虑小数后3位后的精度
      self.amount_count = (end_date.day - begin_date.day + 1) * unit_price
    end
  end

  private

  def is_month_type?
    begin_date.day == 1 && end_date.day == end_date.end_of_month.day
  end

  def is_days?
    self.date_type == DAYS
  end

  def is_month?
    self.date_type == MONTH
  end

end
