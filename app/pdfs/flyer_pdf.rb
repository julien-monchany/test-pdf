# app/pdfs/flyer_pdf.rb
class FlyerPdf
  include Prawn::View
  def initialize(name = 'World')
    @name = name
    say_hello
  end

  WIDTH_MM = 115
  HEIGHT_MM = 158.5
  ROOT_PATH = '/Users/julien.monchany/repos/testPdf/app/pdfs'.freeze

  def document
    @document ||= Prawn::Document.new(page_size: [width, height], margin: 0)
  end

  def width
    WIDTH_MM / 25.4 * 72
  end

  def height
    HEIGHT_MM / 25.4 * 72 - 0.01
  end

  def say_hello
    font("#{ROOT_PATH}/SwileNova-Bold.ttf")
    svg(IO.read("#{ROOT_PATH}/front.svg"), position: :center, width:, height:)
    fill_color 'ff0000'
    draw_text 'Hello World', at: [100, 100], color: 'FF0000'
    start_new_page
    font('Courier') do
      text('Hello new page!')
    end
  end
end
