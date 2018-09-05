@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();

        // add 100 child accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i,BillingState = 'NY'
            ));
        }
        
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i,BillingState = 'CA'
            ));
        }
        
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Contact contact = new Contact(LastName='Test Contact');
        insert contact;
        // Create our Queueable instance
        AddPrimaryContact addContact = new AddPrimaryContact(contact, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(addContact);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        Contact cont = [SELECT Id,Name,AccountId FROM Contact WHERE Id !=: contact.Id LIMIT 1];
        System.assertNotEquals(null, cont.AccountId);
    }
    
}