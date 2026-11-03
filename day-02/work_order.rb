class WorkOrder
  attr_reader :id, :status, :blocked, :priority, :due_on, :assignee, :hours

  def initialize(id:, status:, blocked:, priority:, due_on:, assignee:, hours:)
    @id = id
    @status = status
    @blocked = blocked
    @priority = priority
    @due_on = due_on
    @assignee = assignee
    @hours = hours
  end

  def ready?
    @status == :open && !@blocked
  end
end

order = WorkOrder.new(
  id: 101,
  status: :open,
  blocked: false,
  priority: 2,
  due_on: "2026-11-05",
  assignee: "Maya",
  hours: 3
)

p order.id        # => 101
p order.assignee  # => "Maya"
p order.hours     # => 3
p order.ready?    # => true


