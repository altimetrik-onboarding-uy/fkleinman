@isTest
private class dailyOverdueSummaryTest {

	@testSetup
    static void setup() {
			Date myDate = date.newInstance(1990, 11, 21);
			bootstrap_deve__Work_Item__c work = new bootstrap_deve__Work_Item__c(
			bootstrap_deve__Title__c='Prueba 1122', bootstrap_deve__Type__c = 'Idea',
			bootstrap_deve__Difficulty_Level__c = '8',
			bootstrap_deve__Estimated_End_Date__c = myDate,
			bootstrap_deve__Status__c = 'Ready');
			insert work;
    }

	@isTest static void testBatch() {
		Test.startTest();
    dailyOverdueSummary dos = new dailyOverdueSummary();
    Id batchId = Database.executeBatch(dos);
    Test.stopTest();
    // after the testing stops, assert records were updated properly
    System.assertEquals(1, [SELECT COUNT() FROM AsyncApexJob WHERE ID = :batchId ]);
	}

}
