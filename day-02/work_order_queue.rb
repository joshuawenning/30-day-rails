class WorkOrderQueue
  def initialize(work_orders)
    @work_orders = work_orders
  end

  def ready_ids
    ready_orders
      .sort_by { |order| [-order.priority, order.due_on, order.id] }
      .map { |order| order.id }
  end

  def hours_by_assignee
    ready_orders.each_with_object(Hash.new(0)) do |order, totals|
      totals[order.assignee] += order.hours
    end
  end

  private

  def ready_orders
    @work_orders.select { |order| order.ready? }
  end
end
