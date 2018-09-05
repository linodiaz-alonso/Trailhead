public with sharing class RedirectorServerSideController {

  //Use @AuraEnabled to enable client- and server-side access to the method
  @AuraEnabled
  public static String getProfileName() {
    Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
    
    return p.name;
  }
 }