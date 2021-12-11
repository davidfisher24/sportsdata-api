class SportsController < ApplicationController
  
  API_SERVICE = "https://m.betvictor.com/bv_in_play/v2/en-gb/1/mini_inplay.json"

  def sports
    json = cache_fetch(API_SERVICE, 600) { proxy_request(API_SERVICE) }
    response = cache_fetch(request.env['PATH_INFO']) { get_sports(json) }
    json_response(response)
  end

  def events
    json = cache_fetch(API_SERVICE, 600) { proxy_request(API_SERVICE) }
    response = cache_fetch(request.env['PATH_INFO']) { get_events(json,:sport_id) }
    json_response(response)
  end

  def outcomes
    json = cache_fetch(API_SERVICE, 600) { proxy_request(API_SERVICE) }
    events = cache_fetch("/sports/#{params[:sport_id]}") { get_events(json,:sport_id) }
    response = cache_fetch(request.env['PATH_INFO']) { get_outcomes(events,:event_id) }
    json_response(response)
  end

  def get_sports(json)
    sports = []
    json["sports"].each do |sport|
      obj = {
        'desc' => sport["desc"],
        'hasInplayEvents' => sport["hasInplayEvents"],
        'hasUpcomingEvents' => sport["hasUpcomingEvents"],
        'id' => sport["id"],
        'pos' => sport["pos"]
      }
      sports << obj
    end
    return sports.sort! { |a,b| a["pos"] <=> b["pos"] }
  end

  def get_events(json, sport_id)
    sport = json["sports"].find {|v| v['id'] == params[sport_id].to_i}
    if !sport
      raise NotFoundError
    end
    events = []
    sport["comp"].each do |competition|
      competition["events"].each do |event|
        events << event
      end
    end
    return events.sort! { |a,b| a["pos"] <=> b["pos"] }
  end

  def get_outcomes(events, event_id)
    event = events.find{|v| v["id"] == params[event_id].to_i}
    if !event
      raise NotFoundError
    end
    outcomes = []
    event["markets"].each do |market|
      market["o"].each do |outcome|
        outcomes << outcome
      end
    end
    return outcomes.sort! { |a,b| a["po"] <=> b["po"] }
  end

end
