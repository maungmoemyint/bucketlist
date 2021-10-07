Ideas = {};

Ideas.removeIdeaCard = function (ideaId) {
  document.getElementById("idea-" + ideaId).parentElement.remove();
};

// document.getElementById("idea-<%= @idea.id %>").parentElement.remove();
// we can not use <%= @idea.id %>" in JS script above
