# Job 方便综合的定时任务，简化了定时部分的内容如队列优先等
class Job
  class << self
    # date - 3天前的生成日期，默认定时任务传入,
    # @param [Class<Date>] date
    def generate_invoice(date)
      rps = RentingPhase.where(pay_date: date.to_date..date.to_date.next_day(3),
                               invoice_status: RentingPhase::NOT)
      rps.each do |rp|
        invoice = Invoice.get_invoice_by_renting_phase rp
        rp.invoice = invoice
        rp.invoice_status = RentingPhase::YES
        rp.save
      end
    end
  end
end