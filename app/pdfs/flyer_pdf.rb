# app/pdfs/flyer_pdf.rb
class FlyerPdf
  include Prawn::View
  def initialize(name = 'World')
    @name = name
    say_hello
  end

  def document
    @document ||= Prawn::Document.new(page_size: 'A4', margin: 30)
  end

  def say_hello
    stroke do
      self.line_width = 10
      stroke_gradient [200, 50], 45, [200, 50], 70.71, '000000', 'ffffff'
      rounded_rectangle [0, 100], 100, 200, 20
    end
    font('Courier') do
      text("Hello, #{@name}!")
    end
  end
end
