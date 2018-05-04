public with sharing class workController {

	/*Trae todos los trabajos*/
	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> getAllWorks() {
   return [SELECT bootstrap_deve__Title__c,
	 bootstrap_deve__Description__c,
	 bootstrap_deve__Difficulty_Level__c,
	 bootstrap_deve__Type__c FROM bootstrap_deve__Work_Item__c];
	}

	//All work items started during the last 30 days with state of NEW
	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> get30DaysNewWorks(){
		return mapIcons([SELECT bootstrap_deve__Title__c,
 	 bootstrap_deve__Description__c,
 	 bootstrap_deve__Difficulty_Level__c,
 	 bootstrap_deve__Type__c, CreatedDate
	 FROM bootstrap_deve__Work_Item__c
	 WHERE bootstrap_deve__Status__c = 'New' AND CreatedDate = LAST_N_DAYS:30]);
	}

	//All work items started during the last 30 days with state of READY
	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> get30DaysReadywWorks(){
		return mapIcons([SELECT bootstrap_deve__Title__c,
 	 bootstrap_deve__Description__c,
 	 bootstrap_deve__Difficulty_Level__c,
 	 bootstrap_deve__Type__c, CreatedDate
	 FROM bootstrap_deve__Work_Item__c
	 WHERE bootstrap_deve__Status__c = 'Ready' AND CreatedDate = LAST_N_DAYS:30]);
	}

	//All work items started during the last 30 days with state of INPROGRESS
	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> get30DaysInprogressWorks(){
		return mapIcons([SELECT bootstrap_deve__Title__c,
 	 bootstrap_deve__Description__c,
 	 bootstrap_deve__Difficulty_Level__c,
 	 bootstrap_deve__Type__c, CreatedDate
	 FROM bootstrap_deve__Work_Item__c
	 WHERE bootstrap_deve__Status__c = 'In Progress' AND CreatedDate = LAST_N_DAYS:30]);
	}
	//All work items started during the last 30 days with state of DONE
	@AuraEnabled
	public static List<bootstrap_deve__Work_Item__c> get30DaysDoneWorks(){
		return mapIcons([SELECT bootstrap_deve__Title__c,
 	 bootstrap_deve__Description__c,
 	 bootstrap_deve__Difficulty_Level__c,
 	 bootstrap_deve__Type__c, CreatedDate
	 FROM bootstrap_deve__Work_Item__c
	 WHERE bootstrap_deve__Status__c = 'Done' AND CreatedDate = LAST_N_DAYS:30]);
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
