json.extract! post, :id, :content, :username, :user_id, :community_id, :community_header, :created_at, :updated_at
json.url post_url(post, format: :json)
