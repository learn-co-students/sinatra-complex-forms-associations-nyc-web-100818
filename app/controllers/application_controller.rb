class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  patch '/owners/:id' do

    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])

    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end

  patch '/pets' do
    binding.pry

    @pet = Pet.find(params[:id])

    @pet.update(params["pet"])

    redirect to "pets/#{@pet.id}"
  end
  
end
