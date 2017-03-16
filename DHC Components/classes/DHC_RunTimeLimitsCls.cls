public class DHC_RunTimeLimitsCls {
Public String type;
Public String Sobj;
Public String Comp;
Public String Prior;
Public string status{get;set;}
public List<Limits_Notification__c> notificationLst{get;set;}
    public DHC_RunTimeLimitsCls(){
      type= System.currentPagereference().getParameters().get(DHC_ConstantsUtils.DHC_TYPESTR);
      Sobj= System.currentPagereference().getParameters().get(DHC_ConstantsUtils.DHC_SOBJECTSTR);
      Comp= System.currentPagereference().getParameters().get(DHC_ConstantsUtils.DHC_COMPSTR);
      Prior= System.currentPagereference().getParameters().get(DHC_ConstantsUtils.PRIORSTR);
      if(!String.isEmpty(type)){
        status = '/'+system.label.DHC_ReportID+'?pv1='+Prior+'&pv2='+type;
      } else if (!String.isEmpty(Sobj)){
        status = '/'+system.label.DHC_ReportID+'?pv1='+Prior+'&pv3='+Sobj;
      } else  if(!String.isEmpty(Comp)){
        status = '/'+system.label.DHC_ReportID+'?pv1='+Prior+'&pv4='+Comp;
      }
      if(!String.isEmpty(type)){
        notificationLst=[select Component_Name__c,Display_Name__c,Priority__c,Latest_Breach__c ,Hard_Threshold__c,Max_Limit__c ,Limit_Type__c,LImit_Utilization__c,Sobject_Name__c,Measure__c from Limits_Notification__c where Display_Name__c =: type AND Priority__c =:Prior AND LastModifiedDate = LAST_N_DAYS:30  ORDER BY LastModifiedDate DESC  Limit 100];
      }
      if(!String.isEmpty(Sobj)){
        notificationLst=[select Component_Name__c,Display_Name__c,Priority__c,Latest_Breach__c ,Hard_Threshold__c,Max_Limit__c ,Limit_Type__c,LImit_Utilization__c,Sobject_Name__c,Measure__c from Limits_Notification__c where Sobject_Name__c =: Sobj AND Priority__c =:Prior AND LastModifiedDate = LAST_N_DAYS:30 ORDER BY LastModifiedDate DESC  Limit 100 ];
      }
      if(!String.isEmpty(Comp)){
        notificationLst=[select Component_Name__c,Display_Name__c,Priority__c,Latest_Breach__c ,Hard_Threshold__c,Max_Limit__c ,Limit_Type__c,LImit_Utilization__c,Sobject_Name__c,Measure__c from Limits_Notification__c where Component_Name__c =: Comp AND Priority__c =:Prior AND LastModifiedDate = LAST_N_DAYS:30  ORDER BY LastModifiedDate DESC  Limit 100 ];
      }

    }
}