require 'hotline_parser/request'
require 'hotline_parser/parser'
require 'hotline_parser/image'
require 'hotline_parser/reporter'
require 'hotline_parser/version'
require 'yaml'

module HotlineParser
  include Image

  CONFIG = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '../config/settings.yml'))

  def self.page_info(url = '', type = 'app')
    prepare!

    url = prompt_url if type == 'prompt'

    request = Request.new(url)
    body    = request.make_request

    result = {}
    if body
      items  = Parser.new(body).parse_items
      count  = Image.process_images(items, @folder).count
      Reporter.new(items, count, type).print_results
    else
      result[:error] = 'Error while GETting hotline page'
    end

  rescue Exception => e
    puts "#{e.class.to_s} #{e.message}"
  end

  private

  def self.prepare!
    unless CONFIG['image_path']
      puts 'Please update config/settings.yml file'
    end
    @folder = CONFIG['image_path']
    FileUtils.mkdir_p(@folder).first unless File.directory?(@folder)
  end

  def self.prompt_url
    puts "Hotline URL ([Enter] for default: #{CONFIG['default_url']}):"
    input = gets.chomp.strip
    input.empty? ? CONFIG['default_url'] : input
  end
end
