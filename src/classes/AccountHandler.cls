public class AccountHandler {
   public static void handleAfterUpdate(List<Account> recordList) {
       Set<Id> accountInactiveIdSet = new Set<Id>();
         Set<Id> accountActiveIdSet   = new Set<Id>();
          for (Account newAccount : recordList) {
       // Access the “old” record by its ID in Trigger.oldMap
       Account oldAccount = (Account) Trigger.oldMap.get(newAccount.Id);

       if(oldAccount.Is_Active__c != newAccount.Is_Active__c
          && newAccount.Is_Active__c == false){
          accountInactiveIdSet.add(newAccount.Id);
         } else if (oldAccount.Is_Active__c != newAccount.Is_Active__c && newAccount.Is_Active__c == true){
             accountActiveIdSet.add(newAccount.Id);
         }
      }
    System.debug('accountInactiveIdSet ---> ' + accountInactiveIdSet);
    System.debug('accountActiveIdSet ---> ' + accountActiveIdSet);
      List<Contact> contactsToUpdateList = new List<Contact>();

      Set<Id> updatedAccountIdSet = new Set<Id>();
 
      for(Contact cont : [SELECT Id, Name, AccountId, Is_Last_Contact__c
                        FROM Contact
                        WHERE AccountId IN: accountInactiveIdSet
                        OR AccountId IN: accountActiveIdSet
                        ORDER BY createdDate DESC] ){
        System.debug('cont ---> Out ' + cont);
        if(accountInactiveIdSet.contains(cont.AccountId)
           && cont.Is_Last_Contact__c){
           System.debug('cont ---> Entra ' + cont);
           cont.Is_Last_Contact__c = false;
        }

       if(accountActiveIdSet.contains(cont.AccountId)
           && !cont.Is_Last_Contact__c
           && !updatedAccountIdSet.contains(cont.AccountId)){
           cont.Is_Last_Contact__c = true;
           updatedAccountIdSet.add(cont.AccountId);
        }
           contactsToUpdateList.add(cont);
     }
 
     if(contactsToUpdateList.size()!=0){
        update contactsToUpdateList;
     }
   }
}