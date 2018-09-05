@isTest
public class testAccountHandler {
    @isTest static void accountIsActiveChecked() {
        //Insert new Account
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account'];      
        System.assertEquals(true, acct.Is_Active__c);
    }
    
    @isTest static void contactIsLastContactChecked() {
        //Insert new Account
        Account acct = new Account(Name = 'Test Account 2');
        insert acct;
        
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 2'];        
        System.assertEquals(true, acct.Is_Active__c);
        
        //Insert new First Contact
        Contact conOne = new Contact(FirstName = 'Gabriel',
                                    LastName = 'Fallen',
                                    AccountId = acct.Id);
        insert conOne;
        
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Fallen' AND AccountId =: acct.Id];
        System.assertEquals(true, conOne.Is_Last_Contact__c);
        
        Contact conTwo = new Contact(FirstName = 'David',
                                    LastName = 'James',
                                    AccountId = acct.Id);
        insert conTwo;
        
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Fallen' AND AccountId =: acct.Id];
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        conTwo = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'James' AND AccountId =: acct.Id];
        System.assertEquals(true, conTwo.Is_Last_Contact__c);
    }
    
    @isTest static void accountUncheck() {
        //Insert new Account
        Account acct = new Account(Name = 'Test Account 3');
        insert acct;
                
        //Insert new First Contact
        Contact conOne = new Contact(FirstName = 'Bruno',
                                    LastName = 'Coldzera',
                                    AccountId = acct.Id);
        insert conOne;
        
        Contact conTwo = new Contact(FirstName = 'Stewie',
                                    LastName = '2k',
                                    AccountId = acct.Id);
        insert conTwo;
        
        test.startTest();        
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 3'];
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Coldzera'];
        conTwo = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = '2k'];
        
        System.assertEquals(true, acct.Is_Active__c);
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        System.assertEquals(true, conTwo.Is_Last_Contact__c);
              
        //Is Active updated to false
        acct.Is_Active__c = false;
        update acct;
        
        //Check if values change accordingly
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 3'];
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Coldzera'];
        conTwo = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = '2k'];
        test.stopTest();
        
        System.assertEquals(false, acct.Is_Active__c);
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        System.assertEquals(false, conTwo.Is_Last_Contact__c);
    }
    
    @isTest static void accountRechecked() {
        //Insert new Account
        Account acct = new Account(Name = 'Test Account 4');
        insert acct;
        
        //Insert new First Contact
        Contact conOne = new Contact(FirstName = 'S1mple',
                                    LastName = 'Zeus',
                                    AccountId = acct.Id);
        insert conOne;
        Contact conTwo = new Contact(FirstName = 'Dev1ce',
                                    LastName = 'Sniper',
                                    AccountId = acct.Id);
        insert conTwo;
        
        test.startTest();
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 4'];
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Zeus'];
        conTwo = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Sniper'];
        
        System.assertEquals(true, acct.Is_Active__c);
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        System.assertEquals(true, conTwo.Is_Last_Contact__c);
        
        //Is Active updated to false
        acct.Is_Active__c = false;
        update acct;
        
        //Check if values change accordingly
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 4'];
        conOne = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Zeus'];
        conTwo = [SELECT Is_Last_Contact__c FROM Contact WHERE LastName = 'Sniper'];
        System.assertEquals(false, acct.Is_Active__c);
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        System.assertEquals(false, conTwo.Is_Last_Contact__c);
        
        //Is Active updated to true
        acct.Is_Active__c = true; 
        update acct;
        test.stopTest();
                
        //Validate values
        acct = [SELECT Is_Active__c FROM Account WHERE Name = 'Test Account 4'];
        conOne = [SELECT Is_Last_Contact__c, CreatedDate FROM Contact WHERE LastName = 'Zeus'];
        conTwo = [SELECT Is_Last_Contact__c, CreatedDate FROM Contact WHERE LastName = 'Sniper'];
        
        System.debug(conOne.CreatedDate);
        System.debug(conTwo.CreatedDate);
        System.assertEquals(true, acct.Is_Active__c);
        System.assertEquals(false, conOne.Is_Last_Contact__c);
        System.assertEquals(true, conTwo.Is_Last_Contact__c);
    }
}