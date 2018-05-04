({
  handleEvent: function(component, event, helper) {
    // refresh Component A here
    var message = event.getParam("message");
    alert("Se modifica un record, voy a refrescar")
    alert(message);
}
})
