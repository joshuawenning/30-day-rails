# Mixtape: Reading Code Before Writing It

Programmers spend more time reading code than writing it. Today is smaller on
purpose. You'll practice two habits: **predicting** what code will do before
you run it, and **writing small methods** that each do one thing.

The theme for the next few days is a mixtape: a playlist you'll keep adding to.

## 1. Concept: Read, Predict, Then Run

Here's a playlist stored as an array of hashes:

```ruby
MIXTAPE = [
  { title: "Paranoid Android", artist: "Radiohead",       seconds: 386 },
  { title: "Holocene",         artist: "Bon Iver",        seconds: 337 },
  { title: "Re: Stacks",       artist: "Bon Iver",        seconds: 401 },
  { title: "Nights",           artist: "Frank Ocean",     seconds: 307 },
  { title: "Motion Sickness",  artist: "Phoebe Bridgers", seconds: 229 }
]
```

### Warm-up: Predict the Output

Before you run anything, write down what you think each line prints. Then
paste it into `irb` and check. Don't worry about being wrong; finding out
*why* you were wrong is the point.

```ruby
p MIXTAPE.length
p MIXTAPE.first[:title]
p MIXTAPE.map { |track| track[:artist] }.uniq
p MIXTAPE.sum { |track| track[:seconds] }
p 386 / 60
p 386 % 60
```

The last two matter for today. `/` on two integers drops the remainder, and
`%` gives you only the remainder. Together they turn seconds into minutes and
seconds.

Two principles to remember:

- **Predict before you run**: Guessing first trains you to read code in your head.
- **Small methods**: A method should do one job and have a name that says what that job is.

## Assignment: Mixtape Stats

Create `mixtape.rb` with the `MIXTAPE` data above and these four methods. Each
one takes the playlist as an argument.

### Part A: `format_time(seconds)`

Turn a number of seconds into a `"m:ss"` string.

```ruby
format_time(386) # => "6:26"
format_time(65)  # => "1:05"
format_time(9)   # => "0:09"
```

Hint: look up `String#rjust`, or try `format("%02d", 5)`.

### Part B: `total_length(tracks)`

Return the total running time of the playlist as a `"m:ss"` string. Reuse
`format_time` instead of repeating its logic.

### Part C: `tracks_by(tracks, artist)`

Return an array of the titles by one artist.

```ruby
tracks_by(MIXTAPE, "Bon Iver") # => ["Holocene", "Re: Stacks"]
```

### Part D: `longest_track(tracks)`

Return the title of the longest track. Look up `max_by`.

**Design constraints**: Keep each method to a few lines. Don't change
`MIXTAPE` inside any method.

### Part E: Verify Implementation

Here's a starter `test_mixtape.rb`. Make it pass, then add at least one test of
your own for `tracks_by` with an artist who isn't on the playlist.

```ruby
require "minitest/autorun"
require_relative "mixtape"

class MixtapeTest < Minitest::Test
  def test_format_time
    assert_equal "6:26", format_time(386)
    assert_equal "0:09", format_time(9)
  end

  def test_total_length
    assert_equal "27:40", total_length(MIXTAPE)
  end

  def test_tracks_by
    assert_equal ["Holocene", "Re: Stacks"], tracks_by(MIXTAPE, "Bon Iver")
  end

  def test_longest_track
    assert_equal "Re: Stacks", longest_track(MIXTAPE)
  end
end
```

**Bonus**: Swap in five of your own favorite songs. Do your tests still pass?
Which ones break, and why?
