global class dailyOverdueSummary implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext bc) {
		String type = 'Done';

		return Database.getQueryLocator([SELECT bootstrap_deve__Title__c,
		bootstrap_deve__Description__c,
		bootstrap_deve__Difficulty_Level__c,
		bootstrap_deve__Type__c FROM bootstrap_deve__Work_Item__c
		WHERE bootstrap_deve__Estimated_End_Date__c <= TODAY AND bootstrap_deve__Status__c != :type]);
	}

	global void execute(Database.BatchableContext bc, List<bootstrap_deve__Work_Item__c> overdueWorks){
		Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {};
		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		//Set admin user.
		String[] admins = getAdministrator();
		message.toAddresses = admins;
		message.optOutPolicy = 'FILTER';
		message.subject = 'Overdue Work Summary - ' + date.today();
		message.plainTextBody = 'There are ' + overdueWorks.size() + ' Overdue works';
		messages.add(message);
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
		if (results[0].success) {
 		 System.debug('The Overdue Work Summary was sent successfully.');
 	 }
 	 else {
 		 System.debug('The Overdue Work Summary failed to send: ' + results[0].errors[0].message);
 	 }
	}

	global void finish(Database.BatchableContext bc){

	}

	private String[] getAdministrator(){
		List<User> adm_users = [SELECT Email FROM User WHERE Profile.Name = 'System Administrator'];
		String[] admins = new String[]{};
		for(User admin : adm_users){
			admins.add(admin.Email);
		}
		return admins;
	}
}
