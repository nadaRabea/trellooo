json.partial! "v1/cards/card", card: @card
json.comments do
  json.array! @card.comments do |c|
    json.partial! "v1/comments/comment", comment: c
  end
end