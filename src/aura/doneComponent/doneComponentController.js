({
	//Esta funcion se conecta con el controllador y trae todos los works que preciso
	doInit : function(component, event, helper) {
		var action =component.get("c.get30DaysDoneWorks");
		action.setCallback(this, function(a){
						component.set("v.doneWork", a.getReturnValue());
						console.log('The DONE works are :'+JSON.stringify(a.getReturnValue()));
				});
				$A.enqueueAction(action);
	},


		editRecord : function(component, event, helper) {
	    var editRecordEvent = $A.get("e.force:editRecord");
	    editRecordEvent.setParams({
	         "recordId": event.target.id
	   });
	   editRecordEvent.fire();
		},

		viewRefreshed: function( cmp, evt, h ) {
        console.log('view refreshed!');
				$A.get('e.force:refreshView').fire();
    }


})