({
	get30DaysWork : function(component, event) {
		//Get recordId if exists. This let me know the context
		var recordId = component.get('v.recordId');
		if(recordId == undefined){recordId = '';}
    console.log("RecordID: " + recordId);

		//Call controller on the server
		var action =component.get("c.get30DaysWorks");
		action.setParams({ "recordId" : recordId });
		action.setCallback(this, function(response){
			var state = response.getState();
			var responseList = response.getReturnValue();
			if (state === "SUCCESS") {
				var newList = [];
				var readyList = [];
				var inprogressList = [];
				var doneList = [];
				for (var i = 0; i < responseList.length; i++) {
					switch (responseList[i].bootstrap_deve__Status__c) {
				    case "New":
							newList.push(responseList[i])
				      break;
				    case "Ready":
				      readyList.push(responseList[i])
				        break;
				    case "In Progress":
				       inprogressList.push(responseList[i])
				        break;
				    case "Done":
				      doneList.push(responseList[i])
				        break;
					}
				}
				component.set("v.newWorks", newList);
				component.set("v.readyWorks", readyList);
				component.set("v.inprogressWorks", inprogressList);
				component.set("v.doneWorks", doneList);
      }
      else{
      	var errors = response.getError();
				console.log(errors)
			}
		});
		$A.enqueueAction(action);
	}
})
