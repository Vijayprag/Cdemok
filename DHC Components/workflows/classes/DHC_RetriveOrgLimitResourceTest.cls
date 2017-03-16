@isTest
public class DHC_RetriveOrgLimitResourceTest{
  public static testmethod void testAccountCallout() {
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new DHC_MockHttpResponseGenerator());
         DHC_RetriveOrgLimitResource.getSessionObject('test@test.com','DGIG&$HGJHGHJ','DGUGYFDGDG','dsdsdsdsds','sdsdsdsdsdsd');
         DHC_RetriveOrgLimitResource.SecurityAccess access = new DHC_RetriveOrgLimitResource.SecurityAccess();
         access.access_token='KJGKGKGKGGKDDL';
         access.instance_url='https://test.com';
         access.id='dsdsdsdqvswe';
         access.token_type='test';
         access.issued_at='sdssdsd';
         access.signature='sddada';
         
    }
    
     public static testmethod void testAccountCallout1() {
         
         DHC_OrganizationLimitCalculationBatch orgobj = new DHC_OrganizationLimitCalculationBatch();
         orgobj.execute(null);
         
         DHC_Setup__c dhcObj = new DHC_Setup__c();
         dhcObj.username__c = 'test@callout.com';
         dhcObj.password__C= 'test123';
         dhcObj.Name = 'DHC Credtial';
         dhcObj.Token__C = 'ABXCDHDHDHOWD123LL';
         insert dhcObj;
         
         Limits_Threshold__c obj = new Limits_Threshold__c();
        obj.Name='DailyApiRequests';
        obj.Display_Name__c = 'Daily Api Requests';
        obj.Limit_Type__c = 'RunTime Limit';
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
        
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new DHC_MockHttpResponseGenerator());
         DHC_RetriveOrgLimitResource.getSessionObject('test@test.com','DGIG&$HGJHGHJ','DGUGYFDGDG','sddsdsdsdsd','sdsdsdsdsdsd');
         DHC_RetriveOrgLimitResource retriveObj = new DHC_RetriveOrgLimitResource();
         retriveObj.callgetLimit();
         DHC_RetriveOrgLimitResource.WrapperList wrapperLst = new DHC_RetriveOrgLimitResource.WrapperList('test',30,20);
         
         
        
        
    }
    
     public static testmethod void testAccountCallout2() {
         DHC_Setup__c dhcObj = new DHC_Setup__c();
         dhcObj.username__c = 'test@callout.com';
         dhcObj.password__C= 'test123';
         dhcObj.Name = 'DHC Credtial';
         dhcObj.Token__C = 'ABXCDHDHDHOWD123LL';
         insert dhcObj;
         
        List<Limits_Threshold__c> lst = new List<Limits_Threshold__c>();
        Limits_Threshold__c obj = new Limits_Threshold__c();
        obj.Name='ConcurrentAsyncGetReportInstances';
        obj.Display_Name__c = 'Concurrent Async Get Report Instances';
        obj.Limit_Type__c = 'Concurrent Limit';
        obj.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj.Display_All__c = TRUE;
        obj.Send_Soft_Threshold_Notification__c = TRUE;
        obj.Send_Hard_Threshold_Notification__c = TRUE;
        obj.Hard_Threshold__c = 13000;
        obj.Soft_Threshold__c = 1000;
        obj.Max_Limit__c = 15000;
        obj.Switch__c = True; 
        obj.Impact_Analysis__c = 'System Integration(s) Outage.';
        lst.add(obj);
        
        Limits_Threshold__c obj1 = new Limits_Threshold__c();
        obj1.Name='DailyApiRequests';
        obj1.Display_Name__c = 'Daily Api Requests';
        obj1.Limit_Type__c = 'Daily Limit';
        obj1.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj1.Display_All__c = TRUE;
        obj1.Send_Soft_Threshold_Notification__c = TRUE;
        obj1.Send_Hard_Threshold_Notification__c = TRUE;
        obj1.Hard_Threshold__c = 13000;
        obj1.Soft_Threshold__c = 1000;
        obj1.Max_Limit__c = 15000;
        obj1.Switch__c = True; 
        obj1.Impact_Analysis__c = 'System Integration(s) Outage.';
        lst.add(obj1);
        
        Limits_Threshold__c obj2 = new Limits_Threshold__c();
        obj2.Name='HourlyTimeBasedWorkflow';
        obj2.Display_Name__c = 'Hourly Time Based Workflow';
        obj2.Limit_Type__c = 'Hourly Limit';
        obj2.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj2.Display_All__c = TRUE;
        obj2.Send_Soft_Threshold_Notification__c = TRUE;
        obj2.Send_Hard_Threshold_Notification__c = TRUE;
        obj2.Hard_Threshold__c = 13000;
        obj2.Soft_Threshold__c = 1000;
        obj2.Max_Limit__c = 15000;
        obj2.Switch__c = True; 
        obj2.Impact_Analysis__c = 'System Integration(s) Outage.';
        lst.add(obj2);
        
        Limits_Threshold__c obj3 = new Limits_Threshold__c();
        obj3.Name='FileStorageMB';
        obj3.Display_Name__c = 'File Storage MB';
        obj3.Limit_Type__c = 'System Storage Limit';
        obj3.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj3.Display_All__c = TRUE;
        obj3.Send_Soft_Threshold_Notification__c = TRUE;
        obj3.Send_Hard_Threshold_Notification__c = TRUE;
        obj3.Hard_Threshold__c = 13000;
        obj3.Soft_Threshold__c = 1000;
        obj3.Max_Limit__c = 15000;
        obj3.Switch__c = True; 
        obj3.Impact_Analysis__c = 'System Integration(s) Outage.';
        lst.add(obj3);
        insert lst;
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new DHC_MockHttpResponseGenerator());
         DHC_RetriveOrgLimitResource.getSessionObject('test@test.com','DGIG&$HGJHGHJ','DGUGYFDGDG','sdsdsdhsjdtsdfsd','sdsdsdsdsdsdsds');
         DHC_RetriveOrgLimitResource retriveObj = new DHC_RetriveOrgLimitResource();
         retriveObj.callgetLimit();
         DHC_RetriveOrgLimitResource.WrapperList wrapperLst = new DHC_RetriveOrgLimitResource.WrapperList('test',30,20);
         HourlyDHCCalculateBatch hourlyBatch =new HourlyDHCCalculateBatch();
         hourlyBatch.execute(null,lst);
         
         
        
        
    }
    
      
    
    
}