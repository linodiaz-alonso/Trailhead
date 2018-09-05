public with sharing class ShowContractController {
	
 //Use @AuraEnabled to enable client- and server-side access to the method
  @AuraEnabled
  public static String getAttachment(Id contractID) {
    Attachment attach = [SELECT Id, Name, Body
						 FROM Attachment
						 WHERE ParentId =: contractID
						 LIMIT 1];

	return EncodingUtil.base64Encode(attach.Body);
  }
}