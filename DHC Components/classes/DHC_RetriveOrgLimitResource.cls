/*******************************************************************************************************************************   
*   Name:           DHC_DailyLimitController
*   Description:    This class is used for callout (Daily Limits)
*   Author:             Accenture
*   Date                PRJ#          Summary of Changes
*   8/30/2016           DHC           Initial
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************************/
global class DHC_RetriveOrgLimitResource{
    public List<WrapperList> Listofall {get;set;}
    public DHC_RetriveOrgLimitResource(){
        callgetLimit();
    }
    public map<String, map<Integer,Integer>> callgetLimit() {   
        map<String, map<Integer,Integer>> mapOflimitObject = new map<String, map<Integer,Integer>>();
        List<Limits_Threshold__c> limitThreshold = Limits_Threshold__c.getall().values();
        Set<String> myString = new Set<String>();
        
        for(Limits_Threshold__c limitThresholdObj : limitThreshold){
            if(!limitThresholdObj.Limit_Type__c.equals(DHC_ConstantsUtils.DHC_RUNTIMELIMIT)){
                myString.add(limitThresholdObj.Name);
            }           
        }
        Blob exampleIv = Blob.valueOf(system.label.DHC_IV);
        blob key = Blob.valueOf(system.label.DHC_Key);
        DHC_Setup__c objList = [select id , Username__c, Password__c, Name, Token__c,DHC_ClientID__c,DHC_CLIENTSECRET__c 
                                        from DHC_Setup__c 
                                        where Name= 'DHC Credtial' limit 1];
        blob encrypted = EncodingUtil.base64Decode(objList.Password__c);
        Blob decrypted =  Blob.valueOf('');
        if(!test.isrunningtest()){
            decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
        }
        string decstr = decrypted.toString();
        SecurityAccess securityAccessObj = DHC_RetriveOrgLimitResource.getSessionObject(objList.Username__c,decstr,objList.Token__c,objList.DHC_ClientID__c, objList.DHC_CLIENTSECRET__c);
        System.debug('securityAccessObj.access_token : ' + securityAccessObj.access_token);
        Listofall = new List<WrapperList>();
        String endPoint = system.label.DHC_ENDPOINTURL;
        Http h2 = new Http();
        HttpRequest req1 = new HttpRequest();
        
        req1.setHeader(DHC_ConstantsUtils.DHC_AUTHORIZATION,DHC_ConstantsUtils.DHC_BEARER + securityAccessObj.access_token);
        req1.setHeader(DHC_ConstantsUtils.DHC_CONTENTTYPE,DHC_ConstantsUtils.DHC_APPLICATIONJSON);
        req1.setHeader(DHC_ConstantsUtils.DHC_ACCEPT,DHC_ConstantsUtils.DHC_APPLICATIONJSON);
        req1.setMethod(DHC_ConstantsUtils.DHC_GET);
        req1.setEndpoint(endPoint);
        HttpResponse res1 = h2.send(req1);
        system.debug('res1 +++'+res1.getBody());
        JSONParser parser = JSON.createParser(res1.getBody());
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && myString.contains(parser.getText())){
                String string1 = parser.getText();
                parser.nextToken();
                Parser.nextToken();
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME ){
                    parser.nextValue();
                    Integer Integer1 = parser.getIntegerValue();
                    parser.nextValue();
                    Integer Integer2 = parser.getIntegerValue();
                    WrapperList wrapperobj = new WrapperList(string1, Integer1 ,Integer2 );
                    Listofall.add(wrapperobj);
                    mapOflimitObject.put(string1,new Map<Integer,Integer>{Integer1=>Integer2});
                }                                                                               
            }
        }
        return mapOflimitObject;
    }
    global class WrapperList {
        global String resourcename{get;set;}
        global Integer MaxLimit{get;set;}
        global Integer Remaining{get;set;}
            
        global WrapperList(String Name, Integer max, Integer Remain) {
            resourcename = Name;
            MaxLimit = max;
            Remaining = Remain;
        }
    }
    
    public class SecurityAccess{
        public String access_token{get; set;}
        public String instance_url{get; set;}
        public String id{get; set;}
        public String token_type{get; set;}
        public String issued_at{get; set;}
        public String signature{get; set;}
        public SecurityAccess(){
            
        }
    }
    
    public static SecurityAccess getSessionObject(string user, string pwd, string token , string clientid, string clientsecret)
    { 
        Http h = new Http();
        String password = pwd+token;
        String username = user;
        String CLIENT_ID = clientid;
        String CLIENT_SECRET = clientsecret;
        
        String body='grant_type=password&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&username=' + username + '&password=' + password;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(system.label.DHC_APPENDPOINTURL);
        req.setMethod('POST');
        req.setBody(body);
        HttpResponse res = h.send(req);
        System.debug('resData : ' + res.getBody());
        SecurityAccess securityAccessObj = (SecurityAccess)JSON.deserialize(res.getBody(), SecurityAccess.class);
        System.debug('resData : ' + securityAccessObj.access_token);
        
        return securityAccessObj;
    }
}