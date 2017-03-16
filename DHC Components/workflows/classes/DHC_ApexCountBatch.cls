global class DHC_ApexCountBatch implements Database.Batchable<sObject>,Database.AllowsCallouts 
{
    // Start Method
     global Database.QueryLocator start(Database.BatchableContext BC){
        string query = DHC_ConstantsUtils.DHC_LIMITQUERY ;
        return Database.getQueryLocator(query);
     }
   
     // Execute Logic
     global void execute(Database.BatchableContext BC, List<Limits_Threshold__c> scope){
        List<Limits_Notification__c > listOfNotification = new List<Limits_Notification__c >();
       Limits_Threshold__c limitThreshold = Limits_Threshold__c.getValues(DHC_ConstantsUtils.DHC_APEXUSED);
        set<id> objID = new set<id>();
        for(apexclass obj :[SELECT name,id,body from apexclass]){
            if(obj.body.contains(DHC_ConstantsUtils.DHC_ISTEST)){
                apexclass objnew = new apexclass();
                objnew.id = obj.id;
                objID.add(objnew.id);
            }
        }
        AggregateResult arC =[SELECT Sum(LengthWithoutComments)lcc FROM ApexClass WHERE NamespacePrefix =Null AND ID NOT IN :objID];
        Decimal intCdata =(Decimal)arC.get('lcc');
        AggregateResult arT =[SELECT Sum(LengthWithoutComments)lct FROM ApexTrigger WHERE NamespacePrefix =Null];
        Decimal intTdata =(Decimal)arT.get('lct');
        Integer totalcount = Integer.valueOf(intCdata + intTdata);
        system.debug('totalcount +++'+totalcount);
        Limits_Notification__c notification = new Limits_Notification__c();
        notification.Limit_Type__c = limitThreshold.Limit_Type__c;
        notification.Display_Name__c = limitThreshold.Display_Name__c;
        notification.Max_Limit__c = limitThreshold.Max_Limit__c ;
        notification.Hard_Threshold__c = limitThreshold.Hard_Threshold__c;
        notification.Soft_Threshold__c = limitThreshold.Soft_Threshold__c;
        notification.Impact_Analysis__c = limitThreshold.Impact_Analysis__c;
        notification.Limit_Utilization__c = totalcount;
        notification.Measure__c = limitThreshold.Measure__c;
        notification.Send_Hard_Threshold_Notification__c = limitThreshold.Send_Hard_Threshold_Notification__c;
        notification.Send_Soft_Threshold_Notification__c = limitThreshold.Send_Soft_Threshold_Notification__c;
        if(totalcount >= limitThreshold.Hard_Threshold__c){
        notification.Priority__c = DHC_ConstantsUtils.RED;
        } else if (totalcount  >= limitThreshold.Soft_Threshold__c){
            notification.Priority__c = DHC_ConstantsUtils.YELLOW;
        } else {
            notification.Priority__c = DHC_ConstantsUtils.GREEN;
        }
        listOfNotification.add(notification);
        
        if(!listOfNotification.isEmpty()){
            insert listOfNotification;
        }
   }
      
   global void finish(Database.BatchableContext BC){
   
   }
   
 }