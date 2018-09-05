@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccoutnt() {
        Account acc = new Account(Name='Test');
        insert acc;
        Account acc1 = new Account(Name='Test1');
        insert acc1;
        
        Contact cont = new Contact(LastName='Diaz');
        cont.AccountId = acc1.Id;
        cont.Contact_Priority__c =1;
        insert cont;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://kaplanhackday16-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + acc1.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test1', thisAccount.Name); 
    }
}