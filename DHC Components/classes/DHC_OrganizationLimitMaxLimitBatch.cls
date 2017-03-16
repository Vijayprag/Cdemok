/****************************************************************************************************************
*   Name:           DHC_OrganizationLimitMaxLimitBatch
*   Description:    This class is used to Setup Max Limit Data For Daily Limit.
*   Author:             Accenture
*   Date                PRJ#          Summary of Changes 
*   9/21/2016           DHC           Initial
*   ---------------     ------------------    ----------------------------------------
***********************************************************************************************************/
global class DHC_OrganizationLimitMaxLimitBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{ 
     global Database.QueryLocator start(Database.BatchableContext BC){
          return Database.getQueryLocator(DHC_ConstantsUtils.DHC_LIMITQUERY);
       }
    /**
     * Name: execute
     * Description: This method is used for Calculate Max limit for Daily Limit.
     * @parameters: NONE
     * @return: NONE
    **/
    global void execute(Database.BatchableContext info, List<Limits_Threshold__c> scope){
        DHC_RetriveOrgLimitResource getLimitsObj = new DHC_RetriveOrgLimitResource();
        map<String, map<Integer,Integer>> listOfLimits = getLimitsObj.callgetLimit();
        Map<String,Limits_Threshold__c> mapOfSettings = Limits_Threshold__c.getAll();
        List<Limits_Threshold__c > listOfThreshold = new List<Limits_Threshold__c >();
        for(String limitObj : listOfLimits.keyset()){
            if(mapOfSettings.containsKey(limitObj)){                
                Limits_Threshold__c limitThreshold = new Limits_Threshold__c();
                limitThreshold.Max_Limit__c = (new list<Integer>(listOfLimits.get(limitObj).keySet()))[0];
                limitThreshold.Hard_Threshold__c = (limitThreshold.Max_Limit__c * (0.85)).round() ;
                limitThreshold.Soft_Threshold__c = (limitThreshold.Max_Limit__c * (0.70)).round() ;
                limitThreshold.id = mapOfSettings.get(limitObj).id;
                listOfThreshold.add(limitThreshold);
            }
        }
        if(!listOfThreshold.isEmpty()){
            Database.SaveResult[] saveResultList = Database.update(listOfThreshold,false);
            for (Database.SaveResult res : saveResultList) {
                if (!res.isSuccess()){
                    //Error handling if required.
                    break;
                }
            }        
        } 
    }
    
    global void finish(Database.BatchableContext info){     
    
    } 
}