/****************************************************************************************************************
*   Name:           RunTimeMaxLimitBatch
*   Description:    This class is used to Setup Max Limit Data For Runtime Limit.
*   Author:             Accenture
*   Date                PRJ/DHC#          Summary of Changes 
*   ---------------     ------------------    ----------------------------------------
***********************************************************************************************************/
global class DHC_RunTimeMaxLimitBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{ 
    global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(DHC_ConstantsUtils.DHC_LIMITQUERY);
   }

    /**
     * Name: execute
     * Description: This method is used for Calculate Max limit for RunTime Limit.
     * @parameters: NONE
     * @return: NONE
    **/
   global void execute(Database.BatchableContext info, List<Limits_Threshold__c> scope){
       List<Limits_Threshold__c> LimitThresholdLst = new List<Limits_Threshold__c>();
           Limits_Threshold__c limitsObj1 = Limits_Threshold__c.getvalues('getLimitAsyncCalls');
           limitsObj1.Async_Max_Limit__c = Limits.getLimitAsyncCalls();
           limitsObj1.Async_Hard_Threshold__c = (limitsObj1.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj1.Async_Soft_Threshold__c = (limitsObj1.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj1);
           
           Limits_Threshold__c limitsObj2 = Limits_Threshold__c.getvalues('getLimitCallouts');
           limitsObj2.Async_Max_Limit__c = Limits.getLimitCallouts();
           limitsObj2.Async_Hard_Threshold__c = (limitsObj2.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj2.Async_Soft_Threshold__c = (limitsObj2.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj2);
           
           Limits_Threshold__c limitsObj3 = Limits_Threshold__c.getvalues('getLimitCpuTime');
           limitsObj3.Async_Max_Limit__c = Limits.getLimitCpuTime();
           limitsObj3.Async_Hard_Threshold__c = (limitsObj3.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj3.Async_Soft_Threshold__c = (limitsObj3.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj3);
           
           Limits_Threshold__c limitsObj4 = Limits_Threshold__c.getvalues('getLimitDmlRows');
           limitsObj4.Async_Max_Limit__c = Limits.getLimitDmlRows();
           limitsObj4.Async_Hard_Threshold__c = (limitsObj4.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj4.Async_Soft_Threshold__c = (limitsObj4.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj4);
            
           Limits_Threshold__c limitsObj5 = Limits_Threshold__c.getvalues('getLimitDMLStatements');
           limitsObj5.Async_Max_Limit__c = Limits.getLimitDMLStatements();
           limitsObj5.Async_Hard_Threshold__c = (limitsObj5.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj5.Async_Soft_Threshold__c = (limitsObj5.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj5);
            
           Limits_Threshold__c limitsObj6 = Limits_Threshold__c.getvalues('getLimitEmailInvocations');
           limitsObj6.Async_Max_Limit__c = Limits.getLimitEmailInvocations();
           limitsObj6.Async_Hard_Threshold__c = (limitsObj6.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj6.Async_Soft_Threshold__c = (limitsObj6.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj6);
           
           Limits_Threshold__c limitsObj7 = Limits_Threshold__c.getvalues('getLimitFindSimilarCalls');
           limitsObj7.Async_Max_Limit__c = Limits.getLimitFindSimilarCalls();
           limitsObj7.Async_Hard_Threshold__c = (limitsObj7.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj7.Async_Soft_Threshold__c = (limitsObj7.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj7);
            
           Limits_Threshold__c limitsObj8 = Limits_Threshold__c.getvalues('getLimitFutureCalls');
           limitsObj8.Async_Max_Limit__c = Limits.getLimitFutureCalls();
           limitsObj8.Async_Hard_Threshold__c = (limitsObj8.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj8.Async_Soft_Threshold__c = (limitsObj8.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj8);
           
           Limits_Threshold__c limitsObj9 = Limits_Threshold__c.getvalues('getLimitHeapSize');
           limitsObj9.Async_Max_Limit__c = Limits.getLimitHeapSize();
           limitsObj9.Async_Hard_Threshold__c = (limitsObj9.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj9.Async_Soft_Threshold__c = (limitsObj9.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj9);
           
           Limits_Threshold__c limitsObj0 = Limits_Threshold__c.getvalues('getLimitMobilePushApexCalls');
           limitsObj0.Async_Max_Limit__c = Limits.getLimitMobilePushApexCalls();
           limitsObj0.Async_Hard_Threshold__c = (limitsObj0.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj0.Async_Soft_Threshold__c = (limitsObj0.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj0);
            
           Limits_Threshold__c limitsObj11 = Limits_Threshold__c.getvalues('getLimitQueries');
           limitsObj11.Async_Max_Limit__c = Limits.getLimitQueries();
           limitsObj11.Async_Hard_Threshold__c = (limitsObj11.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj11.Async_Soft_Threshold__c = (limitsObj11.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj11);
            
           Limits_Threshold__c limitsObj12 = Limits_Threshold__c.getvalues('getLimitQueryLocatorRows');
           limitsObj12.Async_Max_Limit__c = Limits.getLimitQueryLocatorRows();
           limitsObj12.Async_Hard_Threshold__c = (limitsObj12.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj12.Async_Soft_Threshold__c = (limitsObj12.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj12);
           
           Limits_Threshold__c limitsObj13 = Limits_Threshold__c.getvalues('getLimitQueryRows');
           limitsObj13.Async_Max_Limit__c = Limits.getLimitQueryRows();
           limitsObj13.Async_Hard_Threshold__c = (limitsObj13.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj13.Async_Soft_Threshold__c = (limitsObj13.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj13);
           
           Limits_Threshold__c limitsObj14 = Limits_Threshold__c.getvalues('getLimitQueueableJobs');
           limitsObj14.Async_Max_Limit__c = Limits.getLimitQueueableJobs();
           limitsObj14.Async_Hard_Threshold__c = (limitsObj14.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj14.Async_Soft_Threshold__c = (limitsObj14.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj14);
            
           Limits_Threshold__c limitsObj15 = Limits_Threshold__c.getvalues('getLimitRunAs');
           limitsObj15.Async_Max_Limit__c = Limits.getLimitRunAs();
           limitsObj15.Async_Hard_Threshold__c = (limitsObj15.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj15.Async_Soft_Threshold__c = (limitsObj15.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj15);
            
           Limits_Threshold__c limitsObj16 = Limits_Threshold__c.getvalues('getLimitSavepointRollbacks');
           limitsObj16.Async_Max_Limit__c = Limits.getLimitSavepointRollbacks();
           limitsObj16.Async_Hard_Threshold__c = (limitsObj16.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj16.Async_Soft_Threshold__c = (limitsObj16.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj16);
            
           Limits_Threshold__c limitsObj17 = Limits_Threshold__c.getvalues('getLimitSavepoints');
           limitsObj17.Async_Max_Limit__c = Limits.getLimitSavepoints();
           limitsObj17.Async_Hard_Threshold__c = (limitsObj17.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj17.Async_Soft_Threshold__c = (limitsObj17.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj17);
           
           Limits_Threshold__c limitsObj18 = Limits_Threshold__c.getvalues('getLimitSoslQueries');
           limitsObj18.Async_Max_Limit__c = Limits.getLimitSoslQueries();
           limitsObj18.Async_Hard_Threshold__c = (limitsObj18.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj18.Async_Soft_Threshold__c = (limitsObj18.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj18);
           
           Limits_Threshold__c limitsObj19 = Limits_Threshold__c.getvalues('getLimitAggregateQueries');
           limitsObj19.Async_Max_Limit__c = Limits.getLimitAggregateQueries();
           limitsObj19.Async_Hard_Threshold__c = (limitsObj19.Async_Max_Limit__c * (0.85)).round() ;
           limitsObj19.Async_Soft_Threshold__c = (limitsObj19.Async_Max_Limit__c * (0.70)).round() ;
           LimitThresholdLst.add(limitsObj19);
           
            if(!LimitThresholdLst.isEmpty()){
                Update(LimitThresholdLst);
            }
   }     
   global void finish(Database.BatchableContext info){     
   } 
}