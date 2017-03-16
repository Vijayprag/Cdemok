public class DHC_StaticThresholdBreachCalculation{
    public static List<Limits_Notification__c> hardLimitLst;
    public static List<Limits_Notification__c> softLimitLst;
    public static String triggerFlow{get; set;}
    public static Boolean testClassSkip = false;
   
      /**
     * Name: triggerFlow
     * Description: This method is used for concatenation all the trigger flow.
     * @parameters: NONE
     * @return: String
    **/
    public static String triggerFlow(String TriggerName, String ObjectName){
        if(!Test.isRunningTest()){
            string flowStr;
            if(Trigger.isBefore){
                if(Trigger.isInsert){
                    flowStr = (DHC_StaticThresholdBreachCalculation.triggerFlow != null ? DHC_StaticThresholdBreachCalculation.triggerFlow : '') + ('' + ObjectName +'.'+ TriggerName +'.'+ +'isBefore'+ +'.'+ +'isInsert') + '-->';
                }else{
                    flowStr = (DHC_StaticThresholdBreachCalculation.triggerFlow != null ? DHC_StaticThresholdBreachCalculation.triggerFlow : '') + ('' + ObjectName +'.'+ TriggerName +'.'+ +'isBefore'+ +'.'+ +'isUpdate') + '-->';
                }
            }else if(Trigger.isAfter){
                if(Trigger.isInsert){
                    
                    flowStr = flowStr = (DHC_StaticThresholdBreachCalculation.triggerFlow != null ? DHC_StaticThresholdBreachCalculation.triggerFlow : '') + ('' + ObjectName +'.'+ TriggerName +'.'+ +'isAfter'+ +'.'+ +'isInsert') + '-->';
                }else{
                    flowStr = flowStr = (DHC_StaticThresholdBreachCalculation.triggerFlow != null ? DHC_StaticThresholdBreachCalculation.triggerFlow : '') + ('' + ObjectName +'.'+ TriggerName +'.'+ +'isAfter'+ +'.'+ +'isUpdate') + '-->';
                }
            }
            return flowStr;
        }else{
             return null;
        }
        
    }
    public static void evaluateLimitThresholdBreach (String sobjectType, Decimal limitUtilization, string ComponentName, String TriggerFlowData, Decimal hardThreshold, Decimal softThreshold, 
                                          Decimal maxLimit, String measure, String limitName, String displayName, boolean hardThresholdEmail, boolean softThresholdEmail, boolean switchSet, string impactAnalysis){
        
        if(switchSet && (limitUtilization >=  hardThreshold || limitUtilization >=  softThreshold)){
            Limits_Notification__c notificationObj = new Limits_Notification__c();
            notificationObj.Sobject_Name__c = sobjectType;
            notificationObj.Limit_Utilization__c = limitUtilization;
            notificationObj.Limit_Type__c = DHC_ConstantsUtils.RUNTIMELIMIT;
            notificationObj.Component_Name__c = ComponentName;
            notificationObj.Hard_Threshold__c = hardThreshold;
            notificationObj.Soft_Threshold__c = softThreshold;
            notificationObj.Max_Limit__c = maxLimit;
            notificationObj.Impact_Analysis__c = impactAnalysis;
            notificationObj.measure__c = measure;
            notificationObj.Breach_Count__c=1;
            notificationObj.Flow__c = TriggerFlowData;
            integer iend = TriggerFlowData.indexOf('.');
            if(iend != -1){
                notificationObj.Entry_Point__c = TriggerFlowData.substring(0,iend);
            }
           
            notificationObj.Display_Name__c = displayName;
            notificationObj.Send_Hard_Threshold_Notification__c = hardThresholdEmail;
            notificationObj.Send_Soft_Threshold_Notification__c = softThresholdEmail;
            if(limitUtilization >=  hardThreshold){
                notificationObj.Priority__c = DHC_ConstantsUtils.RED;
                notificationObj.UnquieKey__c = sobjectType+DHC_ConstantsUtils.DHC_DASH+ComponentName+DHC_ConstantsUtils.DHC_DASH+limitUtilization +DHC_ConstantsUtils.DHC_DASH+limitName+DHC_ConstantsUtils.DHC_DASH+ DHC_ConstantsUtils.RED;
                hardLimitLst.add(notificationObj);
            } else {
                notificationObj.Priority__c = DHC_ConstantsUtils.YELLOW;
                notificationObj.UnquieKey__c = sobjectType+DHC_ConstantsUtils.DHC_DASH+ComponentName+DHC_ConstantsUtils.DHC_DASH+limitUtilization +DHC_ConstantsUtils.DHC_DASH+limitName+DHC_ConstantsUtils.DHC_DASH+ DHC_ConstantsUtils.YELLOW;
                softLimitLst.add(notificationObj);
            }
        }
    }
    public static void fetchRunTimeLimitStatus(String sobjectType, string ComponentName, String TriggerFlowStr){
        if(!Test.isRunningTest() || testClassSkip){
            hardLimitLst = new List<Limits_Notification__c>();
            softLimitLst = new List<Limits_Notification__c>();
            
            /* 1 Calculate Async Calls */
            Limits_Threshold__c limitsObj = Limits_Threshold__c.getvalues('getLimitAsyncCalls');
            Decimal limitUtilization = Limits.getAsyncCalls();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 2 Calculate Limit Callouts */
            limitsObj = Limits_Threshold__c.getvalues('getLimitCallouts');
            limitUtilization = Limits.getCallouts();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName,TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 3 Calculate CPU Time Limit */
            limitsObj = Limits_Threshold__c.getvalues('getLimitCpuTime');
            limitUtilization = Limits.getCpuTime();
            if(limitsObj !=null){
                if(!System.isFuture() && !System.isBatch()){
                        evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                } else {
                    evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Async_Hard_Threshold__c, limitsObj.Async_Soft_Threshold__c, limitsObj.Async_Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                }
            }
            
            /* 4 Calculate DML Rows */
            limitsObj = Limits_Threshold__c.getvalues('getLimitDmlRows');
            limitUtilization = Limits.getDMLRows();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c,
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 5 Calculate DML Statements */
            limitsObj = Limits_Threshold__c.getvalues('getLimitDMLStatements');
            limitUtilization = Limits.getDMLStatements();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 6 Calculate Email Invocations */
            limitsObj = Limits_Threshold__c.getvalues('getLimitEmailInvocations');
            limitUtilization = Limits.getEmailInvocations();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 7 Calculate Similar Calls */
            limitsObj = Limits_Threshold__c.getvalues('getLimitFindSimilarCalls');
            limitUtilization = Limits.getFindSimilarCalls();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c,  
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 8 Calculate Future Calls */
            limitsObj = Limits_Threshold__c.getvalues('getLimitFutureCalls');
            limitUtilization = Limits.getFutureCalls();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 9 Calculate Head Size */
            limitsObj = Limits_Threshold__c.getvalues('getLimitHeapSize');
            limitUtilization = Limits.getHeapSize();
            if(limitsObj !=null){
                if(!System.isFuture() && !System.isBatch()){
                    evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                } else {
                    evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Async_Hard_Threshold__c, limitsObj.Async_Soft_Threshold__c, limitsObj.Async_Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                
                }
            }
            
            /* 10 Calculate Mobile Push Apex Calls */
            limitsObj = Limits_Threshold__c.getvalues('getLimitMobilePushApexCalls');
            limitUtilization = Limits.getMobilePushApexCalls();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 11 Calculate Limit Queries */
            limitsObj = Limits_Threshold__c.getvalues('getLimitQueries');
            limitUtilization = Limits.getQueries();
            if(limitsObj !=null){
                if(!System.isFuture() && !System.isBatch()){
                        evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                } else {
                    evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Async_Hard_Threshold__c, limitsObj.Async_Soft_Threshold__c, limitsObj.Async_Max_Limit__c, limitsObj.measure__c, 
                                                             limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
                }
            }
            
            /* 12 Calculate Query Locator rows */
            limitsObj = Limits_Threshold__c.getvalues('getLimitQueryLocatorRows');
            limitUtilization = Limits.getQueryLocatorRows();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 13 Calculate Query Rows */
            limitsObj = Limits_Threshold__c.getvalues('getLimitQueryRows');
            limitUtilization = Limits.getQueryRows();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 14 Calculate Queueable Jobs */
            limitsObj = Limits_Threshold__c.getvalues('getLimitQueueableJobs');
            limitUtilization = Limits.getQueueableJobs();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 15 Calculate Run As Limit */
            limitsObj = Limits_Threshold__c.getvalues('getLimitRunAs');
            limitUtilization = Limits.getRunAs();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 16 Calculate Savepoint Rollback */
            limitsObj = Limits_Threshold__c.getvalues('getLimitSavepointRollbacks');
            limitUtilization = Limits.getSavepointRollbacks();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 17 Calculate Savepoints */
            limitsObj = Limits_Threshold__c.getvalues('getLimitSavepoints');
            limitUtilization = Limits.getSavepoints();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            /* 18 Calculate SOSL Queries */
            limitsObj = Limits_Threshold__c.getvalues('getLimitSoslQueries');
            limitUtilization = Limits.getSoslQueries();
            if(limitsObj !=null){
                evaluateLimitThresholdBreach(sobjectType,limitUtilization, ComponentName, TriggerFlowStr, limitsObj.Hard_Threshold__c, limitsObj.Soft_Threshold__c, limitsObj.Max_Limit__c, limitsObj.measure__c, 
                                                         limitsObj.Name, limitsObj.Display_Name__c, limitsObj.Send_Hard_Threshold_Notification__c, limitsObj.Send_Soft_Threshold_Notification__c,limitsObj.Switch__c,limitsObj.Impact_Analysis__c);
            }
            
            if(!softLimitLst.isEmpty()){
                Database.Upsert(softLimitLst,Limits_Notification__c.UnquieKey__c.getDescribe().getSObjectField(),false);
            }
            if(!hardLimitLst.isEmpty()){
                 Database.Upsert(hardLimitLst,Limits_Notification__c.UnquieKey__c.getDescribe().getSObjectField(),false);
            }
        }
    }   
}