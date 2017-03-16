/*****************************************************************************************************************
*   Name:           DHC_SetThresholdController
*   Description:    This class is used for Setup Data
*   Author:             Accenture
*   Date                PRJ#          Summary of Changes 
*   8/31/2016           DHC           Initial
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************/
public class DHC_SetThresholdController {
     /* Start Varibale Declaration */
     public List<Limits_Threshold__c> thresholdCustomSettingList {get;set;}
     public List<Limits_Threshold__c> runTimeCustomSettingList {get;set;}
     public List<Limits_Threshold__c> organizationCustomSettingList {get;set;}
     public List<document> docImage  {get;set;}
     public Boolean activeProfile{get;set;}
     public String enteredText1{get;set;}
     public String enteredText2{get;set;}
     public String enteredText3{get;set;}
     public String enteredText4{get;set;}
     public String enteredText5{get;set;}
     public String decstr;
     public string encstr;
     public string finalstr;
      /* END Varibale Declaration */
     /**
     * Name: SetThresholdController
     * Description: This method is used to calling other methods.
     * @parameters: NONE
     * @return: NONE
    **/
     public DHC_SetThresholdController(){
         List<DHC_Setup__c> dhcCredList = [SELECT id,Name, UserName__C, Password__c,Token__c,
                                                    DHC_ClientID__c,DHC_CLIENTSECRET__c
                                            FROM DHC_Setup__c 
                                            WHERE Name= 'DHC Credtial' limit 1];
        if(!dhcCredList.isEmpty()){
             enteredText1 = dhcCredList[0].UserName__C;
             
        }
         activeProfile = false;
         Id id1 = UserInfo.getProfileId();
         Profile profileName = [Select Name from Profile where Id =:id1 limit 1];
         if(profileName.Name == system.label.DHC_ACTIVEADMIN){
             activeProfile = true;
         }
         docImage =[select id,body,name,bodylength from document where name =: DHC_ConstantsUtils.COMPANYLOGO limit 1];
         thresholdCustomSettingList = new List<Limits_Threshold__c>();
         runTimeCustomSettingList = new List<Limits_Threshold__c>();
         organizationCustomSettingList = new List<Limits_Threshold__c>();
         thresholdCustomSettingList = [select Async_Max_Limit__c,Async_Soft_Threshold__c,Display_All__c,Display_Name__c,
                                             Hard_Threshold__c,Impact_Analysis__c,Limit_Type__c,Max_Limit__c,
                                             Measure__c,Send_Hard_Threshold_Notification__c,
                                             Send_Soft_Threshold_Notification__c,Soft_Threshold__c,lastmodifiedDate,
                                             Switch__c,Async_Hard_Threshold__c,Unit__c,lastmodifiedBy.Name from Limits_Threshold__c 
                                             limit 5000];
         for(Limits_Threshold__c lt : thresholdCustomSettingList){
             if(lt.Limit_Type__c == DHC_ConstantsUtils.RUNTIMELIMIT){
                 runTimeCustomSettingList.add(lt);
             } else {
                 organizationCustomSettingList.add(lt);
             }
         }
     }
     
