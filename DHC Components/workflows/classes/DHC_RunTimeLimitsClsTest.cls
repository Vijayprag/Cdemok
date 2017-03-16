@isTest(SeeAllData=false)
private class DHC_RunTimeLimitsClsTest{ 


static testMethod void dailyDisplayData(){
PageReference myVfPage = Page.DHC_RunTimeLimits;
Test.setCurrentPageReference(myVfPage);
ApexPages.currentPage().getParameters().put('type','LimitQueueableJobs');
ApexPages.currentPage().getParameters().put('Sobj','Account');
ApexPages.currentPage().getParameters().put('Comp','Accountcheck');
ApexPages.currentPage().getParameters().put('Sobj','Red');

string type= System.currentPagereference().getParameters().get('type');
string  Sobj= System.currentPagereference().getParameters().get('Sobj');
string  Comp= System.currentPagereference().getParameters().get('Comp');
string  Prior= System.currentPagereference().getParameters().get('prior');
DHC_RunTimeLimitsCls obj = new DHC_RunTimeLimitsCls();

}

static testMethod void dailyDisplayData1(){
PageReference myVfPage = Page.DHC_RunTimeLimits;
Test.setCurrentPageReference(myVfPage);
ApexPages.currentPage().getParameters().put('type','');
ApexPages.currentPage().getParameters().put('Sobj','Account');
ApexPages.currentPage().getParameters().put('Comp','');
ApexPages.currentPage().getParameters().put('Sobj','Red');

string type= System.currentPagereference().getParameters().get('type');
string  Sobj= System.currentPagereference().getParameters().get('Sobj');
string  Comp= System.currentPagereference().getParameters().get('Comp');
string  Prior= System.currentPagereference().getParameters().get('prior');
DHC_RunTimeLimitsCls obj = new DHC_RunTimeLimitsCls();

}

static testMethod void dailyDisplayData2(){
PageReference myVfPage = Page.DHC_RunTimeLimits;
Test.setCurrentPageReference(myVfPage);
ApexPages.currentPage().getParameters().put('type','');
ApexPages.currentPage().getParameters().put('Comp','Accountcheck');
ApexPages.currentPage().getParameters().put('Sobj','');
ApexPages.currentPage().getParameters().put('prior','Red');

string type= System.currentPagereference().getParameters().get('type');
string  Comp= System.currentPagereference().getParameters().get('Comp');
string  Sobj= System.currentPagereference().getParameters().get('Sobj');
string  Prior= System.currentPagereference().getParameters().get('prior');
DHC_RunTimeLimitsCls obj = new DHC_RunTimeLimitsCls();

}

}