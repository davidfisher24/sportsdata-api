Rails.application.routes.draw do
  get '/sports', to: 'sports#sports', as: 'sports'
  get '/sports/:sport_id', to: 'sports#events', as: 'events'
  get '/sports/:sport_id/events/:event_id', to: 'sports#outcomes', as: 'outcomes'
end

