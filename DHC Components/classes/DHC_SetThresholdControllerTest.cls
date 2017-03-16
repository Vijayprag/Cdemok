@isTest(SeeAllData=false)
private class DHC_SetThresholdControllerTest {
    static testMethod void setupCustomSettingData(){ 
        Limits_Threshold__c obj = new Limits_Threshold__c();
        obj.Name='DailyApiRequests';
        obj.Display_Name__c = 'Daily Api Requests';
        obj.Limit_Type__c = 'Daily Limit';
        obj.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj.Display_All__c = TRUE;
        obj.Send_Soft_Threshold_Notification__c = TRUE;
        obj.Send_Hard_Threshold_Notification__c = TRUE;
        obj.Hard_Threshold__c = 13000;
        obj.Soft_Threshold__c = 1000;
        obj.Max_Limit__c = 15000;
        obj.Switch__c = True; 
        obj.Impact_Analysis__c = 'System Integration(s) Outage.';
        insert obj;
        
        obj.Switch__c = false;
        update obj;
        
         Blob exampleIv = Blob.valueOf('Example of IV123');
         blob key = Blob.valueOf('ABC123DEF456HIJ7');
         //Blob key = Crypto.generateAesKey(128);
         Blob data = Blob.valueOf('test@123');
         Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);
         string encstr = EncodingUtil.base64Encode(encrypted);
         Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
        
        DHC_Setup__c obj1 = new DHC_Setup__c();
        obj1.Name = 'DHC Credtial';
        obj1.userName__c ='test@test.com';
        obj1.password__c='test@123';
        obj1.token__c='GDJHJDH';
        insert obj1;
        
        DHC_SetThresholdController setObj = new DHC_SetThresholdController();
        setObj.updateThresholdData();
        setObj.switchButton();
        setObj.enteredText1 = 'test@test.com';
        setObj.enteredText2 = 'test@123';
        setObj.enteredText3 = 'GDGGDFDFDJPOIPOI';
        setObj.enteredText4 = 'GDGGDFDFDJcxcPOIPOI';
        setObj.enteredText5 = 'GDGGDFDFDJPOIPcOI';
        setObj.encryptedPassword();
    } 
    
    static testMethod void setupCustomSettingData1(){ 
        Limits_Threshold__c obj = new Limits_Threshold__c();
        obj.Name='DailyApiRequests';
        obj.Display_Name__c = 'Daily Api Requests';
        obj.Limit_Type__c = 'Daily Limit';
        obj.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj.Display_All__c = TRUE;
        obj.Send_Soft_Threshold_Notification__c = TRUE;
        obj.Send_Hard_Threshold_Notification__c = TRUE;
        obj.Hard_Threshold__c = 13000;
        obj.Soft_Threshold__c = 1000;
        obj.Max_Limit__c = 15000;
        obj.Switch__c = True; 
        obj.Impact_Analysis__c = 'System Integration(s) Outage.';
        insert obj;
        
        
        
         Blob exampleIv = Blob.valueOf('Example of IV123');
         blob key = Blob.valueOf('ABC123DEF456HIJ7');
         //Blob key = Crypto.generateAesKey(128);
         Blob data = Blob.valueOf('test@123');
         Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);
         string encstr = EncodingUtil.base64Encode(encrypted);
         Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
        
        DHC_SetThresholdController setObj = new DHC_SetThresholdController();
        setObj.updateThresholdData();
        setObj.switchButton();
        setObj.enteredText1 = 'test@test.com';
        setObj.enteredText2 = 'test@123';
        setObj.enteredText3 = 'GDGGDFDFDJPOIPOI';
        setObj.enteredText4 = 'GDGGDFDFDJcxcPOIPOI';
        setObj.enteredText5 = 'GDGGDFDFDJPOIPcOI';
        setObj.encryptedPassword();
    } 
}