json.partial! "v1/lists/list", list: @list
json.cards do
  json.array! @list.cards do |c|
    json.partial! "v1/cards/card", card: c
  end
end