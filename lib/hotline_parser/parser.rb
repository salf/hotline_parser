require 'nokogiri'

class Parser
  class Item < Struct.new(:id,
                          :img_url,
                          :name,
                          :product_name,
                          :high_price,
                          :low_price,
                          :mid_price
                         )
  end

  def initialize(body)
    @doc   = Nokogiri::HTML(body)
    @items = []
  end

  def parse_items
    catalog = @doc.search('.content.full.cf
                           #content2 table
                           #catalogue ul.catalog > li')
    catalog.map do |li|
      Item.new(
        get_product_id(li),
        get_image(li),
        get_name(li),
        get_product_name(li),
        get_high_price(li),
        get_low_price(li),
        get_mid_price(li)
      )
    end
  end

  def get_product_id(li)
    li.search('div.list-add-open').attr('data-id').value
  end

  def get_image(li)
    li.search('.img-box.pic-tooltip').attr('hltip').value
  end

  def get_name(li)
    li.search('.info .title-box .ttle a').first.text.strip
  end

  def get_product_name(li)
    href = li.search('.info .title-box .ttle a').first.attr(:href)
    href.split('/').last
  end

  def get_high_price(li)
    node = li.search('.price span.orng i.blck')
    if node.empty?
      get_mid_price(li)
    else
      node.children.text.split(' - ').last.gsub(/\D/, '').to_f
    end
  end

  def get_low_price(li)
    node = li.search('.price span.orng i.blck')
    if node.empty?
      get_mid_price(li)
    else
      node.children.text.split(' - ').first.gsub(/\D/, '').to_f
    end
  end

  def get_mid_price(li)
    node = li.search('.price span.orng').first
    return node.child.text.strip.gsub(/\D/, '').to_f if node
    0.0
  end
end
