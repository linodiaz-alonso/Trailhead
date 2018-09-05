public class ParkLocator {
    public static List<String> country(String countryName) {
        ParkService.ParksImplPort  parksImpl = 
            new ParkService.ParksImplPort();
        return parksImpl.byCountry(countryName);
    }
}