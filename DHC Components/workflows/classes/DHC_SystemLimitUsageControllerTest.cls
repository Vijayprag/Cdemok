@isTest(SeeAllData=false)
private class DHC_SystemLimitUsageControllerTest{
    static testMethod void dailyDisplayData(){ 
         list<Limits_Threshold__c> limitLST = new list<Limits_Threshold__c>();
         Limits_Threshold__c obj = new Limits_Threshold__c();
         obj.Name='getLimitAsyncCalls';
         obj.Display_Name__c = 'Daily Api Requests';
         obj.Limit_Type__c = 'Daily Limit';
         obj.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
         obj.Display_All__c = TRUE;
         obj.Send_Soft_Threshold_Notification__c = TRUE;
         obj.Send_Hard_Threshold_Notification__c = TRUE;
         obj.Async_Hard_Threshold__c = 13000;
         obj.Async_Soft_Threshold__c = 1000;
         obj.Async_Max_Limit__c = 15000;
         obj.Switch__c = True; 
         obj.Impact_Analysis__c = 'System Integration(s) Outage.';
         limitLST.add(obj);
        
         Limits_Threshold__c obj1 = new Limits_Threshold__c();
         obj1.Name='getLimitCallouts';
         obj1.Display_Name__c = 'Daily Api Requests';
         obj1.Limit_Type__c = 'Daily Limit';
         obj1.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
         obj1.Display_All__c = TRUE;
         obj1.Send_Soft_Threshold_Notification__c = TRUE;
         obj1.Send_Hard_Threshold_Notification__c = TRUE;
         obj1.Async_Hard_Threshold__c = 13000;
         obj1.Async_Soft_Threshold__c = 1000;
         obj1.Async_Max_Limit__c = 15000;
         obj1.Switch__c = True; 
         obj1.Impact_Analysis__c = 'System Integration(s) Outage.';
         limitLST.add(obj1);
        
         Limits_Threshold__c obj2 = new Limits_Threshold__c();
        obj2.Name='getLimitCpuTime';
        obj2.Display_Name__c = 'Daily Api Requests';
        obj2.Limit_Type__c = 'Daily Limit';
        obj2.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj2.Display_All__c = TRUE;
        obj2.Send_Soft_Threshold_Notification__c = TRUE;
        obj2.Send_Hard_Threshold_Notification__c = TRUE;
        obj2.Async_Hard_Threshold__c = 13000;
        obj2.Async_Soft_Threshold__c = 1000;
        obj2.Async_Max_Limit__c = 15000;
        obj2.Switch__c = True; 
        obj2.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj2);
        
        Limits_Threshold__c obj3 = new Limits_Threshold__c();
        obj3.Name='getLimitDmlRows';
        obj3.Display_Name__c = 'Daily Api Requests';
        obj3.Limit_Type__c = 'Daily Limit';
        obj3.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj3.Display_All__c = TRUE;
        obj3.Send_Soft_Threshold_Notification__c = TRUE;
        obj3.Send_Hard_Threshold_Notification__c = TRUE;
        obj3.Async_Hard_Threshold__c = 13000;
        obj3.Async_Soft_Threshold__c = 1000;
        obj3.Async_Max_Limit__c = 15000;
        obj3.Switch__c = True; 
        obj3.Impact_Analysis__c = 'System Integration(s) Outage.';
       limitLST.add(obj3);
       
