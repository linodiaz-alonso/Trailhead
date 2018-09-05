public with sharing class BusScheduleCache {
    private Cache.OrgPartition part;
    
    public BusScheduleCache(){
        part = Cache.Org.getPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule){
        part.put(busLine, schedule);
    }
    
    public Time[] getSchedule(String busLine){
        part = Cache.Org.getPartition('local.BusSchedule');
        Time[] schedule = new Time[]{Time.newInstance(16, 0, 0, 0), Time.newInstance(20, 0, 0, 0)};
        part.put(busLine, schedule);
        
        
        Time[] cachedTime = new Time[]{};
        cachedTime = (Time[]) part.get(busLine);
        System.debug('***part***' + part.contains(busLine));
        System.debug('***bus Line ***' + busLine);
        System.debug('***cachedTime ***' + cachedTime);
        // Check the cache value that the get() call returned.
        if (cachedTime != null) {
             return cachedTime;
        } else {
            cachedTime = new Time[]{Time.newInstance(8, 0, 0, 0), Time.newInstance(17, 0, 0, 0)};
            //cachedTime.add(Time.newInstance(8, 0, 0, 0));
            //cachedTime.add(Time.newInstance(17, 0, 0, 0));
        }
        
        return cachedTime;
    }
}