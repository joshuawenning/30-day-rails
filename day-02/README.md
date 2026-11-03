# Designing Ruby Objects with Clear Responsibilities

Take the same work-order problem and approach it through object-oriented design.
The objective isn't simply to write classes. It's to understand how to decide
which responsibilities belong to which objects.

## 1. Concept: Objects Own Behavior

Consider a work order represented by a hash:

```ruby
order = {
  id: 101,
  status: :open,
  blocked: false,
  priority: 2
}
```

You can inspect its status anywhere:

```ruby
order[:status] == :open && !order[:blocked]
```

But this spreads business rules throughout your application. If the definition
of a ready work order changes, you may have to update that logic in multiple
places. Instead, give the work order responsibility for answering that question.

```ruby
class WorkOrder
  def initialize(status:, blocked:)
    @status = status
    @blocked = blocked
  end

  def ready?
    @status == :open && !@blocked
  end
end

order = WorkOrder.new(
  status: :open,
  blocked: false
)

order.ready? # => true
```

Now other parts of your application don't need to know how readiness is
determined. They simply ask the object. This is **encapsulation**: keeping
related data and behavior together behind a clear interface.

Two principles to remember:

- **Single responsibility**: An object should have one coherent reason to change.
- **Composition**: Larger behaviors can be built by combining smaller objects.

## Assignment: Refactor the Work-Order Queue

Build two plain Ruby classes:

1. `WorkOrder`: Represents one work order. Knows its own attributes and
whether it is ready.
2. `WorkOrderQueue`: Holds a collection of `WorkOrder` objects. Knows how to
prioritize them and calculate assigned hours.

### Part A: Define `WorkOrder`

Your class should accept these keyword arguments:

```ruby
WorkOrder.new(
  id: 101,
  status: :open,
  blocked: false,
  priority: 2,
  due_on: "2026-11-05",
  assignee: "Maya",
  hours: 3
)
```

- An initializer that stores all seven attributes
- Reader methods for the attributes, without allowing external code to reassign
them
- A `ready?` instance method returning true only when the work order is open and
  unblocked
- Use `attr_reader` where appropriate

### Part B: Define `WorkOrderQueue`

The queue should accept an array of `WorkOrder` instances:

```ruby
queue = WorkOrderQueue.new([
  WorkOrder.new(
    id: 101,
    status: :open,
    blocked: false,
    priority: 2,
    due_on: "2026-11-05",
    assignee: "Maya",
    hours: 3
  )
])
```

Implement two public instance methods:

1. `ready_ids`: returns the IDs of ready work orders, ordered by highest
priority, earliest due date, and lowest ID.

2. `hours_by_assignee`: returns a hash of total estimated hours for each
assignee, considering only ready work orders.

**Design constraints**: The queue must call each work order's `ready?` method
rather than duplicating its logic. Use Enumerable for collection processing.
Avoid class variables, global state, and unnecessary inheritance. Do not mutate
the original collection. You may introduce private helper methods if they make
the implementation clearer.

### Part C: Verify Implementation
