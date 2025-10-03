# CS506 Final Project

This project will explore the effects of weather conditions and lunar phases on tides in the United States for the purposes of predicting the existence of flooding.  

It is known that the Moon's phases cause a variation in the tidal range based on the alignment between itself, the Earth and the Sun. On new and full moons, we see more extreme tides as the Earth is in almost perfect alignment with the Sun and Moon, while tides tend to mellow during phases where we see perpendicular alignment that exerts lesser gravitational forces on the tides of the Earth. However, this alone does not directly influence flooding. The weather on Earth also has to play its part, creating a perfect storm for flooding in a U.S. city.

In order to execute this project, we can take daily publicly available weather data from two cities in the United States and their respective National Oceanic and Atmosphere Administration (NOAA) tide data across a span of approximately 5 years. NOAA tide gauges publish their flood stage thresholds for a given day, with by-the-hour precision. These thresholds are used to define minor, moderate, and major flooding in a city. For this project, a "flood" is an instance where the observed water level is higher than the minor flood threshold in a city, as even minor flooding results in damage and risk to human life. In the event that we see consistent flooding instances, we can instead compare our tide heights to the moderate threshold. These thresholds ensure that flooding instances are properly documented per city and not generalized. We will also calculate the lunar phases based on the data in order to see the effect of parallel alignment phases. Full moons are documented on sites that publicly display weather data, with predictable phase prediction.

For the purposes of this project, we will choose two cities: one in the east coast and one in the west coast. Coastal cities will be impacted by lunar phases more strongly. The cities will be:

Boston, Massachusetts  
Miami, Florida  

If possible, an additional two cities will be studied:
Seattle, Washington
Los Angeles, California    

This raw data will be put into one dataset to analyze any patterns when it comes to flooding frequency. These trends can be visualized via a histogram of flood frequency by moon phase and a scatter plot comparing weather conditions on days where there was flooding and days where there wasn't flooding. We can then use 80% of the data to train a classification model to estimate flood risk on a given day, likely using XGBoost to predict a binary outcome of a flood day or not a flood day. We can then test this on the remaining 20% of the dataset to evaluate its performance. Performance can be evaluated by a mixture of precision and recall. Recall will help measure how well we identify actual flood days and precision will show how often those predictions are correct.