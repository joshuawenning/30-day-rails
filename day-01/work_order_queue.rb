WORK_ORDERS = [
  { id: 101, status: :open, blocked: false,
    priority: 2, due_on: "2026-11-05",
    assignee: "Maya", hours: 3 },

  { id: 102, status: :open, blocked: false,
    priority: 3, due_on: "2026-11-04",
    assignee: "Eli", hours: 5 },

  { id: 103, status: :open, blocked: true,
    priority: 3, due_on: "2026-11-03",
    assignee: "James", hours: 2 },

  { id: 104, status: :completed, blocked: false,
    priority: 3, due_on: "2026-11-02",
    assignee: "Eli", hours: 4 },

  { id: 105, status: :open, blocked: false,
    priority: 3, due_on: "2026-11-06",
    assignee: "Derek", hours: 1 },

  { id: 106, status: :open, blocked: false,
    priority: 3, due_on: "2026-11-04",
    assignee: "Maya", hours: 2 }
]

def ready_work_orders(orders)
  orders
    .select { |order| order[:status] == :open && !order[:blocked] }
    .sort_by { |order| [-order[:priority], order[:due_on], order[:id]] }
    .map { |order| order[:id] }
end

def hours_by_assignee(orders)
  orders
    .select { |order| order[:status] == :open && !order[:blocked] }
    .each_with_object(Hash.new(0)) do |order, totals|
      totals[order[:assignee]] += order[:hours]
    end
end

p ready_work_orders(WORK_ORDERS)
p hours_by_assignee(WORK_ORDERS)
