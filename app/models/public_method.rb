class PublicMethod
  class << self
    def month_pay(_begin_date, _end_date, month_money)
      if _begin_date.day == 1 && _end_date.day == _end_date.end_of_month.day
        month_money.round(-1)
      else
        days_money(_end_date.day - _begin_date.day + 1, month_money).round(-1)
      end
    end

    def days_money(days, month_money)
      month_money * 12 / 365.00 * days
    end
  end
end