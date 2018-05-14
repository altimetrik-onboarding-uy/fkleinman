public with sharing class workController {

	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> get30DaysWorks(String recordId){
    	if(recordId.equals('')){
				//It is on a general context
				return mapIcons([SELECT bootstrap_deve__Title__c,
		 	 	bootstrap_deve__Description__c,
		 	 	bootstrap_deve__Difficulty_Level__c,
		 	 	bootstrap_deve__Type__c, bootstrap_deve__Status__c, CreatedDate
			 	FROM bootstrap_deve__Work_Item__c
			 	WHERE CreatedDate = LAST_N_DAYS:30]);
			}
			else{
				//It is on a particular context
				return mapIcons([SELECT bootstrap_deve__Title__c,
		 	 	bootstrap_deve__Description__c,
		 	 	bootstrap_deve__Difficulty_Level__c,
		 	 	bootstrap_deve__Type__c, bootstrap_deve__Status__c, CreatedDate
			 	FROM bootstrap_deve__Work_Item__c
			 	WHERE CreatedDate = LAST_N_DAYS:30
			 	AND bootstrap_deve__Assignee__r.Id = :recordId ]);
			}
	}

	//This method return overdues works. Used for daily schedule to report overdue
	public static List<bootstrap_deve__Work_Item__c> getOverdueWork(){
		return[SELECT bootstrap_deve__Title__c,
		bootstrap_deve__Description__c,
		bootstrap_deve__Difficulty_Level__c,
		bootstrap_deve__Type__c FROM bootstrap_deve__Work_Item__c
		WHERE bootstrap_deve__Estimated_End_Date__c <= TODAY AND bootstrap_deve__Status__c != 'Done'];
	}

	//This method maps icons with type
	private static List<bootstrap_deve__Work_Item__c> mapIcons(List<bootstrap_deve__Work_Item__c> works){
		for (bootstrap_deve__Work_Item__c work : works) {
    	if(work.bootstrap_deve__Type__c.equals('Idea')){
				work.bootstrap_deve__Type__c = 'announcement';
			}
			else if (work.bootstrap_deve__Type__c.equals('Action')){
				work.bootstrap_deve__Type__c = 'approval';
			}
			else{
				work.bootstrap_deve__Type__c = 'canvas';
			}
		}
		return works;
	}
}
