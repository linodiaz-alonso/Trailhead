public class AccountProcessor {

    // Call async from triggers, etc, where callouts are not permitted.
    @future
    public static void countContacts(List<Id> accountIdList) {
        List<Account> accountstoUpdate = new List<Account>();
        List<Account> accountsWithContacts = [select id, name,Number_of_Contacts__c , (select id, salutation, description,
                                                                firstname, lastname, email from Contacts)
                                              from Account where Id IN :accountIdList];
        
        for(Account a: accountsWithContacts){
            a.Number_of_Contacts__c = a.Contacts.size();
            accountstoUpdate.add(a);
        }
        
        if(accountstoUpdate.size()!=0) {
            update accountstoUpdate;
        }
    }
}