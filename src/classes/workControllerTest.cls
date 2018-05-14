@isTest
private class workControllerTest {

	@isTest static void withRecordId() {
		Contact asignee = new Contact (FirstName = 'Fede',
		LastName = 'Kleinman',Email = 'xyzmail@mail.com');
		insert asignee;

		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Idea',
		bootstrap_deve__Difficulty_Level__c = '8', bootstrap_deve__Assignee__c = asignee.Id);

		insert work;
		String recordId = asignee.Id;
		System.Debug(recordId);

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.get30DaysWorks(recordId);
		System.assertEquals(1,result.size());

	}

	@isTest static void emptyRecordId() {
		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Idea',
		bootstrap_deve__Difficulty_Level__c = '8');
		insert work;
		String recordId = '';

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.get30DaysWorks(recordId);
		System.assertEquals(1,result.size());
	}

	@isTest static void mapIconsAction() {
		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Action',
		bootstrap_deve__Difficulty_Level__c = '8');
		insert work;
		String recordId = '';

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.get30DaysWorks(recordId);
		System.assertEquals(1,result.size());
	}

	@isTest static void mapIconsFix() {
		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Fix',
		bootstrap_deve__Difficulty_Level__c = '8');
		insert work;
		String recordId = '';

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.get30DaysWorks(recordId);
		System.assertEquals(1,result.size());
	}

	@isTest static void overdueWorks() {
		Date myDate = date.newInstance(1990, 11, 21);
		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Idea',
		bootstrap_deve__Difficulty_Level__c = '8',
		bootstrap_deve__Estimated_End_Date__c = myDate,
		bootstrap_deve__Status__c = 'Done');
		insert work;

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.getOverdueWork();
		System.assertEquals(0,result.size());
	}

	@isTest static void overdueWorkNotInDone() {
		Date myDate = date.newInstance(1990, 11, 21);
		bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
		bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Idea',
		bootstrap_deve__Difficulty_Level__c = '8',
		bootstrap_deve__Estimated_End_Date__c = myDate,
		bootstrap_deve__Status__c = 'New');
		insert work;

		//System.assertEquals(1,[SELECT COUNT() FROM Contact WHERE FirstName='Fede']);
		List<bootstrap_deve__Work_Item__c> result = workController.getOverdueWork();
		System.assertEquals(1,result.size());
	}



}
