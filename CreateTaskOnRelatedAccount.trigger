//If a case is closed, create a task 
// for the account owner 
// telling them to follow up with the account. 

//If there was a contact related to the case, 
//include the name and contact information in the task.


// if Case == closed
// then create a task for the related account owner
// also relate the task to the contact associate with the case
// be sure to include the name and contact info in the task

trigger CreateTaskOnRelatedAccount on Case (before update) {
	List<Task> newtask = new List<Task>();

	for (Case cse : Trigger.new) {

		if (cse.status == 'closed' && cse.AccountId != null){
			Account accountFromQuery =		[SELECT Name
											FROM	Account
											WHERE	Id = :cse.AccountId];
			Task tsk 		= new Task();
			tsk.OwnerId 	= cse.OwnerId;
			tsk.Subject 	= 'Follow up with closed case';
			tsk.Description = 'Please follow up with the closed case on account '+ accountFromQuery.Name + ' please.';
			
			if	(cse.ContactId 	!= null){
				tsk.WhoId = cse.ContactId;
				
			}
				
			newtask.add(tsk);

		}

	}


	insert newtask;
}