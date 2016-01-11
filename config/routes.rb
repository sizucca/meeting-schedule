RoomSchedule::Application.routes.draw do

  root to: "schedule#index"

  get    "/new"         => "schedule#new",     as: "new"
  post   "/create"      => "schedule#create",  as: "create"
  delete "/destroy/:id" => "schedule#destroy", as: "destroy"

end
