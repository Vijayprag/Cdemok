/******************************************************************************************************************************
*   Name:           DHC_SystemLimitUsageController
*   Description:    This class is used to handle All Limit.
*   Author:             Accenture
*   Date                PRJ/#          Summary of Changes
*   8/31/2016           DHC         Initial
*   ---------------     ------------------    ----------------------------------------
*****************************************************************************************************************************/
public with sharing class DHC_SystemLimitUsageController {
    /* Start Variable Decalaration */
    public string fieldID{get;set;}
    /* END Variable Decalaration */
    
    /**
     * Name: DHC_SystemLimitUsageController
     * Description: This method is used to GET the Logo from Document( Display Branding (LOGO) )
     * @parameters: NONE
     * @return: NONE
    **/
    public DHC_SystemLimitUsageController(){
        Document docObj = [select Id,name from document where name =: DHC_ConstantsUtils.COMPANYLOGO limit 1 ];
        fieldID = docObj.Id;
    }
    
    /**
     * Name: refreshMaxLimit
     * Description: This method is used for setup Data in custom setting.
     * @parameters: NONE
     * @return: NONE
    **/
    public pageReference refreshMaxLimit(){
        DHC_SetUpCustomSettingData.setupCustomSettingRecords(); // Create Records for Limit Threshold Custom Setting
        DHC_SetUpCustomSettingData.calculateMaxLimit(); // Calcualte Max limit
        DHC_RunTimeMaxLimitBatch obj = new DHC_RunTimeMaxLimitBatch();
        database.executebatch(obj,1); // Execute Batch for Runtime Max Limit
        if(!test.isrunningtest()){
            DHC_OrganizationLimitMaxLimitBatch obj1 = new DHC_OrganizationLimitMaxLimitBatch();
            database.executebatch(obj1,1);  // Execute Batch for Organization Max Limit
        }
        return null;
    }
}