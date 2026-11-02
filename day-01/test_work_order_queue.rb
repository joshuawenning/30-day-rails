require "minitest/autorun"
require_relative "work_order_queue"

class WorkOrderQueueTest < Minitest::Test
  def test_empty_collection
    assert_equal [], ready_work_orders([])
    assert_equal({}, hours_by_assignee([]))
  end

  def test_ready_work_orders
    assert_equal [102, 106, 105, 101],
    ready_work_orders(WORK_ORDERS.reverse)
  end

  def test_hours_by_assignee
    expected = { "Maya" => 5, "Eli" => 5, "Derek" => 1 }
    assert_equal expected, hours_by_assignee(WORK_ORDERS)
  end
end
