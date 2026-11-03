require "minitest/autorun"
require_relative "work_order"
require_relative "work_order_queue"

class WorkOrderQueueTest < Minitest::Test
  def setup
    @orders = [
      WorkOrder.new(
        id: 101, status: :open, blocked: false,
        priority: 2, due_on: "2026-11-05",
        assignee: "Maya", hours: 3
      ),
      WorkOrder.new(
        id: 102, status: :open, blocked: false,
        priority: 3, due_on: "2026-11-04",
        assignee: "Eli", hours: 5
      ),
      WorkOrder.new(
        id: 103, status: :open, blocked: true,
        priority: 3, due_on: "2026-11-03",
        assignee: "Maya", hours: 2
      ),
      WorkOrder.new(
        id: 104, status: :completed, blocked: false,
        priority: 3, due_on: "2026-11-02",
        assignee: "Eli", hours: 4
      ),
      WorkOrder.new(
        id: 105, status: :open, blocked: false,
        priority: 3, due_on: "2026-11-04",
        assignee: "Maya", hours: 2
      )
    ]

    @queue = WorkOrderQueue.new(@orders)
  end

  def test_readiness_belongs_to_work_order
    assert @orders[0].ready?
    refute @orders[2].ready?
    refute @orders[3].ready?
  end

  def test_ready_ids_are_prioritized
    assert_equal [102, 105, 101], @queue.ready_ids
  end

  def test_hours_by_assignee
    assert_equal(
      { "Maya" => 5, "Eli" => 5 },
      @queue.hours_by_assignee
    )
  end

  def test_empty_queue
    queue = WorkOrderQueue.new([])

    assert_equal [], queue.ready_ids
    assert_equal({}, queue.hours_by_assignee)
  end
end