        Limits_Threshold__c obj4 = new Limits_Threshold__c();
        obj4.Name='getLimitDMLStatements';
        obj4.Display_Name__c = 'Daily Api Requests';
        obj4.Limit_Type__c = 'Daily Limit';
        obj4.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj4.Display_All__c = TRUE;
        obj4.Send_Soft_Threshold_Notification__c = TRUE;
        obj4.Send_Hard_Threshold_Notification__c = TRUE;
        obj4.Async_Hard_Threshold__c = 13000;
        obj4.Async_Soft_Threshold__c = 1000;
        obj4.Async_Max_Limit__c = 15000;
        obj4.Switch__c = True; 
        obj4.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj4);
        
         Limits_Threshold__c obj5 = new Limits_Threshold__c();
        obj5.Name='getLimitEmailInvocations';
        obj5.Display_Name__c = 'Daily Api Requests';
        obj5.Limit_Type__c = 'Daily Limit';
        obj5.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj5.Display_All__c = TRUE;
        obj5.Send_Soft_Threshold_Notification__c = TRUE;
        obj5.Send_Hard_Threshold_Notification__c = TRUE;
        obj5.Async_Hard_Threshold__c = 13000;
        obj5.Async_Soft_Threshold__c = 1000;
        obj5.Async_Max_Limit__c = 15000;
        obj5.Switch__c = True; 
        obj5.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj5);
        
         Limits_Threshold__c obj6 = new Limits_Threshold__c();
        obj6.Name='getLimitFindSimilarCalls';
        obj6.Display_Name__c = 'Daily Api Requests';
        obj6.Limit_Type__c = 'Daily Limit';
        obj6.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj6.Display_All__c = TRUE;
        obj6.Send_Soft_Threshold_Notification__c = TRUE;
        obj6.Send_Hard_Threshold_Notification__c = TRUE;
        obj6.Async_Hard_Threshold__c = 13000;
        obj6.Async_Soft_Threshold__c = 1000;
        obj6.Async_Max_Limit__c = 15000;
        obj6.Switch__c = True; 
        obj6.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj6);
        
        
        Limits_Threshold__c obj7 = new Limits_Threshold__c();
        obj7.Name='getLimitFutureCalls';
        obj7.Display_Name__c = 'Daily Api Requests';
        obj7.Limit_Type__c = 'Daily Limit';
        obj7.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj7.Display_All__c = TRUE;
        obj7.Send_Soft_Threshold_Notification__c = TRUE;
        obj7.Send_Hard_Threshold_Notification__c = TRUE;
        obj7.Async_Hard_Threshold__c = 13000;
        obj7.Async_Soft_Threshold__c = 1000;
        obj7.Async_Max_Limit__c = 15000;
        obj7.Switch__c = True; 
        obj7.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj7);
        
         Limits_Threshold__c obj8 = new Limits_Threshold__c();
        obj8.Name='getLimitMobilePushApexCalls';
        obj8.Display_Name__c = 'Daily Api Requests';
        obj8.Limit_Type__c = 'Daily Limit';
        obj8.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj8.Display_All__c = TRUE;
        obj8.Send_Soft_Threshold_Notification__c = TRUE;
        obj8.Send_Hard_Threshold_Notification__c = TRUE;
        obj8.Async_Hard_Threshold__c = 13000;
        obj8.Async_Soft_Threshold__c = 1000;
        obj8.Async_Max_Limit__c = 15000;
        obj8.Switch__c = True; 
        obj8.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj8);
        
        
        Limits_Threshold__c obj9 = new Limits_Threshold__c();
        obj9.Name='getLimitQueries';
        obj9.Display_Name__c = 'Daily Api Requests';
        obj9.Limit_Type__c = 'Daily Limit';
        obj9.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj9.Display_All__c = TRUE;
        obj9.Send_Soft_Threshold_Notification__c = TRUE;
        obj9.Send_Hard_Threshold_Notification__c = TRUE;
        obj9.Async_Hard_Threshold__c = 13000;
        obj9.Async_Soft_Threshold__c = 1000;
        obj9.Async_Max_Limit__c = 15000;
        obj9.Switch__c = True; 
        obj9.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj9);
        
        
        Limits_Threshold__c obj10 = new Limits_Threshold__c();
        obj10.Name='getLimitQueryLocatorRows';
        obj10.Display_Name__c = 'Daily Api Requests';
        obj10.Limit_Type__c = 'Daily Limit';
        obj10.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj10.Display_All__c = TRUE;
        obj10.Send_Soft_Threshold_Notification__c = TRUE;
        obj10.Send_Hard_Threshold_Notification__c = TRUE;
        obj10.Async_Hard_Threshold__c = 13000;
        obj10.Async_Soft_Threshold__c = 1000;
        obj10.Async_Max_Limit__c = 15000;
        obj10.Switch__c = True; 
        obj10.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj10);
        
        
        Limits_Threshold__c obj11 = new Limits_Threshold__c();
        obj11.Name='getLimitQueryRows';
        obj11.Display_Name__c = 'Daily Api Requests';
        obj11.Limit_Type__c = 'Daily Limit';
        obj11.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj11.Display_All__c = TRUE;
        obj11.Send_Soft_Threshold_Notification__c = TRUE;
        obj11.Send_Hard_Threshold_Notification__c = TRUE;
        obj11.Async_Hard_Threshold__c = 13000;
        obj11.Async_Soft_Threshold__c = 1000;
        obj11.Async_Max_Limit__c = 15000;
        obj11.Switch__c = True; 
        obj11.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj11);
        
        
        Limits_Threshold__c obj12 = new Limits_Threshold__c();
        obj12.Name='getLimitQueueableJobs';
        obj12.Display_Name__c = 'Daily Api Requests';
        obj12.Limit_Type__c = 'Daily Limit';
        obj12.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj12.Display_All__c = TRUE;
        obj12.Send_Soft_Threshold_Notification__c = TRUE;
        obj12.Send_Hard_Threshold_Notification__c = TRUE;
        obj12.Async_Hard_Threshold__c = 13000;
        obj12.Async_Soft_Threshold__c = 1000;
        obj12.Async_Max_Limit__c = 15000;
        obj12.Switch__c = True; 
        obj12.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj12);
        
        
        Limits_Threshold__c obj13 = new Limits_Threshold__c();
        obj13.Name='getLimitRunAs';
        obj13.Display_Name__c = 'Daily Api Requests';
        obj13.Limit_Type__c = 'Daily Limit';
        obj13.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj13.Display_All__c = TRUE;
        obj13.Send_Soft_Threshold_Notification__c = TRUE;
        obj13.Send_Hard_Threshold_Notification__c = TRUE;
        obj13.Async_Hard_Threshold__c = 13000;
        obj13.Async_Soft_Threshold__c = 1000;
        obj13.Async_Max_Limit__c = 15000;
        obj13.Switch__c = True; 
        obj13.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj13);
        
        
        Limits_Threshold__c obj14 = new Limits_Threshold__c();
        obj14.Name='getLimitSavepointRollbacks';
        obj14.Display_Name__c = 'Daily Api Requests';
        obj14.Limit_Type__c = 'Daily Limit';
        obj14.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj14.Display_All__c = TRUE;
        obj14.Send_Soft_Threshold_Notification__c = TRUE;
        obj14.Send_Hard_Threshold_Notification__c = TRUE;
        obj14.Async_Hard_Threshold__c = 13000;
        obj14.Async_Soft_Threshold__c = 1000;
        obj14.Async_Max_Limit__c = 15000;
        obj14.Switch__c = True; 
        obj14.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj14);
        
        Limits_Threshold__c obj15 = new Limits_Threshold__c();
        obj15.Name='getLimitSavepoints';
        obj15.Display_Name__c = 'Daily Api Requests';
        obj15.Limit_Type__c = 'Daily Limit';
        obj15.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj15.Display_All__c = TRUE;
        obj15.Send_Soft_Threshold_Notification__c = TRUE;
        obj15.Send_Hard_Threshold_Notification__c = TRUE;
        obj15.Async_Hard_Threshold__c = 13000;
        obj15.Async_Soft_Threshold__c = 1000;
        obj15.Async_Max_Limit__c = 15000;
        obj15.Switch__c = True; 
        obj15.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj15);
        
        Limits_Threshold__c obj16 = new Limits_Threshold__c();
        obj16.Name='getLimitSoslQueries';
        obj16.Display_Name__c = 'Daily Api Requests';
        obj16.Limit_Type__c = 'Daily Limit';
        obj16.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj16.Display_All__c = TRUE;
        obj16.Send_Soft_Threshold_Notification__c = TRUE;
        obj16.Send_Hard_Threshold_Notification__c = TRUE;
        obj16.Async_Hard_Threshold__c = 13000;
        obj16.Async_Soft_Threshold__c = 1000;
        obj16.Async_Max_Limit__c = 15000;
        obj16.Switch__c = True; 
        obj16.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj16);
        
        Limits_Threshold__c obj17 = new Limits_Threshold__c();
        obj17.Name='getLimitHeapSize';
        obj17.Display_Name__c = 'Daily Api Requests';
        obj17.Limit_Type__c = 'Daily Limit';
        obj17.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj17.Display_All__c = TRUE;
        obj17.Send_Soft_Threshold_Notification__c = TRUE;
        obj17.Send_Hard_Threshold_Notification__c = TRUE;
        obj17.Async_Hard_Threshold__c = 13000;
        obj17.Async_Soft_Threshold__c = 1000;
        obj17.Async_Max_Limit__c = 15000;
        obj17.Switch__c = True; 
        obj17.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj17);
        
        Limits_Threshold__c obj18 = new Limits_Threshold__c();
        obj18.Name='getLimitAggregateQueries';
        obj18.Display_Name__c = 'Daily Api Requests';
        obj18.Limit_Type__c = 'Daily Limit';
        obj18.Measure__c = 'Identify & optimize Client Applications/Partner Products. If optimization not possible, get the limit extended from Salesforce.';
        obj18.Display_All__c = TRUE;
        obj18.Send_Soft_Threshold_Notification__c = TRUE;
        obj18.Send_Hard_Threshold_Notification__c = TRUE;
        obj18.Async_Hard_Threshold__c = 13000;
        obj18.Async_Soft_Threshold__c = 1000;
        obj18.Async_Max_Limit__c = 15000;
        obj18.Switch__c = True; 
        obj18.Impact_Analysis__c = 'System Integration(s) Outage.';
        limitLST.add(obj18);
        
        insert limitLST;
        document  doc= new Document();
        doc.Body = Blob.valueOf('Some Text');
        doc.ContentType = 'application/pdf';
        doc.DeveloperName = 'Company_Logo1';
        doc.IsPublic = true;
        doc.Name = 'Company Logo';
        doc.FolderId = [select id from folder where name = 'Public Documents'].id;
        insert doc;
        test.startTest();
        
        DHC_SystemLimitUsageController objclass = new DHC_SystemLimitUsageController();
          objclass.refreshMaxLimit();
      
      }
}