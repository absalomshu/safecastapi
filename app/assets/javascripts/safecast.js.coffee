jQuery ->
  window.Measurement = Backbone.Model.extend
    defaults:
      value: '000'
    
    url: '/api/measurements'
  
  window.AppView = Backbone.View.extend
    el: $("#page"),
    render: ->
      $(this.el).html("Welcome to Safecast")

  window.SubmissionsView = Backbone.View.extend
    el: $("#page"),
    
    events: {
      'submit #submission' : 'manifest',
      'submit #manifest'   : 'create'
    }
    
    template: ->
      path = if(@model.get('id'))
        'submissions/complete'
      else if(@model.get('value') != '000')
        'submissions/manifest'
      else
        'submissions/new'
      Mustache.to_html(Templates[path], @model.toJSON())
    
    render: ->
      $(this.el).html(@template())
      @.$('#level').select().focus()
      return @
    
    manifest: ->
      @model.set({value: $('#level').val()})
      @render()
      false
    
    create: ->
      @model.save {}, {
          success: =>
            @render()
        }
      false
  
  
  window.HomeRouter = Backbone.Router.extend
    routes:
      "*actions": "show"

    show: ->
      appView.render()
  
  window.SubmissionsRouter = Backbone.Router.extend
    routes:
      "my/submissions/new": "new"
    
    new: ->
      measurement = new Measurement()
      new SubmissionsView({model: measurement}).render()
      
  
  appView = new AppView()
  window.homeRouter = new HomeRouter()
  window.submissionsRouter = new SubmissionsRouter()
  Backbone.history.start({pushState: true, root: '/'})