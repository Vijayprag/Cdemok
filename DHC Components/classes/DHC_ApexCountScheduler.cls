global class DHC_ApexCountScheduler implements Schedulable, Database.AllowsCallouts{
    global void execute(SchedulableContext sc){
        DHC_ApexCountBatch b = new DHC_ApexCountBatch(); 
        database.executebatch(b,1);   
                    
    }
}