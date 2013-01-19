/**
 * Backbone localStorage Adapter
 * https://github.com/jeromegn/Backbone.localStorage
 */

(function(_, Backbone) {
// A simple module to replace `Backbone.sync` with *localStorage*-based
// persistence. Models are given GUIDS, and saved into a JSON object. Simple
// as that.

// Hold reference to Underscore.js and Backbone.js in the closure in order
// to make things work even if they are removed from the global namespace

// Generate four random hex digits.
function S4() {
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
};

// Generate a pseudo-GUID by concatenating random hexadecimal.
function guid() {
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
};

// Our Store is represented by a single JS object in *localStorage*. Create it
// with a meaningful name, like the name you'd give a table.
// window.Store is deprectated, use Backbone.LocalStorage instead
Backbone.LocalStorage = window.Store = function(name) {
  @name = name;
  var store = @localStorage().getItem(@name);
  @records = (store && store.split(",")) || [];
};

_.extend(Backbone.LocalStorage.prototype, {

  // Save the current state of the **Store** to *localStorage*.
  save: function() {
    @localStorage().setItem(@name, @records.join(","));
  },

  // Add a model, giving it a (hopefully)-unique GUID, if it doesn't already
  // have an id of it's own.
  create: function(model) {
    if (!model.id) {
        model.id = guid();
        model.set(model.idAttribute, model.id);
    }
    @localStorage().setItem(@name+"-"+model.id, JSON.stringify(model));
    @records.push(model.id.toString());
    @save();
    return model.toJSON();
  },

  // Update a model by replacing its copy in `@data`.
  update: function(model) {
    @localStorage().setItem(@name+"-"+model.id, JSON.stringify(model));
    if (!_.include(@records, model.id.toString())) @records.push(model.id.toString()); @save();
    return model.toJSON();
  },

  // Retrieve a model from `@data` by id.
  find: function(model) {
    return JSON.parse(@localStorage().getItem(@name+"-"+model.id));
  },

  // Return the array of all models currently in storage.
  findAll: function() {
    return _(@records).chain()
        .map(function(id){return JSON.parse(@localStorage().getItem(@name+"-"+id));}, this)
        .compact()
        .value();
  },

  // Delete a model from `@data`, returning it.
  destroy: function(model) {
    @localStorage().removeItem(@name+"-"+model.id);
    @records = _.reject(@records, function(record_id){return record_id == model.id.toString();});
    @save();
    return model;
  },

  localStorage: function() {
      return localStorage;
  }

});

// localSync delegate to the model or collection's
// *localStorage* property, which should be an instance of `Store`.
// window.Store.sync and Backbone.localSync is deprectated, use Backbone.LocalStorage.sync instead
Backbone.LocalStorage.sync = window.Store.sync = Backbone.localSync = function(method, model, options) {
  var store = model.localStorage || model.collection.localStorage;

  var resp, syncDfd = $.Deferred && $.Deferred(); //If $ is having Deferred - use it. 

  switch (method) {
    case "read":    resp = model.id != undefined ? store.find(model) : store.findAll(); break;
    case "create":  resp = store.create(model);                            break;
    case "update":  resp = store.update(model);                            break;
    case "delete":  resp = store.destroy(model);                           break;
  }

  if (resp) {
    if (options && options.success) options.success(resp);
    if (syncDfd) syncDfd.resolve();
  } else {
    if (options && options.error) options.error("Record not found");
    if (syncDfd) syncDfd.reject();
  }

  return syncDfd && syncDfd.promise();
};

Backbone.ajaxSync = Backbone.sync;

Backbone.getSyncMethod = function(model) {
  if(model.localStorage || (model.collection && model.collection.localStorage))
  {
    return Backbone.localSync;
  }

  return Backbone.ajaxSync;
};

// Override 'Backbone.sync' to default to localSync,
// the original 'Backbone.sync' is still available in 'Backbone.ajaxSync'
Backbone.sync = function(method, model, options) {
  return Backbone.getSyncMethod(model).apply(this, [method, model, options]);
};

})(_, Backbone);
