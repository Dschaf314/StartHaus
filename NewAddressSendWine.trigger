trigger NewAddressSendWine on Contact (before update) {
	List<Task> taskList  = new List<Task>();

	for (Contact con : Trigger.new) {
		Contact oldContact = trigger.oldMap.get(con.Id);
						System.debug(oldContact.MailingCity + ':::' + con.MailingCity);

		if 	(oldContact.MailingCity != con.MailingCity ||
			oldContact.MailingStreet != con.MailingStreet ||
			oldContact.MailingPostalCode != con.MailingPostalCode ||
			oldContact.MailingState != con.MailingState){

			Task tsk 		= new Task();
			tsk.OwnerId 	= con.OwnerId;
			tsk.description = 'New mailing address:' + con.MailingStreet + ' '+ con.MailingCity  
													 + ', '+ con.MailingState + ' '+ con.MailingPostalCode  
								 					 +' '+ '. Remember to send wine!';
			tsk.Subject = 'New Address. Send wine!';
			taskList.add(tsk);
		}
	}			
	insert taskList;
}

