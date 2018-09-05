@IsTest
private class AccountProcessorTest {

  @IsTest
  private static void testCountContacts() {
        Account acc = new Account(Name='Test');
        insert acc;
        Account acc1 = new Account(Name='Test1');
        insert acc1;
        Contact cont = new Contact(LastName='Diaz');
        cont.AccountId = acc1.Id;
        cont.Contact_Priority__c =1;
        insert cont;
        
        List<Id> accountIds = new List<Id>();
        accountIds.add(acc.Id);
        accountIds.add(acc1.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        
        Account updatedAcc = [SELECT Id, Name, Number_of_Contacts__c FROM Account WHERE Id =: acc.Id];
        System.assertEquals(0, updatedAcc.Number_of_Contacts__c);
        updatedAcc = [SELECT Id, Name, Number_of_Contacts__c FROM Account WHERE Id =: acc1.Id];
        System.assertEquals(1, updatedAcc.Number_of_Contacts__c);
  }

}