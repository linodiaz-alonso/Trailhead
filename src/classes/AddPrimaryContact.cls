public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Contact> contactsToInsertList = new List<Contact>();
        for(Account acc : [SELECT Id,Name, BillingState
                           FROM Account
                           WHERE BillingState =: state
                           LIMIT 200]) {
            Contact cont = contact.clone(false, false, false, false);
            cont.AccountId = acc.Id;                       
            contactsToInsertList.add(cont);
        }
        
        if(contactsToInsertList.size()!=0){
            insert contactsToInsertList;
        }
    }
    
}