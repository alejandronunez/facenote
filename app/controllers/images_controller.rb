class ImagesController < ApplicationController
  def upload
    # byebug
    if(params['image']&&params['image']['name']&&params['image']['file'])
      image = Image.create({:name=> params['image']['name'], :content=> params['image']['file']})
      render :json => image.to_json({:methods => :content_url})
      return
    end
    render :json => {error:'tester'}
  end

end