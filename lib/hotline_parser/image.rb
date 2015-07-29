require 'hotline_parser/array'
require 'open-uri'

module Image
  def self.process_images(items, folder)
    images_for_save = items.map do |item|
      name = get_image_name(item)
      file = File.join(folder, name)
      unless File.exist?(file)
        { file_name: file, url: item.img_url }
      end
    end

    images_for_save.compact.async_map do |img|
      save_image(img)
    end
  end

  def self.get_image_name(item)
    "#{item.product_name}-#{item.id}#{File.extname(item.img_url)}"
  end

  def self.save_image(img)
    open(img[:file_name], 'wb') do |file|
      file << open("http://hotline.ua/#{img[:url]}").read
    end
  end
end