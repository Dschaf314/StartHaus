trigger UpdateWorkPhoneOnRelatedContacts on Account (before update) {
	List<Contact> matchingContacts = new List<Contact>();
		//when the phone number changes from the original number

	for (Account act : Trigger.new) {
		Account oldAct = trigger.oldMap.get(act.Id);

		if (act.Phone != oldAct.Phone){
			matchingContacts = [SELECT Phone
											FROM Contact
											WHERE AccountId = :act.Id];
			for (Contact ctc : matchingContacts) {
				ctc.Phone = act.Phone;
			}
		}
	}
	Update matchingContacts;
}