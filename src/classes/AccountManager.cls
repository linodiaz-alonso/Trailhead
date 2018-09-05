@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        Integer startIndex = request.requestURI.lastIndexOf('/', request.requestURI.lastIndexOf('/')-1) +1;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substring(startIndex,
          request.requestURI.lastIndexOf('/'));
        System.debug(accountId);
        Account result =  [SELECT Id,Name, (SELECT Id, Name
                                            FROM Contacts
                                            WHERE AccountId =: accountId )
                        FROM Account
                        WHERE Id = :accountId];
        return result;
    }
}