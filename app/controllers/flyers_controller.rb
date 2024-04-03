# app/controllers/flyers_controller.rb
class FlyersController < ApplicationController
  def generate_pdf
    pdf = FlyerPdf.new
    pdf_data = pdf.render

    send_data pdf_data, filename: 'flyer.pdf', type: 'application/pdf', disposition: 'inline'
  end

  def preview_image
    pdf_data = FlyerPdf.new.render
    image_data = pdf_to_image(pdf_data)

    send_data image_data, filename: 'preview_image.png', type: 'image/png', disposition: 'inline'
  end

  private

  def pdf_to_image(pdf_data)
    pdf_path = Tempfile.new(['flyer', '.pdf']).path
    image_path = Tempfile.new(['preview', '.png']).path

    File.open(pdf_path, 'wb') { |file| file.write(pdf_data) }

    MiniMagick::Tool::Convert.new do |convert|
      convert << pdf_path
      convert << image_path
    end

    File.read(image_path)
  ensure
    File.delete(pdf_path) if File.exist?(pdf_path)
    File.delete(image_path) if File.exist?(image_path)
  end
end

