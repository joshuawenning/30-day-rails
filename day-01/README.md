# Think in Ruby: Collections and Enumerable

## Concept

Ruby's `Enumerable` module provides methods for working with collections without manually managing counters or indexes.

`select` - Which items meet a condition?
`reject` - Which items should be excluded?
`map` - How should each item be transformed?
`sort_by` - How should these items be ordered?
`group_by` - How can items be categorized?
`sum` - What's the total of these values?

### Example
```
numbers = [3, 8, 12, 5, 9]

numbers.select(&:even?)
# => [8, 12]

numbers.map { |n| n * 2 }
# => [6, 16, 24, 10, 18]
```

## Assignment: Work Order Queue

Build a small, standalone Ruby program that prioritizes work orders. Use Ruby's Enumerable methods rather than explicit `for` or `while` loops. Do not mutate the original array. Use this starting data:

```
```
```
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
```

## Implement Two Methods

### A. `ready_work_orders(orders)`

Return an array of work-order IDs that:
- Have status :open and are not blocked.
- Are sorted by highest priority first (3 before 2).
- Within the same priority, are sorted by earliest due date.
- For matching priority and due date, use the lowest ID first.

### B. `hours_by_assignee(orders)`

Return a hash containing the total estimated hours assigned to each person, considering only open, unblocked orders. The hash key order does not matter.

## Verify Work

Create `test_work_order_queue.rb` using Ruby's built-in Minitest.
