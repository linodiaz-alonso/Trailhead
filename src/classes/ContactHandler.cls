public class ContactHandler {
    public static void isLastCheckbox(List<Contact> listCon) {
        //New Contacts added to set
        Set<Id> conId = new Set<Id>();
        Set<Id> accId = new Set<Id>();
        //New contacts checked true
        for(Contact newestCon: (List<Contact>) trigger.new) {
            if (newestCon.Is_Last_Contact__c == false) {
                newestCon.Is_Last_Contact__c = true;
                accId.add(newestCon.AccountId);
                conId.add(newestCon.Id);
            }
        }
        
        //Old Contacts listed
        List<Contact> oldCont = [SELECT Id, Is_Last_Contact__c FROM Contact WHERE Id NOT IN :conId AND AccountId IN :accId];
        
        //Old Contacts being marked as false
        for(Contact c: oldCont) {
            if (c.Is_Last_Contact__c == true) {
                c.Is_Last_Contact__c = false;
            }
        }
        update oldCont;
    }
}