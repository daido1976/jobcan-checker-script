require 'open-uri'
require 'nokogiri'

class NokogiriDemo
  attr_reader :doc, :h1, :div

  def initialize
    @doc = Nokogiri::HTML::DocumentFragment.parse <<-EOHTML
    <body>
    <h1>Three's Company</h1>
    <div>A love triangle.</div>
    </body>
    EOHTML
    @h1  = doc.at_css "h1"
    @div = doc.at_css "div"
  end

  def changing_text_contents
    h1.content = "Snap, Crackle & Pop"
    doc.to_html
  end

  def assigns_parent
    h1.parent = div
    doc.to_html
  end

  def add_next_sibling
    div.add_next_sibling(h1)
    doc.to_html
  end

  def modify_nodes_and_attribute
    h1.name = 'h2'
    h1['class'] = 'show-title'
    doc.to_html
  end
end

puts NokogiriDemo.new.doc
puts '-' * 100
puts NokogiriDemo.new.changing_text_contents
puts '-' * 100
puts NokogiriDemo.new.assigns_parent
puts '-' * 100
puts NokogiriDemo.new.add_next_sibling
puts '-' * 100
puts NokogiriDemo.new.modify_nodes_and_attribute
