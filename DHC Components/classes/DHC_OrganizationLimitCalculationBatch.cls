global class DHC_OrganizationLimitCalculationBatch implements Schedulable, Database.AllowsCallouts{
    global void execute(SchedulableContext sc){
        
        /*DHC_RetriveOrgLimitResource getLimitsObj = new DHC_RetriveOrgLimitResource();
        map<String, map<Integer,Integer>> listOfLimits = getLimitsObj.callgetLimit();
        Map<String,Limits_Threshold__c> mapOfSettings = Limits_Threshold__c.getAll();
        List<Limits_Notification__c > listOfNotification = new List<Limits_Notification__c >();
        List<Limits_Threshold__c> limitThreshold = Limits_Threshold__c.getall().values();
        Set<String> dailylimitStr = new Set<String>();
        Set<String> concurrentlimitStr = new Set<String>();
        Set<String> hourlylimitStr = new Set<String>();
        Set<String> storagelimitStr = new Set<String>();
        for(Limits_Threshold__c limitThresholdObj : limitThreshold){
            if(limitThresholdObj.Limit_Type__c.equals('Concurrent Limit')){
                concurrentlimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals('Daily Limit')){
                dailylimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals('Hourly Limit')){
                hourlylimitStr.add(limitThresholdObj.Name);
            }
            if(limitThresholdObj.Limit_Type__c.equals('System Storage Limit')){
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
                        notification.Limit_Type__c = 'Daily Limit';
                    }else if(concurrentlimitStr.contains(limitObj)){
                        notification.Limit_Type__c = 'Concurrent Limit';
                    }else if(storagelimitStr.contains(limitObj)){
                        notification.Limit_Type__c = 'System Storage Limit';
                    }else if(hourlylimitStr.contains(limitObj)){
                        notification.Limit_Type__c = 'Hourly Limit';
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
                    notification.Priority__c ='Red';
                    } else if (currentlimit >= softThreshold){
                        notification.Priority__c ='Yellow';
                    } else {
                        notification.Priority__c ='Green';
                    }
                    listOfNotification.add(notification);
                }
                 
            }
        }
        if(!listOfNotification.isEmpty()){
            Database.SaveResult[] saveResultList = Database.insert(listOfNotification,false);
            for (Database.SaveResult res : saveResultList) {
                if (!res.isSuccess()){
                    CreateApexErrorLog.insertHandledExceptions(null, saveResultList, null, null, DHC_ConstantsUtils.CLASSSTR, DHC_ConstantsUtils.LIMITTHRESHOLDOBJ, DHC_ConstantsUtils.DHC_SETUPCUSTOMSETTINGDATA );
                    break;
                }   
            }
        }*/
        HourlyDHCCalculateBatch b = new HourlyDHCCalculateBatch(); 
        database.executebatch(b,1);   
                    
    }
}