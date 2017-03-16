global class HourlyDHCCalculateBatch implements Database.Batchable<sObject>,Database.AllowsCallouts 
{
    // Start Method
     global Database.QueryLocator start(Database.BatchableContext BC){
        string query = DHC_ConstantsUtils.DHC_LIMITQUERY ;
        return Database.getQueryLocator(query);
     }
   
     // Execute Logic
     global void execute(Database.BatchableContext BC, List<Limits_Threshold__c> scope){
        DHC_RetriveOrgLimitResource getLimitsObj = new DHC_RetriveOrgLimitResource();
        map<String, map<Integer,Integer>> listOfLimits = getLimitsObj.callgetLimit();
        Map<String,Limits_Threshold__c> mapOfSettings = Limits_Threshold__c.getAll();
        List<Limits_Notification__c > listOfNotification = new List<Limits_Notification__c >();
        List<Limits_Threshold__c> limitThreshold = Limits_Threshold__c.getall().values();
        Set<String> dailylimitStr = new Set<String>();
        Set<String> concurrentlimitStr = new Set<String>();
        Set<String> hourlylimitStr = new Set<String>();
        Set<String> storagelimitStr = new Set<String>();
        for(Limits_Threshold__c limitThresholdObj : limitThreshold){
            if(limitThresholdObj.Limit_Type__c.equals(DHC_ConstantsUtils.CONCURRENTLIMIT)){
                concurrentlimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals(DHC_ConstantsUtils.DAILYLIMIT)){
                dailylimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals(DHC_ConstantsUtils.HOURLYLIMIT)){
                hourlylimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals(DHC_ConstantsUtils.SYSTEMLIMIT)){
                storagelimitStr.add(limitThresholdObj.Name);
            }
        }
       for(String limitObj : listOfLimits.keyset()){
            system.debug('limitObj '+ limitObj );
            if(mapOfSettings.containsKey(limitObj)){                
                List<Integer> li = new List<Integer>();
                li.addAll(listOfLimits.get(limitObj).keyset());
                Integer currentlimit = li[0] - listOfLimits.get(limitObj).values()[0];
                Integer hardThreshold = Integer.ValueOf(mapOfSettings.get(limitObj).Hard_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(limitObj).Hard_Threshold__c) : 0;
                String unit = String.ValueOf(mapOfSettings.get(limitObj).unit__c)!=null ? String.ValueOf(mapOfSettings.get(limitObj).unit__c) : '';
                String Measure = String.ValueOf(mapOfSettings.get(limitObj).Measure__c)!=null ? String.ValueOf(mapOfSettings.get(limitObj).Measure__c) : '';
                Integer softThreshold = Integer.ValueOf(mapOfSettings.get(limitObj).Soft_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(limitObj).Soft_Threshold__c) : 0;
                Boolean displayAll =mapOfSettings.get(limitObj).Display_All__c == true ? true : false;
                Boolean switchset =mapOfSettings.get(limitObj).switch__c == true ? true : false;
                Boolean HardThresholdNotification =mapOfSettings.get(limitObj).Send_Hard_Threshold_Notification__c == true ? true : false;
                Boolean SoftThresholdNotification =mapOfSettings.get(limitObj).Send_Soft_Threshold_Notification__c == true ? true : false;
                if(switchset && (currentlimit >= softThreshold || displayAll)){
                   Limits_Notification__c notification = new Limits_Notification__c();
                    if(dailylimitStr.contains(limitObj)){
                        notification.Limit_Type__c = DHC_ConstantsUtils.DAILYLIMIT;
                    }else if(concurrentlimitStr.contains(limitObj)){
                        notification.Limit_Type__c = DHC_ConstantsUtils.CONCURRENTLIMIT;
                    }else if(storagelimitStr.contains(limitObj)){
                        notification.Limit_Type__c = DHC_ConstantsUtils.SYSTEMLIMIT;
                    }else if(hourlylimitStr.contains(limitObj)){
                        notification.Limit_Type__c = DHC_ConstantsUtils.HOURLYLIMIT;
                    }
                    notification.Display_Name__c = mapOfSettings.get(limitObj).Display_Name__c;
                    notification.Max_Limit__c = mapOfSettings.get(limitObj).Max_Limit__c;
                    notification.Hard_Threshold__c = mapOfSettings.get(limitObj).Hard_Threshold__c;
                    notification.Soft_Threshold__c = mapOfSettings.get(limitObj).Soft_Threshold__c;
                    notification.Impact_Analysis__c = mapOfSettings.get(limitObj).Impact_Analysis__c;
                    notification.Limit_Utilization__c = currentlimit;
                    notification.Measure__c = Measure;
                    notification.unit__c= unit;
                    notification.Send_Hard_Threshold_Notification__c = HardThresholdNotification;
                    notification.Send_Soft_Threshold_Notification__c = SoftThresholdNotification;
                    if(currentlimit >= hardThreshold){
                    notification.Priority__c = DHC_ConstantsUtils.RED;
                    } else if (currentlimit >= softThreshold){
                        notification.Priority__c = DHC_ConstantsUtils.YELLOW;
                    } else {
                        notification.Priority__c =DHC_ConstantsUtils.GREEN;
                    }
                    listOfNotification.add(notification);
                }
                 
            }
        }
        if(!listOfNotification.isEmpty()){
            Database.SaveResult[] saveResultList = Database.insert(listOfNotification,false);
            for (Database.SaveResult res : saveResultList) {
                if (!res.isSuccess()){
                    //Error handling if required
                    break;
                }   
            }
        }        
   
     }
   
     global void finish(Database.BatchableContext BC){
   
     }
   
 }