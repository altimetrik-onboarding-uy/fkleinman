global class dailyOverdueSummary implements Schedulable {

	global void execute(SchedulableContext sc) {
		Integer ow = new workController().getOverdueWork().size();

		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

		//Set admin user.
		String[] admins = getAdministrator();
		message.toAddresses = admins;
		message.optOutPolicy = 'FILTER';
		message.subject = 'Overdue Work Summary - ' + date.today();
		message.plainTextBody = 'There are ' + ow + ' Overdue works';
		Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

		if (results[0].success) {
    	System.debug('The Overdue Work Summary was sent successfully.');
		}
		else {
    	System.debug('The Overdue Work Summary failed to send: ' + results[0].errors[0].message);
		}
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