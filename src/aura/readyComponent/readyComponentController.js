({
	//Esta funcion se conecta con el controllador y trae todos los works que preciso
	doInit : function(component, event, helper) {
		var action =component.get("c.get30DaysReadywWorks");
    action.setCallback(this, function(a){
            component.set("v.readyWork", a.getReturnValue());
           	console.log('The READY works are :'+JSON.stringify(a.getReturnValue()));
        });
        $A.enqueueAction(action);
	},

	editRecord : function(component, event, helper) {
    var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
         "recordId": event.target.id
   });
    editRecordEvent.fire();
	}
})