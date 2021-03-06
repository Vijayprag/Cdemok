/*******************************************************************************************************************************   
*   Name:           DHC_ConsolidatedBreachViewController 
*   Description:    This class is used for generate excel report
*   Author:             Accenture
*   Date                PRJ#          Summary of Changes
*   8/30/2016           DHC           Initial
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************************/
public class DHC_ConsolidatedBreachViewController {
    public List<Limits_Notification__c> runTimelimitNotificationList{get; set;}
    public DHC_ConsolidatedBreachViewController ()
    {
       runTimelimitNotificationList = new List<Limits_Notification__c>();
       for (Limits_Notification__c ln : [Select id, Name, Measure__c, Priority__c, Component_Name__c, First_Breach__c, Hard_Threshold__c, Latest_Breach__c,
                                         Limit_Type__c, Display_Name__c, Limit_Utilization__c, Max_Limit__c, Send_Hard_Threshold_Notification__c, 
                                         Send_Soft_Threshold_Notification__c, Sobject_Name__c, Soft_Threshold__c, Unit__c from Limits_Notification__c 
                                         where createdDate = Today AND Limit_Type__c != 'Runtime Limit' AND Priority__c !='Green' order by Priority__c,CreatedDate  desc limit 100])
       {       
           runTimelimitNotificationList.add(ln);
       }
    }
}