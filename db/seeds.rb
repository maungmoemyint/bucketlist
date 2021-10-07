admin = User.create! email:'neill@epfl.ch', password: 'password', name: 'Neill', role: 'admin'
user1 = User.create! email:'paula@epfl.ch', password: 'password', name: 'Paula'
user2 = User.create! email:'adam@epfl.ch', password: 'password', name: 'Adam'
user3 = User.create! email:'sarah@epfl.ch', password: 'password', name: 'Sarah'

1.upto(5) do |i|
  Idea.create! title: "Idea for #{admin.name} #{i}", user: admin
  Idea.create! title: "Idea for #{user1.name} #{i}", user: user1
  Idea.create! title: "Idea for #{user2.name} #{i}", user: user2
  Idea.create! title: "Idea for #{user3.name} #{i}", user: user3
end

admin.goals << user1.ideas.first
admin.goals << user2.ideas.first
admin.goals << user3.ideas.first
