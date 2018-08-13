json.partial! "v1/comments/comment", comment: @comment
json.replies do
  json.array! @comment.comments do |c|
    json.partial! "v1/comments/comment", comment: c
  end
end