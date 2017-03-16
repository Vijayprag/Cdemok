/*******************************************************************************************************************************   
*   Name:           DHC_DailyLimitController
*   Description:    This class is used to handle Organization Limit.
*   Author:             Accenture
*   Date                PRJ#          Summary of Changes
*   8/30/2016           DHC           Initial
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************************/
public with sharing class DHC_DailyLimitController {
    /* Start- Variable Declaration */
    public List<WrapperList> ListofDailyLimits {get;set;}
    public List<WrapperList> ListofHourlyLimits {get;set;}
    public List<WrapperList> ListofConcurrentLimits {get;set;}
    public List<WrapperList> ListofStorageLimits {get;set;}
    public List<Limits_Notification__c> dailylimitNotification {get;set;}
    public List<Limits_Notification__c> currentApexCountLst {get;set;}
    public List<Limits_Notification__c> listOfNotification {get;set;}
    public List<Limits_Notification__c> hourlylimitNotification {get;set;}
    public List<Limits_Notification__c> concurrentlimitNotification {get;set;}
    public List<Limits_Notification__c> storagelimitNotification {get;set;}
    public Map<String,List<Limits_Notification__c>> mapofnotification;
    public Map<String,List<Limits_Notification__c>> mapoflimitType;
    public Map<String,List<Limits_Notification__c>> mapofhourlylimitType;
    public Boolean runtimeCheck{get;set;}
    public Boolean offlineCheck{get;set;}
    /* END- Variable Declaration */
    
    /**
     * Name: currentLimitData
     * Description: This method is used to call all the methods.
     * @parameters: NONE
     * @return: NONE
    **/
    public void currentLimitData(){
        mapofnotification = new Map<String,List<Limits_Notification__c>>();
        mapofhourlylimitType = new Map<String,List<Limits_Notification__c>>();
        mapoflimitType = new Map<String,List<Limits_Notification__c>>();
        dailylimitNotification = new List<Limits_Notification__c>();
        hourlylimitNotification = new List<Limits_Notification__c>();
        concurrentlimitNotification = new List<Limits_Notification__c>();
        storagelimitNotification = new List<Limits_Notification__c>();
        List<Limits_Notification__c> notLst =[SELECT Display_Name__c,Priority__c,Unit__c,measure__c,
                                        Max_Limit__c,Limit_Utilization__c,Soft_Threshold__c,Limit_Type__c,Latest_Breach__c,Percentage_Used__c,
                                        Hard_Threshold__c 
                                    FROM Limits_Notification__c where  Limit_Type__c != 'Runtime Limit' AND Limit_Type__c != 'ApexCodeCount' ORDER BY  createdDate DESC LIMIT 23];
            notLst.sort();
        for(Limits_Notification__c notificationObj :notLst) {
            
            if(mapoflimitType.containsKey(notificationObj.Limit_Type__c)) {
                List<Limits_Notification__c> notificationLst = mapoflimitType.get(notificationObj.Limit_Type__c);
                notificationLst.add(notificationObj);
                mapoflimitType.put(notificationObj.Limit_Type__c, notificationLst);
            } else {
                mapoflimitType.put(notificationObj.Limit_Type__c, new List<Limits_Notification__c> { notificationObj });
            }
        }
        
        dailylimitNotification = mapoflimitType.get(DHC_ConstantsUtils.DAILYLIMIT);
        hourlylimitNotification = mapoflimitType.get(DHC_ConstantsUtils.HOURLYLIMIT);
        concurrentlimitNotification = mapoflimitType.get(DHC_ConstantsUtils.CONCURRENTLIMIT);
        storagelimitNotification= mapoflimitType.get(DHC_ConstantsUtils.SYSTEMLIMIT);
     }
     
     /**
     * Name: DailyLimitController
     * Description: This method is used to call all the methods.
     * @parameters: NONE
     * @return: NONE
    **/
    public DHC_DailyLimitController(){
        runtimeCheck = true ;
        offlineCheck = false;
        callgetLimit();
        currentApexCharaterCount();
    }
    
     /**
     * Name: callgetLimitFromPage
     * Description: This method is used to call all the methods.
     * @parameters: NONE
     * @return: NONE
    **/
     public void currentApexCharaterCount(){
        currentApexCountLst = [SELECT Display_Name__c,Priority__c,Unit__c,measure__c,
                                        Max_Limit__c,Limit_Utilization__c,Soft_Threshold__c,Limit_Type__c,Latest_Breach__c,Percentage_Used__c,
                                        Hard_Threshold__c 
                                    FROM Limits_Notification__c where  Limit_Type__c = 'ApexCodeCount' ORDER BY  createdDate DESC LIMIT 1];
    }
    
    /**
     * Name: callgetLimitFromPage
     * Description: This method is used to call all the methods.
     * @parameters: NONE
     * @return: NONE
    **/
    public void callgetLimitFromPage(){
        runtimeCheck = false;
        offlineCheck = true;
        currentLimitData();
        currentApexCharaterCount();
    }
    
    /**
     * Name: callgetLimit
     * Description: This method is used for calling API Request and get all the details related to Daily Limits.
     * @parameters: NONE
     * @return: map<Integer,Integer>>
    **/
    public map<String, map<Integer,Integer>> callgetLimit () {
        Map<String,Limits_Threshold__c> mapOfSettings = Limits_Threshold__c.getAll(); 
        map<String, map<Integer,Integer>> mapOflimitObject = new map<String, map<Integer,Integer>>();
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
        ListofDailyLimits = new List<WrapperList>();
        ListofHourlyLimits = new List<WrapperList>();
        ListofConcurrentLimits = new List<WrapperList>();
        ListofStorageLimits = new List<WrapperList>();
        String endPoint = system.label.DHC_ENDPOINTURL;
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setHeader(DHC_ConstantsUtils.DHC_AUTHORIZATION,DHC_ConstantsUtils.DHC_BEARER + UserInfo.getSessionId());
        req1.setHeader(DHC_ConstantsUtils.DHC_CONTENTTYPE,DHC_ConstantsUtils.DHC_APPLICATIONJSON);
        req1.setHeader(DHC_ConstantsUtils.DHC_ACCEPT,DHC_ConstantsUtils.DHC_APPLICATIONJSON);
        req1.setMethod(DHC_ConstantsUtils.DHC_GET);
        req1.setEndpoint(endPoint);
        HttpResponse res1 = h2.send(req1);
        JSONParser parser = JSON.createParser(res1.getBody());
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && dailylimitStr.contains(parser.getText())){
                String string1 = String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c) : '';
                Integer hardThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c) : 0;
                Integer softThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c) : 0;
                String measure = String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c) : '';
                parser.nextToken();
                Parser.nextToken();
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME ){
                    parser.nextValue();
                    Integer Integer1 = parser.getIntegerValue();
                    parser.nextValue();
                    Integer Integer3 = parser.getIntegerValue();
                    Integer Integer2 =Integer1 - Integer3;
                    decimal temp1 = decimal.valueOf(Integer2);
                    Decimal percentCount = (temp1*100/Integer1).setScale(2);
                    String prior;
                    if(Integer2 >= hardThreshold){
                        prior = DHC_ConstantsUtils.RED;
                    } else if (Integer2 >= softThreshold){
                        prior =DHC_ConstantsUtils.YELLOW;
                    } else {
                       prior =DHC_ConstantsUtils.GREEN;
                   }
                     
                    WrapperList wrapperobj = new WrapperList(string1, Integer1 ,Integer2,prior,measure,percentCount );
                    ListofDailyLimits.add(wrapperobj);
                    mapOflimitObject.put(string1,new Map<Integer,Integer>{Integer1=>Integer2});
                }                                                                               
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && hourlylimitStr.contains(parser.getText())){
                String string1 = String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c) : '';
                Integer hardThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c) : 0;
                Integer softThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c) : 0;
                String measure = String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c) : '';
                parser.nextToken();
                Parser.nextToken();
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME ){
                    parser.nextValue();
                    Integer Integer1 = parser.getIntegerValue();
                    parser.nextValue();
                    Integer Integer3 = parser.getIntegerValue();
                    Integer Integer2 =Integer1 - Integer3;
                    decimal temp1 = decimal.valueOf(Integer2);
                    Decimal percentCount = (temp1*100/Integer1).setScale(2);
                    String prior;
                    if(Integer2 >= hardThreshold){
                        prior =DHC_ConstantsUtils.RED;
                    } else if (Integer2 >= softThreshold){
                        prior =DHC_ConstantsUtils.YELLOW;
                    } else {
                       prior =DHC_ConstantsUtils.GREEN;
                    }
                     
                    WrapperList wrapperobj = new WrapperList(string1, Integer1 ,Integer2,prior,measure,percentCount );
                    ListofHourlyLimits.add(wrapperobj);
                    mapOflimitObject.put(string1,new Map<Integer,Integer>{Integer1=>Integer2});
                }                                                                               
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && concurrentlimitStr.contains(parser.getText())){
                String string1 =String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c) : '';
                Integer hardThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c) : 0;
                Integer softThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c) : 0;
                String measure = String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c) : '';
                parser.nextToken();
                Parser.nextToken();
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME ){
                    parser.nextValue();
                    Integer Integer1 = parser.getIntegerValue();
                    parser.nextValue();
                    Integer Integer3 = parser.getIntegerValue();
                    Integer Integer2 =Integer1 - Integer3;
                    decimal temp1 = decimal.valueOf(Integer2);
                    Decimal percentCount = (temp1*100/Integer1).setScale(2);
                    String prior;
                    if(Integer2 >= hardThreshold){
                        prior =DHC_ConstantsUtils.RED;
                    } else if (Integer2 >= softThreshold){
                        prior =DHC_ConstantsUtils.YELLOW;
                    } else {
                       prior =DHC_ConstantsUtils.GREEN;
                    }
                     
                    WrapperList wrapperobj = new WrapperList(string1, Integer1 ,Integer2,prior,measure,percentCount );
                    ListofConcurrentLimits.add(wrapperobj);
                    mapOflimitObject.put(string1,new Map<Integer,Integer>{Integer1=>Integer2});
                }                                                                               
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && storagelimitStr.contains(parser.getText())){
                 String prior;
                String string1 = String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Display_Name__c) : '';
                Integer hardThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Hard_Threshold__c) : 0;
                Integer softThreshold = Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c)!=null ? Integer.ValueOf(mapOfSettings.get(parser.getText()).Soft_Threshold__c) : 0;
                String measure = String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c)!=null ? String.ValueOf(mapOfSettings.get(parser.getText()).Measure__c) : '';
                parser.nextToken();
                Parser.nextToken();
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME ){
                    parser.nextValue();
                    Integer Integer1 = parser.getIntegerValue();
                    parser.nextValue();
                    Integer Integer3 = parser.getIntegerValue();
                    Integer Integer2 =Integer1 - Integer3;
                    decimal temp1 = decimal.valueOf(Integer2);
                    Decimal percentCount = (temp1*100/Integer1).setScale(2);
                    if(Integer2 >= hardThreshold){
                        prior =DHC_ConstantsUtils.RED;
                    } else if (Integer2 >= softThreshold){
                        prior =DHC_ConstantsUtils.YELLOW;
                    } else {
                       prior =DHC_ConstantsUtils.GREEN;
                    }
                     
                    WrapperList wrapperobj = new WrapperList(string1, Integer1 ,Integer2,prior,measure,percentCount);
                    ListofStorageLimits.add(wrapperobj);
                    mapOflimitObject.put(string1,new Map<Integer,Integer>{Integer1=>Integer2});
                }                                                                               
            }
        }
        return mapOflimitObject;
    }
    
    /**
     * Name: WrapperList
     * Description: This Class is a wrapper class for holding current instance.
     * @parameters: NONE
     * @return: NONE
    **/
    public class WrapperList {
        public String resourcename{get;set;}
        public Integer MaxLimit{get;set;}
        public Integer Remaining{get;set;}
        public String priorstr{get;set;}
        public String measureStr{get;set;}
        public Decimal PercentageUsed{get;set;}
        public WrapperList(String Name, Integer max, Integer Remain,String prior,String measure, Decimal PercentageUsed) {
            resourcename = Name;
            MaxLimit = max;
            Remaining = Remain;
            priorstr= prior;
            measureStr = measure;
            this.PercentageUsed = PercentageUsed;
        }
    }
}