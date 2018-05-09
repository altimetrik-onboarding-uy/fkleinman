({
	editRecord : function(component, event, helper) {
		var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
         "recordId": event.target.id
   });
    editRecordEvent.fire();
	},

	viewRefreshed: function( cmp, evt, h ) {
			$A.get('e.force:refreshView').fire();
	}
})