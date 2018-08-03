require 'open-uri'
require 'nokogiri'

class NokogiriModifying
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

  def creating_new_nodes
    h1.add_next_sibling "<h3>1977 - 1984</h3>"
    doc.to_html
  end

  def wrapping_node_set
    nodes = doc.css "h1,div"
    nodes.wrap("<div class='container'></div>")
    doc.to_html
  end
end

puts NokogiriModifying.new.doc
puts '-' * 100
puts NokogiriModifying.new.changing_text_contents
puts '-' * 100
puts NokogiriModifying.new.assigns_parent
puts '-' * 100
puts NokogiriModifying.new.add_next_sibling
puts '-' * 100
puts NokogiriModifying.new.modify_nodes_and_attribute
puts '-' * 100
puts NokogiriModifying.new.creating_new_nodes
puts '-' * 100
puts NokogiriModifying.new.wrapping_node_set
