@isTest(SeeAllData=false)
private class DHC_ConsolidatedBreachViewControllerTest{
    static testMethod void dailyDisplayData(){ 
        Limits_Notification__c obj = new Limits_Notification__c();
        obj.Impact_Analysis__c ='Business Process/Logic interruption.';
        obj.Limit_Type__c ='Daily Limit';
        obj.Display_Name__c ='Streaming Api Concurrent Clients';
        obj.Limit_Utilization__c =12;
        obj.Max_Limit__c =20;
        obj.Soft_Threshold__c =10;
        obj.Measure__c ='Business Team : Please get this limit extended from Salesforce.';
        obj.Hard_Threshold__c =15;
        obj.Priority__c = 'Red';
        insert obj;
        DHC_ConsolidatedBreachViewController con = new DHC_ConsolidatedBreachViewController();
        
    }
     static testMethod void runtimeDisplayData(){ 
        Limits_Notification__c obj = new Limits_Notification__c();
        obj.Limit_Type__c ='Runtime Limit';
        obj.Display_Name__c ='Limit Future Calls';
        obj.Limit_Utilization__c =35;
        obj.Max_Limit__c =50;
        obj.Soft_Threshold__c =30;
       obj.Hard_Threshold__c =35;
        obj.Priority__c = 'Red';
        insert obj;
        //DHC_ConRuntimeBreachViewController con = new DHC_ConRuntimeBreachViewController();
        
    }
}