     /**
     * Name: encryptedPassword
     * Description: This method is used for encrypt password and token
     * @parameters: NONE
     * @return: NONE
     **/
     public void encryptedPassword(){
         Blob exampleIv = Blob.valueOf(system.label.DHC_IV);
         blob key = Blob.valueOf(system.label.DHC_Key);
         Blob data = Blob.valueOf(enteredText2);
         Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);
         encstr = EncodingUtil.base64Encode(encrypted);
         Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
         decstr = decrypted.toString();
         List<DHC_Setup__c> dhcCredList = [SELECT id,Name, UserName__C, Password__c
                                            FROM DHC_Setup__c 
                                            WHERE Name= 'DHC Credtial' limit 1];
         for(DHC_Setup__c obj :dhcCredList){
             obj.Username__C = enteredText1;
             obj.Password__c = encstr;
             obj.Token__C= enteredText3;
             obj.DHC_ClientID__c = enteredText4;
             obj.DHC_CLIENTSECRET__c = enteredText5;
        }
         if(dhcCredList.isEmpty()){
             DHC_Setup__c obj = new DHC_Setup__c();
             obj.Name = 'DHC Credtial';
             obj.Username__C = enteredText1;
             obj.Password__c = encstr;
             obj.Token__C= enteredText3;
             obj.DHC_ClientID__c = enteredText4;
             obj.DHC_CLIENTSECRET__c = enteredText5;
             dhcCredList.add(obj);
          }
         if(!dhcCredList.isEmpty()){
            upsert dhcCredList;
         }
    }
    /**
     * Name: updateThresholdData
     * Description: This method is used to calling other methods.
     * @parameters: NONE
     * @return: NONE
    **/
     public pageReference updateThresholdData(){
         Boolean runtimecheckBreach = false;
         Boolean organizationcheckBreach = false;
         Boolean runtimeMaxBreach = false;
         Boolean organizationMaxBreach = false;
         for(Limits_Threshold__c obj :runTimeCustomSettingList){
             if(obj.Max_Limit__c <= obj.Hard_Threshold__c){
                  runtimeMaxBreach = true;
                  break;
             }
             if(obj.Hard_Threshold__c <= obj.Soft_Threshold__c){
                 runtimecheckBreach = true;
                 break;
             }
         }
         for(Limits_Threshold__c obj :organizationCustomSettingList){
             if(obj.Max_Limit__c <= obj.Hard_Threshold__c){
                  organizationMaxBreach = true;
                  break;
             }
             if(obj.Hard_Threshold__c <= obj.Soft_Threshold__c){
                 organizationcheckBreach = true;
                 break;
             }
         }
         if(organizationMaxBreach || runtimeMaxBreach){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,system.label.DHC_ValidationErrorStr));
             return null;
             
         }else if(organizationcheckBreach || runtimecheckBreach){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,system.label.DHC_ErrorMessageStr));
             return null;
         }else {
            if(!runTimeCustomSettingList.isEmpty()){
                Database.SaveResult[] saveResultList = Database.update(runTimeCustomSettingList,false);
                for (Database.SaveResult res : saveResultList) {
                    if (!res.isSuccess()){
                        //Error handling if required
                        break;
                    }
                }        
            } 
            if(!organizationCustomSettingList.isEmpty()){
                Database.SaveResult[] saveResultList = Database.update(organizationCustomSettingList,false);
                for (Database.SaveResult res : saveResultList) {
                    if (!res.isSuccess()){
                        //Error handling if required
                        break;
                    }
                }        
            }
            if(!docImage.isEmpty()){
                Database.SaveResult[] saveResultList = Database.update(docImage,false);
                for (Database.SaveResult res : saveResultList) {
                    if (!res.isSuccess()){
                        //Error handling if required
                        break;
                    }
                }        
            }           
            PageReference  pageRef= ApexPages.currentPage();
            pageRef.setRedirect(true);
            return pageRef;
        }
     }
     
     /**
     * Name: switchButton
     * Description: This method is used to calling other methods.
     * @parameters: NONE
     * @return: NONE
    **/
     public pageReference switchButton(){
         List<Limits_Threshold__c> thresholdCustomSettingList = new List<Limits_Threshold__c>();
         List<Limits_Threshold__c> CustomSettingSwitchOFFList = new List<Limits_Threshold__c>();
         List<Limits_Threshold__c> CustomSettingSwitchONList = new List<Limits_Threshold__c>();
         thresholdCustomSettingList = Limits_Threshold__c.getAll().values(); 
         for(Limits_Threshold__c limitSettingObj : thresholdCustomSettingList){
             if(limitSettingObj.Switch__c == True){
                 Limits_Threshold__c obj = new Limits_Threshold__c();
                 obj.Switch__c = false;
                 obj.ID = limitSettingObj.Id;
                 CustomSettingSwitchONList.add(obj);
             }else if(limitSettingObj.Switch__c == false){
                     Limits_Threshold__c obj = new Limits_Threshold__c();
                     obj.Switch__c = True;
                     obj.ID = limitSettingObj.Id;
                     CustomSettingSwitchOFFList.add(obj);
             }
         }
         if(!CustomSettingSwitchONList.isEmpty()){
            Database.SaveResult[] saveResultList = Database.update(CustomSettingSwitchONList,false);
            for (Database.SaveResult res : saveResultList) {
                if (!res.isSuccess()){
                    //Error handling if required
                    break;
                }
             }        
         }
         if(!CustomSettingSwitchOFFList.isEmpty()){
            Database.SaveResult[] saveResultList = Database.update(CustomSettingSwitchOFFList,false);
            for (Database.SaveResult res : saveResultList) {
                if (!res.isSuccess()){
                    //Error handling if required
                    break;
                }
             }        
         }
         PageReference  pageRef= ApexPages.currentPage();
         pageRef.setRedirect(true);
         return pageRef;
      }
}