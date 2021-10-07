def create
  idea = Idea.new
  idea.title = params[:title]
  idea.done_count = params[:done_count]
  idea.photo_url = params[:photo_url]
  idea.save!
  redirect_to ideas_path
end


def create
  hash = { title: params[:title],
           done_count: params[:done_count],
           description: params[:description],
           photo_url: params[:photo_url] }
  idea = Idea.new(hash)
  idea.save!
  redirect_to ideas_path
end

def update
  idea = Idea.find (params[:id])
  idea.title = params[:title]
  idea.done_count = params[:done_count]
  idea.photo_url = params[:photo_url]
  idea.save!
  redirect_to account_ideas_path
end

def update
  hash = { title: params[:title],
           done_count: params[:done_count],
           description: params[:description],
           photo_url: params[:photo_url] }
  idea = Idea.last()
  idea.update(hash)
  redirect_to account_ideas_path
end
