@isTest(SeeAllData=false)
private class DHC_StaticLimitControllerTest{
   static testMethod void dailyDisplayData(){ 
   
   Limits_Notification__c objlst = new Limits_Notification__c();
   objlst.Breach_Count__c = 1;
   objlst.Priority__c = 'Yellow';
   objlst.Component_Name__c = 'AccountCheck';
   objlst.Entry_Point__c ='Account';
   objlst.Flow__c='Account';
   objlst.Hard_Threshold__c=100;
   objlst.Impact_Analysis__c='Impact';
   objlst.Limit_Type__c='Runtime Limit';    
   objlst.Display_Name__c ='Limit Queries';
   objlst.Limit_Utilization__c=70;
   objlst.Max_Limit__c=150;
   objlst.Send_Hard_Threshold_Notification__c = false;
   objlst.Send_Soft_Threshold_Notification__c= false;
   objlst.Sobject_Name__c ='Account';
   objlst.Soft_Threshold__c=60;
   objlst.UnquieKey__c='Account-AccountCheck-60-getLimitQueries-Yellow';
   insert objlst;
   
   Limits_Notification__c objlst1 = new Limits_Notification__c();
   objlst1.Breach_Count__c = 1;
   objlst1.Priority__c = 'Red';
   objlst1.Component_Name__c = 'AccountCheck';
   objlst1.Entry_Point__c ='Account';
   objlst1.Flow__c='Account';
   objlst1.Hard_Threshold__c=80;
   objlst1.Impact_Analysis__c='Impact';
   objlst1.Limit_Type__c='Runtime Limit';    
   objlst1.Display_Name__c ='Limit Queries';
   objlst1.Limit_Utilization__c=90;
   objlst1.Max_Limit__c=150;
   objlst1.Send_Hard_Threshold_Notification__c = false;
   objlst1.Send_Soft_Threshold_Notification__c= false;
   objlst1.Sobject_Name__c ='Account';
   objlst1.Soft_Threshold__c=60;
   objlst1.UnquieKey__c='Account-AccountCheck-90-getLimitQueries-Red';
   insert objlst1;
   
    DHC_StaticLimitController  obj = new DHC_StaticLimitController();
    obj.onclickRunTime();
    obj.hardLimitChartBySobject();
    obj.hardLimitChartByComponent();
    obj.hardLimitChartByType();
    obj.softLimitChartBySobject();
    obj.softLimitChartByComponent();
    obj.softLimitChartByType();
    obj.hardLimitmethodByType();
    obj.softLimitmethodByType();
    obj.hardLimitmethodBySobject();
    obj.softLimitmethodBySobject();
    obj.hardLimitmethodByComponent();
    obj.softLimitmethodByComponent();
    
    }

}