class MainController < ApplicationController


require 'builder'



BOXES = [{:id=>0, :x=>5, :y=>1, :z=>19, :price=>52}, {:id=>1, :x=>7, :y=>9, :z=>24, :price=>72}, {:id=>2, :x=>1, :y=>10, :z=>8, :price=>75}, {:id=>3, :x=>0, :y=>15, :z=>1, :price=>43}, {:id=>4, :x=>1, :y=>15, :z=>12, :price=>83}, {:id=>5, :x=>1, :y=>3, :z=>0, :price=>61}, {:id=>6, :x=>9, :y=>4, :z=>22, :price=>69}, {:id=>7, :x=>9, :y=>8, :z=>1, :price=>4}, {:id=>8, :x=>8, :y=>5, :z=>24, :price=>56}, {:id=>9, :x=>6, :y=>6, :z=>10, :price=>97}]  


  def index
  end

  def generate_builder
    doc = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
    doc.boxes {
      BOXES.each{ |element_data|
      doc.box( "id" => element_data[:id] ){
        doc.x( element_data[:x] )
        doc.y( element_data[:y])
	doc.z(element_data[:z])
	doc.price (element_data[:price])  
        }
      }
    }
    return out_string
  end




end
