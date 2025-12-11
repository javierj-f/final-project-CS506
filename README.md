# CS506 Final Project

### How to Build and Run
    1. Clone Repository
    2. cd FINAL-PROJECT-CS506
    3. make install
    4. make check
    5. make test
    6. make run

### Troubleshooting
    If `make` command is not available (Windows users), use these manual commands:
    ```bash
    # Install dependencies
    pip install -r requirements.txt

    # Verify project structure
    python -c "import os; print('Data files:', len(os.listdir('data')))"

    # Run tests
    python -m pytest tests/ -v

    # Launch notebook
    jupyter notebook

### Video Link

    https://youtu.be/Hy6XqKj9vVM

This project will explore the extent of the effects of weather conditions and lunar phases on coastal tides in the United States.

It is known that the Moon's phases cause a variation in the tidal range based on the alignment between itself, the Earth and the Sun. On new and full moons, we see more extreme tides as the Earth is in almost perfect alignment with the Sun and Moon, while tides tend to mellow during phases where we see perpendicular alignment that exerts lesser gravitational forces on the tides of the Earth. However, this alone does not directly influence flooding. The weather on Earth also has to play its part, creating a perfect storm for flooding in a U.S. city.

In order to execute this project, we can take daily publicly available weather data from four cities in the United States and their respective National Oceanic and Atmosphere Administration (NOAA) tide data across a span of approximately 5 years. NOAA tide gauges publish their flood stage thresholds for a given day, with by-the-hour precision. These thresholds are used to define minor, moderate, and major flooding in a city. For this project, a "flood" is an instance where the observed water level is higher than the minor flood threshold in a city, as even minor flooding results in damage and risk to human life. These thresholds ensure that flooding instances are properly documented per city and not generalized. We will also calculate the lunar phases based on the data in order to see the effect of parallel alignment phases. 

We have chosen four cities: two in the east coast and two in the west coast. Coastal cities will be impacted by lunar phases more strongly. The cities will be:

Boston, Massachusetts    
Virginia Key, Florida  
Seattle, Washington  
Los Angeles, California       

## Data Collection

Data collection is a relatively straightforward task. The NOAA provides publicly accessible water level data for cities in the United States. For our cities, there is hourly tide data that can be collected per year. We will take this data and calculate the mean tide height per day. 

![noaa tide heights for Boston in 2023](/plots/noaa_tide_heights.png)

Next up was the process of gauging what we consider a flood instance. We can do this by getting the flood thresholds based on the MLLW (Mean Lower Low Water) datum, which gives us a conservative baseline for water depth. This was also the datum we used for the raw tide data before. We will use the minor flooding threshold for this.

From this process, we know the threshold for all 4 of our cities:

    Boston, MA: 12.50ft  
    Seattle, WA: 13.46ft  
    Virginia Key, FL: 3.53ft  
    Los Angeles, CA: 6.99ft  

![noaa tide thresholds for Boston in 2023](/plots/noaa_thresholds.png)

This provides us with the same data from before but compared to the NOAA thresholds for Minor, Moderate, and Major flooding. From this alone, we can see some of the correlations we will see in our final results, even if they are not yet obvious. 

## Data Processing

We will use pandas to operate on the csv file of the raw data. The NOAA files come with the following headers:

        Date Time (GMT)  Predicted (ft) Preliminary (ft)  Verified (ft)  
    0  2023/01/01  00:00    8.684                -           9.19  
    1  2023/01/01  01:00    7.574                -           8.16  
    2  2023/01/01  02:00    5.846                -           6.45  
    3  2023/01/01  03:00    3.745                -           4.48  
    4  2023/01/01  04:00    1.793                -           2.56  


We will use the verified tide height for the purposes of this experiment, since this is the tide height we know happened. We will calculate the mean of the hourly data to create daily tide means as follows:

    Datetime	    Predicted_mean	Verified_mean	Verified_max	Verified_min  				
    2023-01-01	    4.872958	    5.464583	    10.32	        0.83  
    2023-01-02	    4.925042	    5.384583	    10.22	        0.97  
    2023-01-03	    4.993417	    5.487917	    10.17           1.00  
    2023-01-04	    5.060500	    5.751667	    10.58	        0.72  
    2023-01-05	    5.110250	    6.272917	    11.35	        1.4  

The Verified_max will give us the max tide per day, which we will use to indicate flooding because at some point in a given day, the max tide reached flood conditions. From our thresholds, taking Boston as an example, we see that a minor flood occurs when the tide goes above 12.5ft. This value remains unchanged as NOAA thresholds are based on historical data per station, so 12.5ft is already an estimate for minor flooding based on historical results. Each city will see the same process.

The next step is to introduce our independent variable, and we can do that with the PyEphem astronomy library. Rather than ripping moon phase data from the internet, we can define a function that takes the moon phase for every timestamp we have. If the moon is less than 10% or more than 90% visible, it is a new/full moon which means we have a parallel alignment phase. If it is below 40% or above 60% visible, we have a quarter moon phase and anything else is an intermediate phase.

Introducing Weather Data

While we are not hyperfocusing on exploring the effects of earthly weather on tides, it is true that its effect is non-negligible and should be accounted for. We will use meteostat to get the weather data, focusing on the things we know indicate low-pressure systems on Earth. Those features are wind speed, average temperature, and probability of precipitation. 


## The Results

Plotted below is the 2019-2023 results of minor flooding by moon phase. We have a dot plot that shows every day across the 5 years and what phase of the moon they were at along with their max verified tide average. From the dot plot, we can see some correlations. It is far more likely for a quarter moon (or a neap tide phase) to have lower tides on average. Intermediate phases, as their name suggests, also populate the middle and upper half of the plot. We can also see that parallel alignment phases present higher tides on average and are more likely to break the threshold of minor flooding.

![noaa floods by moon phase in Seattle 2019-2023](/plots/moon_tide_seattle.png)
![noaa floods by moon phase in Virginia Key 2019-2023](/plots/moon_tide_florida.png)
![noaa floods by moon phase in Boston 2019-2023](/plots/moon_tide_boston.png)
![noaa floods by moon phase in LA 2019-2023](/plots/moon_tide_la.png)

We also notice that Virginia Key is far more likely to experience flooding instances, with LA and Boston having similar numbers and Seattle being far lower than the rest. Now that we can visually see a correlation, the extent of the moon's influence can be quantified.

Running a function that will calculate the Moon Influence Score, we get this:

    	City	    Moon_Influence_Score
    0	Seattle	    0.304348
    1	Florida	    0.564286
    2	Boston	    0.793103
    3	LA	        0.976471

We can now see that LA and Boston seem to most strongly correlate their flooding to the moon phase, with Virginia Key and Seattle experiencing positive but perhaps not very strong results.

Training a Logisic Regression model on the datasets using our weather features, we can compare the moon phase impact to weather impact and see what truly impacts each city. 

    Seattle
    	    Feature	        Coefficient
        1	wspd	        0.183767
        2	prcp	        0.043451
        3	New/Full Moon	0.019074
        0	tavg	        -0.193391
        4	Quarter Moon	-0.499537

    Florida
    	    Feature	        Coefficient
        3	New/Full Moon	0.899499
        0	tavg	        0.041060
        1	wspd	        0.037204
        2	prcp	        0.014916
        4	Quarter Moon	-0.468645

    Boston
    	    Feature	        Coefficient
        3	New/Full Moon	1.432116
        1	wspd	        0.131787
        2	prcp	        0.044915
        0	tavg	        -0.029645
        4	Quarter Moon	-0.704355

    LA
    	    Feature	        Coefficient
        3	New/Full Moon   2.954350
        0	tavg            0.038080
        1	wspd	        0.026344
        2	prcp	        0.014940
        4	Quarter Moon	-0.648296

From these results, we can see that the moon phase has noticeable impact on high tides in Boston, LA, and Viginia Key. A parallel alignment phase dominates the feature importance, while Quarter Moons are consistently less important. We see that moon phase even trumps weather features indicative of low-pressure systems in the United States. The only outlier is Seattle, where no one feature appears to dominate the others, but we do see that parallel alignment phases and windspeed have similar importance.

In terms of seasonality, we can create a heatmap showing which months of the year are more likely to experience flooding per city. Here, we can see that in most cases, flooding is not indicative of the season except for LA and Florida, with LA having its highest flood probability in August and Florida seeing its peaks in September, October, and November of each year. However, the general lack of strong trends overall does support our hypothesis, given that moon phase is not indicative of the season which means terrestrial climate is not dominating the likelihood of flooding.

![Seasonality of Floods Heatmap](/plots/flood_season_heatmap.png)

## Conclusion

Given all of this, we can conclude that minor flooding in coastal cities is not as likely as we perhaps expected, but it is more likely when the Moon is in a parallel alignment phases in comparison to the Sun and Earth. The general trends of our data showed more instances of minor flooding during new or full moons, and higher tides during those phases overall. We also concluded that flood-inciting weather did not have as strong of an effect on tides as the moon phase did for at least 3 of our 4 cities, with Seattle overall not showing any strong connection to either moon phase or weather. While this may not be enough to declare or even predict that a flood will happen on every new and full moon, the results do show a non-negligible correlation that can be valuable in conjunction with other predictive methods to keep populations safe in high-tide conditions.
