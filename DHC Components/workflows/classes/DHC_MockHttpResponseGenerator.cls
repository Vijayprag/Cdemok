@isTest
global class DHC_MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"ConcurrentAsyncGetReportInstances":{"Max":200,"Remaining":200},"ConcurrentSyncReportRuns":{"Max":20,"Remaining":20},"DailyApiRequests":{"Max":32446000,"Remaining":32398292},"DailyAsyncApexExecutions":{"Max":1277800,"Remaining":1273969},"DailyBulkApiRequests":{"Max":10000,"Remaining":10000},"DailyDurableGenericStreamingApiEvents":{"Max":1000000,"Remaining":1000000},"DailyDurableStreamingApiEvents":{"Max":1000000,"Remaining":1000000},"DailyGenericStreamingApiEvents":{"Max":10000,"Remaining":10000},"DailyStreamingApiEvents":{"Max":1000000,"Remaining":983321},"DailyWorkflowEmails":{"Max":2000000,"Remaining":1999542},"DataStorageMB":{"Max":847836,"Remaining":643784},"DurableStreamingApiConcurrentClients":{"Max":20,"Remaining":20},"FileStorageMB":{"Max":14398693,"Remaining":14252523},"HourlyAsyncReportRuns":{"Max":1200,"Remaining":1200},"HourlyDashboardRefreshes":{"Max":200,"Remaining":200},"HourlyDashboardResults":{"Max":5000,"Remaining":5000},"HourlyDashboardStatuses":{"Max":999999999,"Remaining":999999999},"HourlyODataCallout":{"Max":10000,"Remaining":10000},"HourlySyncReportRuns":{"Max":500,"Remaining":500},"HourlyTimeBasedWorkflow":{"Max":1000,"Remaining":1000},"MassEmail":{"Max":10000,"Remaining":10000},"SingleEmail":{"Max":5000,"Remaining":4881},"StreamingApiConcurrentClients":{"Max":2000,"Remaining":2000}}');
        
        res.setStatusCode(200);
        return res;
    }
}