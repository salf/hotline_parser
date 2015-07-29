class Reporter
  def initialize(items, count, type)
    @result = {}
    @type   = type
    @items  = items
    @downloaded_count = count
  end

  def print_results
    if @type == 'prompt'
      puts most_cheapest_as_string
      puts most_expensive_as_string
      puts avg_price_as_string
      puts "Downloaded images: #{@downloaded_count}"
    else
      @result[:downloaded_img_count] = @downloaded_count
      @result[:max_value_item] = most_expensive
      @result[:min_value_item] = most_cheapest
      @result[:avg_price]      = avg_price
      @result
    end
  end

  def most_cheapest_as_string
    item = most_cheapest
    "Most cheapest - #{item.name} - #{item.mid_price}"
  end

  def most_cheapest
    item = @items.min_by{|i| i.low_price}
  end

  def most_expensive_as_string
    item = most_expensive
    "Most expensive - #{item.name} - #{item.mid_price}"
  end

  def most_expensive
    @items.max_by{|i| i.high_price}
  end

  def avg_price_as_string
    text = 'Average price on current page: %s'
    text % avg_price
  end

  def avg_price
    return 0 if @items.size.zero?
    @items.map(&:mid_price).inject(0, :+) / @items.size
  end

end