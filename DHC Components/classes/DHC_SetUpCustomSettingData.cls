/****************************************************************************************************************
*   Name:           SetUpCustomSettingData
*   Description:    This class is used to Setup Data in custom setting for Daily and Runtime Limit.
*   Author:             Accenture
*   Date                PRJ/DHC#          Summary of Changes 
*   ---------------     ------------------    ----------------------------------------
***********************************************************************************************************/
public class DHC_SetUpCustomSettingData{
    
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
    
    /**
     * Name: calculateMaxLimit
     * Description: This method is used for Calculate Max limit for RunTime Limit.
     * @parameters: NONE
     * @return: NONE
    **/
    public static void calculateMaxLimit(){
                List<Limits_Threshold__c> thresholdCustomSettingList = new List<Limits_Threshold__c>();
        /* 1 Fetch Async Calls Max Limit */
        Limits_Threshold__c limitsObj = Limits_Threshold__c.getvalues('getLimitAsyncCalls');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitAsyncCalls();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitAsyncCalls();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        /* 2 Fetch Limit Callouts Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitCallouts');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitCallouts();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitCallouts();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round() ;
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        /* 3 Fetch CPU Time Limit Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitCpuTime');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitCpuTime();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitCpuTime();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round() ;
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 4 Fetch DML Rows Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitDmlRows');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitDmlRows();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitDmlRows();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round() ;
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 5 Fetch DML Statements Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitDMLStatements');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitDMLStatements();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitDMLStatements();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round() ;
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 6 Fetch Email Invocations Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitEmailInvocations');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitEmailInvocations();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitEmailInvocations();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round() ;
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 7 Fetch Similar Calls Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitFindSimilarCalls');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitFindSimilarCalls();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitFindSimilarCalls();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 8 Fetch Future Calls Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitFutureCalls');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitFutureCalls();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitFutureCalls();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 9 Fetch Head Size Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitHeapSize');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitHeapSize();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitHeapSize();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 10 Fetch Mobile Push Apex Calls Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitMobilePushApexCalls');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitMobilePushApexCalls();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitMobilePushApexCalls();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 11 Fetch Limit Queries Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitQueries');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitQueries();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitQueries();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 12 Fetch Query Locator rows Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitQueryLocatorRows');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitQueryLocatorRows();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitQueryLocatorRows();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 13 Fetch Query Rows Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitQueryRows');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitQueryRows();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitQueryRows();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 14 Fetch Queueable Jobs Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitQueueableJobs');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitQueueableJobs();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitQueueableJobs();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 15 Fetch Run As Limit Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitRunAs');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitRunAs();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitRunAs();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 16 Fetch Savepoint Rollback Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitSavepointRollbacks');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitSavepointRollbacks();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitSavepointRollbacks();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 17 Fetch Savepoints Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitSavepoints');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitSavepoints();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitSavepoints();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 18 Fetch SOSL Queries Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitSoslQueries');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitSoslQueries();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitSoslQueries();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        
        /* 19 Fetch SOSL Queries Max Limit */
        limitsObj = Limits_Threshold__c.getvalues('getLimitAggregateQueries');
        if(limitsObj !=null){
            if(!System.isFuture() && !System.isBatch()){
                limitsObj.Max_Limit__c = Limits.getLimitAggregateQueries();
                limitsObj.Hard_Threshold__c = (limitsObj.Max_Limit__c * (0.85)).round() ;
                limitsObj.Soft_Threshold__c = (limitsObj.Max_Limit__c * (0.70)).round() ;
                thresholdCustomSettingList.add(limitsObj);
            } else {
                limitsObj.Async_Max_Limit__c = Limits.getLimitAggregateQueries();
                limitsObj.Async_Hard_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.85)).round();
                limitsObj.Async_Soft_Threshold__c = (limitsObj.Async_Max_Limit__c * (0.70)).round();
                thresholdCustomSettingList.add(limitsObj);
            }
        }
        update thresholdCustomSettingList;
        
    }
    
    /**
     * Name: calculateMaxLimit
     * Description: This method is used for Calculate Max limit for Daily Limit.
     * @parameters: NONE
     * @return: NONE
    **/
    Public static void setupCustomSettingRecords(){
        List<Limits_Threshold__c> limitThreshold = Limits_Threshold__c.getall().values();
        if(limitThreshold.isEmpty()){
            List<Limits_Threshold__c> limitThresholdLst = new List<Limits_Threshold__c> ();
            /* Start Insert Custom Setting Concurrent Limit data */
            Limits_Threshold__c limitThresholdObj = new Limits_Threshold__c();
            limitThresholdObj.Name = 'ConcurrentAsyncGetReportInstances';
            limitThresholdObj.Display_Name__c = 'Concurrent Async Get Report Instances';
            limitThresholdObj.Limit_Type__c =   'Concurrent Limit';
            limitThresholdObj.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj.Display_All__c = true;
            limitThresholdObj.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj);

            Limits_Threshold__c limitThresholdObj1 = new Limits_Threshold__c();
            limitThresholdObj1.Name = 'ConcurrentSyncReportRuns';
            limitThresholdObj1.Display_Name__c = 'Concurrent Sync Report Runs';
            limitThresholdObj1.Limit_Type__c =  'Concurrent Limit';
            limitThresholdObj1.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj1.Display_All__c = true;
            limitThresholdObj1.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj1);

            Limits_Threshold__c limitThresholdObj2 = new Limits_Threshold__c();
            limitThresholdObj2.Name = 'DurableStreamingApiConcurrentClients';
            limitThresholdObj2.Display_Name__c = 'Durable Streaming Api Concurrent Clients';
            limitThresholdObj2.Limit_Type__c =  'Concurrent Limit';
            limitThresholdObj2.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj2.Display_All__c = true;
            limitThresholdObj2.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj2);
            /* End Insert Custom Setting Concurrent Limit data */

            /* Start Insert Custom Setting System Storage Limit data */
            Limits_Threshold__c limitThresholdObj3 = new Limits_Threshold__c();
            limitThresholdObj3.Name = 'DataStorageMB';
            limitThresholdObj3.Display_Name__c = 'Data Storage MB';
            limitThresholdObj3.Limit_Type__c =  'System Storage Limit';
            limitThresholdObj3.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj3.Display_All__c = true;
            limitThresholdObj3.Switch__c = true;
            limitThresholdObj3.Unit__c = 'MB';
            limitThresholdLst.add(limitThresholdObj3);

            Limits_Threshold__c limitThresholdObj4 = new Limits_Threshold__c();
            limitThresholdObj4.Name = 'FileStorageMB';
            limitThresholdObj4.Display_Name__c = 'File Storage MB';
            limitThresholdObj4.Limit_Type__c =  'System Storage Limit';
            limitThresholdObj4.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj4.Display_All__c = true;
            limitThresholdObj4.Switch__c = true;
            limitThresholdObj4.Unit__c = 'MB';
            limitThresholdLst.add(limitThresholdObj4);
            /* End Insert Custom Setting System Storage Limit data */

            /* Start Insert Custom Setting Hourly  Limit data */
            Limits_Threshold__c limitThresholdObj5 = new Limits_Threshold__c();
            limitThresholdObj5.Name = 'HourlyAsyncReportRuns';
            limitThresholdObj5.Display_Name__c = 'Hourly Async Report Runs';
            limitThresholdObj5.Limit_Type__c =  'Hourly Limit';
            limitThresholdObj5.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj5.Display_All__c = true;
            limitThresholdObj5.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj5);

            Limits_Threshold__c limitThresholdObj6 = new Limits_Threshold__c();
            limitThresholdObj6.Name = 'HourlyDashboardRefreshes';
            limitThresholdObj6.Display_Name__c = 'Hourly Dashboard Refreshes';
            limitThresholdObj6.Limit_Type__c =  'Hourly Limit';
            limitThresholdObj6.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj6.Display_All__c = true;
            limitThresholdObj6.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj6);

            Limits_Threshold__c limitThresholdObj7 = new Limits_Threshold__c();
            limitThresholdObj7.Name = 'HourlyDashboardResults';
            limitThresholdObj7.Display_Name__c = 'Hourly Dashboard Results';
            limitThresholdObj7.Limit_Type__c =  'Hourly Limit';
            limitThresholdObj7.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj7.Display_All__c = true;
            limitThresholdObj7.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj7);

            Limits_Threshold__c limitThresholdObj8 = new Limits_Threshold__c();
            limitThresholdObj8.Name = 'HourlyDashboardStatuses';
            limitThresholdObj8.Display_Name__c = 'Hourly Dashboard Statuses';
            limitThresholdObj8.Limit_Type__c =  'Hourly Limit';
            limitThresholdObj8.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj8.Display_All__c = true;
            limitThresholdObj8.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj8);

            Limits_Threshold__c limitThresholdObj9 = new Limits_Threshold__c();
            limitThresholdObj9.Name = 'HourlyODataCallout';
            limitThresholdObj9.Display_Name__c = 'Hourly O DataCallout';
            limitThresholdObj9.Limit_Type__c =  'Hourly Limit';
            limitThresholdObj9.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj9.Display_All__c = true;
            limitThresholdObj9.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj9);

            Limits_Threshold__c limitThresholdObj10 = new Limits_Threshold__c();
            limitThresholdObj10.Name = 'HourlySyncReportRuns';
            limitThresholdObj10.Display_Name__c = 'Hourly Sync Report Runs';
            limitThresholdObj10.Limit_Type__c = 'Hourly Limit';
            limitThresholdObj10.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj10.Display_All__c = true;
            limitThresholdObj10.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj10);

            Limits_Threshold__c limitThresholdObj11 = new Limits_Threshold__c();
            limitThresholdObj11.Name = 'HourlyTimeBasedWorkflow';
            limitThresholdObj11.Display_Name__c = 'Hourly Time Based Workflow';
            limitThresholdObj11.Limit_Type__c = 'Hourly Limit';
            limitThresholdObj11.Measure__c = 'Business Team : If repetitive breaches observed, please get this limit extended from Salesforce.';
            limitThresholdObj11.Display_All__c = true;
            limitThresholdObj11.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj11);
            /* End Insert Custom Setting Hourly  Limit data */

            /* Start Insert Custom Setting System Storage Limit data */

            Limits_Threshold__c limitThresholdObj12 = new Limits_Threshold__c();
            limitThresholdObj12.Name = 'DailyApiRequests';
            limitThresholdObj12.Display_Name__c = 'Daily Api Requests';
            limitThresholdObj12.Limit_Type__c = 'Daily Limit';
            limitThresholdObj12.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj12.Display_All__c = true;
            limitThresholdObj12.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj12);

            Limits_Threshold__c limitThresholdObj13 = new Limits_Threshold__c();
            limitThresholdObj13.Name = 'DailyAsyncApexExecutions';
            limitThresholdObj13.Display_Name__c = 'Daily Async Apex Executions';
            limitThresholdObj13.Limit_Type__c = 'Daily Limit';
            limitThresholdObj13.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj13.Display_All__c = true;
            limitThresholdObj13.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj13);

            Limits_Threshold__c limitThresholdObj14 = new Limits_Threshold__c();
            limitThresholdObj14.Name = 'DailyBulkApiRequests';
            limitThresholdObj14.Display_Name__c = 'Daily Bulk Api Requests';
            limitThresholdObj14.Limit_Type__c = 'Daily Limit';
            limitThresholdObj14.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj14.Display_All__c = true;
            limitThresholdObj14.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj14);

            Limits_Threshold__c limitThresholdObj15 = new Limits_Threshold__c();
            limitThresholdObj15.Name = 'DailyDurableGenericStreamingApiEvents';
            limitThresholdObj15.Display_Name__c = 'Daily Durable Generic Streaming Api Events';
            limitThresholdObj15.Limit_Type__c = 'Daily Limit';
            limitThresholdObj15.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj15.Display_All__c = true;
            limitThresholdObj15.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj15);

            Limits_Threshold__c limitThresholdObj16 = new Limits_Threshold__c();
            limitThresholdObj16.Name = 'DailyStreamingApiEvents';
            limitThresholdObj16.Display_Name__c = 'Daily Streaming Api Events';
            limitThresholdObj16.Limit_Type__c = 'Daily Limit';
            limitThresholdObj16.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj16.Display_All__c = true;
            limitThresholdObj16.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj16);

            Limits_Threshold__c limitThresholdObj17 = new Limits_Threshold__c();
            limitThresholdObj17.Name = 'DailyDurableStreamingApiEvents';
            limitThresholdObj17.Display_Name__c = 'Daily Durable Streaming Api Events';
            limitThresholdObj17.Limit_Type__c = 'Daily Limit';
            limitThresholdObj17.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj17.Display_All__c = true;
            limitThresholdObj17.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj17);

            Limits_Threshold__c limitThresholdObj18 = new Limits_Threshold__c();
            limitThresholdObj18.Name = 'DailyGenericStreamingApiEvents';
            limitThresholdObj18.Display_Name__c = 'Daily Generic Streaming Api Events';
            limitThresholdObj18.Limit_Type__c = 'Daily Limit';
            limitThresholdObj18.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj18.Display_All__c = true;
            limitThresholdObj18.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj18);

            Limits_Threshold__c limitThresholdObj20 = new Limits_Threshold__c();
            limitThresholdObj20.Name = 'DailyWorkflowEmails';
            limitThresholdObj20.Display_Name__c = 'Daily Workflow Emails';
            limitThresholdObj20.Limit_Type__c = 'Daily Limit';
            limitThresholdObj20.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj20.Display_All__c = true;
            limitThresholdObj20.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj20);

            Limits_Threshold__c limitThresholdObj21 = new Limits_Threshold__c();
            limitThresholdObj21.Name = 'MassEmail';
            limitThresholdObj21.Display_Name__c = 'Mass Email';
            limitThresholdObj21.Limit_Type__c = 'Daily Limit';
            limitThresholdObj21.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj21.Display_All__c = true;
            limitThresholdObj21.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj21);

            Limits_Threshold__c limitThresholdObj22 = new Limits_Threshold__c();
            limitThresholdObj22.Name = 'SingleEmail';
            limitThresholdObj22.Display_Name__c = 'Single Email';
            limitThresholdObj22.Limit_Type__c = 'Daily Limit';
            limitThresholdObj22.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj22.Display_All__c = true;
            limitThresholdObj22.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj22);

            Limits_Threshold__c limitThresholdObj23 = new Limits_Threshold__c();
            limitThresholdObj23.Name = 'StreamingApiConcurrentClients';
            limitThresholdObj23.Display_Name__c = 'Streaming Api Concurrent Clients';
            limitThresholdObj23.Limit_Type__c = 'Daily Limit';
            limitThresholdObj23.Measure__c = 'Business Team : please get this limit extended from Salesforce.';
            limitThresholdObj23.Display_All__c = true;
            limitThresholdObj23.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj23);

            /* End Insert Custom Setting System Storage Limit data */
            /* Start Insert Custom Setting Run Time Limit data */
            Limits_Threshold__c limitThresholdObj24 = new Limits_Threshold__c();
            limitThresholdObj24.Name = 'getLimitAggregateQueries';
            limitThresholdObj24.Display_Name__c = 'Limit Aggregate Queries';
            limitThresholdObj24.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj24.Measure__c = 'Development/Support Team : please optimize the code to reduce aggregate queries.';
            limitThresholdObj24.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj24);
            
            Limits_Threshold__c limitThresholdObj25 = new Limits_Threshold__c();
            limitThresholdObj25.Name = 'getLimitAsyncCalls';
            limitThresholdObj25.Display_Name__c = 'Limit Async Calls';
            limitThresholdObj25.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj25.Measure__c = 'Development/Support Team : please optimize the code to reduce asynchronous calls.';
            limitThresholdObj25.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj25);
            
            Limits_Threshold__c limitThresholdObj26 = new Limits_Threshold__c();
            limitThresholdObj26.Name = 'getLimitCallouts';
            limitThresholdObj26.Display_Name__c = 'Limit Callouts';
            limitThresholdObj26.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj26.Measure__c = 'Development/Support Team : please optimize the code to reduce callouts.';
            limitThresholdObj26.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj26);
            
            Limits_Threshold__c limitThresholdObj27 = new Limits_Threshold__c();
            limitThresholdObj27.Name = 'getLimitCpuTime';
            limitThresholdObj27.Display_Name__c = 'Limit Cpu Time';
            limitThresholdObj27.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj27.Measure__c = 'Development/Support Team : please optimize the code to reduce cyclomatic complexity and logically split transactions.';
            limitThresholdObj27.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj27);
            
            Limits_Threshold__c limitThresholdObj28 = new Limits_Threshold__c();
            limitThresholdObj28.Name = 'getLimitDmlRows';
            limitThresholdObj28.Display_Name__c = 'Limit Dml Rows';
            limitThresholdObj28.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj28.Measure__c = 'Development/Support Team : please optimize the code to process less records in SOQL for loops.';
            limitThresholdObj28.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj28);
            
            Limits_Threshold__c limitThresholdObj29 = new Limits_Threshold__c();
            limitThresholdObj29.Name = 'getLimitDMLStatements';
            limitThresholdObj29.Display_Name__c = 'Limit DML Statements';
            limitThresholdObj29.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj29.Measure__c = 'Development/Support Team : please optimize the code to reduce DML statements.';
            limitThresholdObj29.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj29);
            
            Limits_Threshold__c limitThresholdObj30 = new Limits_Threshold__c();
            limitThresholdObj30.Name = 'getLimitEmailInvocations';
            limitThresholdObj30.Display_Name__c = 'Limit Email Invocations';
            limitThresholdObj30.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj30.Measure__c = 'Development/Support Team : please optimize the code to reduce email invocations in a transaction.';
            limitThresholdObj30.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj30);
            
            Limits_Threshold__c limitThresholdObj31 = new Limits_Threshold__c();
            limitThresholdObj31.Name = 'getLimitFindSimilarCalls';
            limitThresholdObj31.Display_Name__c = 'Limit Find Similar Calls';
            limitThresholdObj31.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj31.Measure__c = 'Development/Support Team : please optimize the code to reduce Find Similar Calls.';
            limitThresholdObj31.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj31);
            
            Limits_Threshold__c limitThresholdObj32 = new Limits_Threshold__c();
            limitThresholdObj32.Name = 'getLimitFutureCalls';
            limitThresholdObj32.Display_Name__c = 'Limit Future Calls';
            limitThresholdObj32.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj32.Measure__c = 'Development/Support Team : please optimize the code to reduce Future Calls.';
            limitThresholdObj32.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj32);
            
            Limits_Threshold__c limitThresholdObj34 = new Limits_Threshold__c();
            limitThresholdObj34.Name = 'getLimitHeapSize';
            limitThresholdObj34.Display_Name__c = 'Limit Heap Size';
            limitThresholdObj34.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj34.Measure__c = 'Development/Support Team : please optimize the code to reduce persistance/query of unwanted data.';
            limitThresholdObj34.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj34);
            
            Limits_Threshold__c limitThresholdObj35 = new Limits_Threshold__c();
            limitThresholdObj35.Name = 'getLimitMobilePushApexCalls';
            limitThresholdObj35.Display_Name__c = 'Limit Mobile Push Apex Calls';
            limitThresholdObj35.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj35.Measure__c = 'Development/Support Team : please optimize the code to reduce Mobile Push Apex Calls.';
            limitThresholdObj35.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj35);
            
            Limits_Threshold__c limitThresholdObj36 = new Limits_Threshold__c();
            limitThresholdObj36.Name = 'getLimitQueries';
            limitThresholdObj36.Display_Name__c = 'Limit Queries';
            limitThresholdObj36.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj36.Measure__c = 'Development/Support Team : please optimize the code to reduce SOQL queries by combining queries or avoiding repetitive method calls.';
            limitThresholdObj36.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj36);
            
            Limits_Threshold__c limitThresholdObj37 = new Limits_Threshold__c();
            limitThresholdObj37.Name = 'getLimitQueryLocatorRows';
            limitThresholdObj37.Display_Name__c = 'Limit Query Locator Rows';
            limitThresholdObj37.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj37.Measure__c = 'Development/Support Team : please optimize the code to reduce number of query locator rows.';
            limitThresholdObj37.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj37);
            
            Limits_Threshold__c limitThresholdObj38 = new Limits_Threshold__c();
            limitThresholdObj38.Name = 'getLimitQueryRows';
            limitThresholdObj38.Display_Name__c = 'Limit Query Rows';
            limitThresholdObj38.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj38.Measure__c = 'Development/Support Team : please optimize the code to reduce records queries using selective where clauses.';
            limitThresholdObj38.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj38);
            
            Limits_Threshold__c limitThresholdObj39 = new Limits_Threshold__c();
            limitThresholdObj39.Name = 'getLimitQueueableJobs';
            limitThresholdObj39.Display_Name__c = 'Limit Queueable Jobs';
            limitThresholdObj39.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj39.Measure__c = 'Development/Support Team : please optimize the code to reduce queueable jobs.';
            limitThresholdObj39.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj39);
            
            Limits_Threshold__c limitThresholdObj40 = new Limits_Threshold__c();
            limitThresholdObj40.Name = 'getLimitRunAs';
            limitThresholdObj40.Display_Name__c = 'Limit RunAs';
            limitThresholdObj40.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj40.Measure__c = 'Development/Support Team : please optimize the code to reduce Run As.';
            limitThresholdObj40.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj40);
            
            Limits_Threshold__c limitThresholdObj41 = new Limits_Threshold__c();
            limitThresholdObj41.Name = 'getLimitSavepointRollbacks';
            limitThresholdObj41.Display_Name__c = 'Limit Savepoint Rollbacks';
            limitThresholdObj41.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj41.Measure__c = 'Development/Support Team : please optimize the code to reduce Savepoints & Rollbacks used.';
            limitThresholdObj41.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj41);
            
            Limits_Threshold__c limitThresholdObj42 = new Limits_Threshold__c();
            limitThresholdObj42.Name = 'getLimitSavepoints';
            limitThresholdObj42.Display_Name__c = 'Limit Savepoints';
            limitThresholdObj42.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj42.Measure__c = 'Development/Support Team : please optimize the code to reduce Savepoints.';
            limitThresholdObj42.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj42);
            
            Limits_Threshold__c limitThresholdObj43 = new Limits_Threshold__c();
            limitThresholdObj43.Name = 'getLimitSoslQueries';
            limitThresholdObj43.Display_Name__c = 'Limit Sosl Queries';
            limitThresholdObj43.Limit_Type__c = 'RunTime Limit';
            limitThresholdObj43.Measure__c = 'Development/Support Team : please optimize the code to reduce SOSL Queries used.';
            limitThresholdObj43.Switch__c = true;
            limitThresholdLst.add(limitThresholdObj43);
            
            /* End Insert Custom Setting Time Limit data */
            if(!limitThresholdLst.isEmpty()){
                insert limitThresholdLst;
                
            }
        }
    }
}