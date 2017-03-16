/******************************************************************************************************************************
*   Name:           StaticLimitController
*   Description:    This class is used for display RunTime Limit
*   Author:             Accenture
*   Date                PRJ/DHC#          Summary of Changes 
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************************/
public with sharing class DHC_StaticLimitController {
    /* Start Varibale Declaration */
    public static string dataset{get;set;}
    public static string compdataset{get;set;}
    public static string dataSetType{get;set;}
    public List<AggregateResultbyComponent> aggregateDataByComponentlst{get;set;}
    public List<AggregateResultbySobject> aggregateDataBySobjectlst{get;set;}
    public List<AggregateResultbyType> aggregateDataByTypelst{get;set;}
    public List<AggregateSoftResultbyComponent> aggregateSoftDataByComponentlst{get;set;}
    public List<AggregateSoftResultbySobject> aggregateSoftDataBySobjectlst{get;set;}
    public List<AggregateSoftResultbyType> aggregateSoftDataByTypelst{get;set;}
    public Boolean HardLimitType{get;set;}
    public Boolean softLimitType{get;set;}
    public Boolean HardLimitSobject{get;set;}
    public Boolean softLimitSobject{get;set;}
    public Boolean HardLimitComponent{get;set;}
    public Boolean softLimitComponent{get;set;}
    public static Integer TotalCountHardBYType{get;set;}
    public static Integer TotalCountHardBYSobject{get;set;}
    public static Integer TotalCountHardBYComponent{get;set;}
    public static Integer TotalCountSoftBYType{get;set;}
    public static Integer TotalCountSoftBYSobject{get;set;}
    public static Integer TotalCountSoftBYComponent{get;set;}
   /* END Varibale Declaration */
   
   
   /**
     * Name: onclickRunTime
     * Description: This method is used for set value in bollean variable.
     * @parameters: NONE
     * @return: NONE
    **/
   public void onclickRunTime(){
        HardLimitType = true;
        softLimitType = false;
        HardLimitSobject= true;
        softLimitSobject = false;
        HardLimitComponent = true;
        softLimitComponent = false;
       
   }
   /**
     * Name: StaticLimitController
     * Description: This method is used to calling other methods.
     * @parameters: NONE
     * @return: NONE
    **/
    public DHC_StaticLimitController(){
        HardLimitType = true;
        softLimitType = false;
        HardLimitSobject= true;
        softLimitSobject = false;
        HardLimitComponent = true;
        softLimitComponent = false;
        hardLimitChartByType();
        hardLimitChartBySobject();
        hardLimitChartByComponent();
    }
    
    /**
     * Name: hardLimitChartByType
     * Description: This method is used for Display Pie Chart for Hard Threshold (BY Type)
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitChartByType(){
        aggregateDataByTypelst = new List<AggregateResultbyType> ();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountHardBYType = 0;
        
        for(AggregateResult resultByTypeAR : [Select Display_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Red' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Display_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateResultbyType aggregateResultbyTypeObj = new AggregateResultbyType();
                aggregateResultbyTypeObj.DisplayName = String.ValueOf(resultByTypeAR.get('Display_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Red';
                aggregateDataByTypelst.add(aggregateResultbyTypeObj);
                TotalCountHardBYType += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Display_Name__c'))
                 ));
        }
        
        dataSetType=JSON.serialize(dataType);
    }
    
  
  /**
     * Name: softLimitChartByType
     * Description: This method is used for Display Pie Chart for Soft Threshold (BY Type)
     * @parameters: NONE
     * @return: NONE
    **/
   public void softLimitChartByType(){
        aggregateSOftDataByTypelst = new List<AggregateSoftResultbyType> ();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountSoftBYType = 0;
        
        for(AggregateResult resultByTypeAR : [Select Display_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Yellow' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Display_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateSoftResultbyType aggregateResultbyTypeObj = new AggregateSoftResultbyType();
                aggregateResultbyTypeObj.DisplayName = String.ValueOf(resultByTypeAR.get('Display_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Yellow';
                aggregateSOftDataByTypelst.add(aggregateResultbyTypeObj);
                TotalCountSoftBYType += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Display_Name__c'))
                 ));
        }
        
        dataSetType=JSON.serialize(dataType);
    }
    
    /**
     * Name: hardLimitChartBySobject
     * Description: This method is used for Display Pie Chart for Hard Threshold (BY Sobject)
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitChartBySobject(){
        aggregateDataBySobjectlst = new List<AggregateResultbySobject> ();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountHardBYSobject = 0;
        
        for(AggregateResult resultByTypeAR : [Select Sobject_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Red' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Sobject_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateResultbySobject aggregateResultbyTypeObj = new AggregateResultbySobject();
                aggregateResultbyTypeObj.SobjectName = String.ValueOf(resultByTypeAR.get('Sobject_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Red';
                aggregateDataBySobjectlst.add(aggregateResultbyTypeObj);
                TotalCountHardBYSobject += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Sobject_Name__c'))
                 ));
        }
        
        dataSet=JSON.serialize(dataType);
    }
    
    /**
     * Name: softLimitChartBySobject
     * Description: This method is used for Display Pie Chart for Soft Threshold (BY Sobject)
     * @parameters: NONE
     * @return: NONE
    **/
    public void softLimitChartBySobject(){
        aggregateSoftDataBySobjectlst = new List<AggregateSoftResultbySobject> ();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountSoftBYSobject = 0;
        
        for(AggregateResult resultByTypeAR : [Select Sobject_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Yellow' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Sobject_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateSoftResultbySobject aggregateResultbyTypeObj = new AggregateSoftResultbySobject();
                aggregateResultbyTypeObj.SobjectName = String.ValueOf(resultByTypeAR.get('Sobject_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Yellow';
                aggregateSoftDataBySobjectlst.add(aggregateResultbyTypeObj);
                TotalCountSoftBYSobject += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Sobject_Name__c'))
                 ));
        }
        
        dataSet=JSON.serialize(dataType);
        
    }
    
     /**
     * Name: hardLimitChartByComponent
     * Description: This method is used for Display Pie Chart for Hard Threshold (BY Component)
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitChartByComponent(){
        aggregateDataByComponentlst = new List<AggregateResultbyComponent>();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountHardBYComponent = 0;
        
        for(AggregateResult resultByTypeAR : [Select Component_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Red' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Component_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateResultbyComponent aggregateResultbyTypeObj = new AggregateResultbyComponent();
                aggregateResultbyTypeObj.ComponentName = String.ValueOf(resultByTypeAR.get('Component_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Red';
                aggregateDataByComponentlst.add(aggregateResultbyTypeObj);
                TotalCountHardBYComponent += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Component_Name__c'))
                 ));
        }
        
        compdataset=JSON.serialize(dataType);
    }
    
     /**
     * Name: softLimitChartByComponent
     * Description: This method is used for Display Pie Chart for Soft Threshold (BY Component)
     * @parameters: NONE
     * @return: NONE
    **/
    public void softLimitChartByComponent(){
        aggregateSoftDataByComponentlst = new List<AggregateSoftResultbyComponent>();
        List<PieChartDataType> dataType = new List<PieChartDataType>();
        TotalCountSoftBYComponent = 0;
        
        for(AggregateResult resultByTypeAR : [Select Component_Name__c, count(Id) totalCount 
            from Limits_Notification__c 
            where limit_type__c ='RunTime Limit' AND Priority__c='Yellow' AND LastModifiedDate = LAST_N_DAYS:7 
            group by Component_Name__c
            LIMIT: (Limits.getLimitQueryRows() - Limits.getQueryRows())]){
                AggregateSoftResultbyComponent aggregateResultbyTypeObj = new AggregateSoftResultbyComponent();
                aggregateResultbyTypeObj.ComponentName = String.ValueOf(resultByTypeAR.get('Component_Name__c'));
                aggregateResultbyTypeObj.noOfCount = Integer.ValueOf(resultByTypeAR.get('totalCount'));
                aggregateResultbyTypeObj.Priority = 'Yellow';
                aggregateSoftDataByComponentlst.add(aggregateResultbyTypeObj);
                TotalCountSoftBYComponent += Integer.ValueOf(resultByTypeAR.get('totalCount'));
                
                //Code to populate piechart
                dataType.add(new PieChartDataType(
                     Double.ValueOf(resultByTypeAR.get('totalCount')),
                     String.ValueOf(resultByTypeAR.get('Component_Name__c'))
                 ));
        }
        
        compdataset=JSON.serialize(dataType);
    }
    
     /**
     * Name: softLimitmethodByComponent
     * Description: This method is used for Display Onclick for soft Threshold (BY Component)
     * @parameters: NONE
     * @return: NONE
    **/
    public void softLimitmethodByComponent(){
        if(softLimitComponent == true){
            HardLimitComponent = false;
            softLimitChartByComponent();
        } else{
            HardLimitComponent = true;
            softLimitComponent = false;
        }
    }
    /**
     * Name: hardLimitmethodByComponent
     * Description: This method is used for Display Onclick for Hard Threshold (BY Component)
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitmethodByComponent(){
        if(HardLimitComponent == true){
            softLimitComponent = false;
            hardLimitChartByComponent();
        }else{
            HardLimitComponent = false;
        }
    }
    
     /**
     * Name: hardLimitmethodBySobject
     * Description: This method is used for Display Onclick for Hard Threshold (BY Sobject) 
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitmethodBySobject(){
        if(HardLimitSobject == true){
            //sObjectDataResult();
            hardLimitChartBySobject();
            softLimitSobject = false;
         }else{
            HardLimitSobject = false;
        }
    }
     /**
     * Name: softLimitmethodBySobject
     * Description: This method is used for Display Onclick for soft Threshold (BY Sobject) 
     * @parameters: NONE
     * @return: NONE
    **/
    public void softLimitmethodBySobject(){
        if(softLimitSobject == true){
            softLimitChartBySobject();
            HardLimitSobject = false;
        } else{
            HardLimitSobject = true;
            softLimitSobject = false;
        }
    }
    
    /**
     * Name: hardLimitmethodByType
     * Description: This method is used for Display Onclick for Hard Threshold (BY Type)
     * @parameters: NONE
     * @return: NONE
    **/
    public void hardLimitmethodByType(){
        if(HardLimitType == true){
            softLimitType = false;
            hardLimitChartByType();
         }else{
            HardLimitType = false;
        }
    }
    
    /**
     * Name: softLimitmethodByType
     * Description: This method is used for Display Onclick for soft Threshold (BY Type) 
     * @parameters: NONE
     * @return: NONE
    **/
    public void softLimitmethodByType(){
        if(softLimitType == true){
            system.debug('softLimitType+++');
            HardLimitType = false;
            softLimitChartByType();
        } else{
            HardLimitType = true;
            softLimitType = false;
        }
    }
    
    /* Start-- Wrapper Class */
    public class AggregateSoftResultbyType{
       public string DisplayName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;} 
       public AggregateSoftResultbyType(){
           
       }
       public AggregateSoftResultbyType(string DisplayName,string Priority){
          this.DisplayName = DisplayName;
          this.Priority = Priority;
       }
    }
    
    public class PieChartDataType {
        public String name { get; set; }
        public Decimal y{ get; set; }
        public PieChartDataType(Decimal data,String name) {
             this.name = name;
            this.y= data;
        }
    }
    
    public class PieChartDataComp {
        public String name { get; set; }
        public Decimal y{ get; set; }
        public PieChartDataComp(Decimal data,String name) {
            this.name = name;
            this.y= data;
        }
    }
    
    public class PieChartData {
        public String name { get; set; }
        public Decimal y{ get; set; }
        public PieChartData(Decimal data,String name) {
             this.name = name;
            this.y= data;
        }
    }
    
    public class AggregateSoftResultbyComponent{
       public string ComponentName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;}
       public AggregateSoftResultbyComponent(){}
       public AggregateSoftResultbyComponent(string ComponentName,string Priority){
          this.ComponentName = ComponentName;
          this.Priority = Priority;
       }
    }
    
    public class AggregateResultbyComponent{
       public string ComponentName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;}
       public AggregateResultbyComponent(){}
       public AggregateResultbyComponent(string ComponentName,string Priority){
          this.ComponentName = ComponentName;
          this.Priority = Priority;
       }
    }
    
    public class AggregateSoftResultbySobject{
       public string SobjectName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;}
       public AggregateSoftResultbySobject(){}
       public AggregateSoftResultbySobject(string SobjectName,string Priority){
          this.SobjectName = SobjectName;
          this.Priority = Priority;
       }
    }
    
    public class AggregateResultbyType{
       public string DisplayName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;}
       
       public AggregateResultbyType(){
           
       }
       
       public AggregateResultbyType(string DisplayName,string Priority){
          this.DisplayName = DisplayName;
          this.Priority = Priority;
       }
    }
    
    public class AggregateResultbySobject{
       public string SobjectName {get;set;}
       public string Priority {get;set;}
       public Integer noOfCount {get;set;}
       public AggregateResultbySobject(){}
       public AggregateResultbySobject(string SobjectName,string Priority){
          this.SobjectName = SobjectName;
          this.Priority = Priority;
       }
    }
    /* End-- Wrapper Class */
}