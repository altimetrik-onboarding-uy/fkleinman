global class DailyOverdueSummaryScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
		dailyOverdueSummary dos = new dailyOverdueSummary();
		Database.executebatch(dos,200);
	}
}
