trigger AccountBeforeUpdate on Account (before update) {
    
    List<Account> accountsAndContacts = [select id, name,Total_Priority__c, (select id, Contact_Priority__c from Contacts)
                                         from Account where Id IN :Trigger.newMap.keySet()];
 
    List<Account> accountsToUpdate = new List<Account>{};

        
    Decimal total;
       
    for(Account acc: accountsAndContacts){

        total = 0;
        for(Contact con: acc.Contacts){
            total = total + con.Contact_Priority__c;
            system.debug('============= Total ==========' + total);  
        }       
        acc.Total_Priority__c = total;
        system.debug('============= Ccount Total ==========' + acc.Total_Priority__c);  
    }
}