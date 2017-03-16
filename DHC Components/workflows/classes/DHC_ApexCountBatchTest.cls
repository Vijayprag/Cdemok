@isTest(SeeAllData=false)
private class DHC_ApexCountBatchTest{
    static testMethod void dailyDisplayData(){
        List<Limits_Threshold__c> lst = new List<Limits_Threshold__c>();
        Limits_Threshold__c obj = new Limits_Threshold__c();
        obj.Name='Apex Used';
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
        lst.add(obj);
        insert lst;
        DHC_ApexCountScheduler apexscheduledcls = new DHC_ApexCountScheduler();
        apexscheduledcls.execute(null);
        test.startTest();
        DHC_ApexCountBatch apexcls  = new DHC_ApexCountBatch();
        apexcls.execute(null,lst); 
        test.stopTest();
      }
    
    }