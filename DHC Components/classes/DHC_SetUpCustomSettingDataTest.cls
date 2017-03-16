@isTest(SeeAllData=false)
private class DHC_SetUpCustomSettingDataTest{
     static testMethod void dailyDisplayData(){
         DHC_SetUpCustomSettingData.calculateMaxLimit();
         DHC_SetUpCustomSettingData.setupCustomSettingRecords();
     }

}