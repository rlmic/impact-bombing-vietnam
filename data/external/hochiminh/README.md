# [The long-term effects of war exposure on civic engagement](https://www.pnas.org/doi/abs/10.1073/pnas.2015539118)

## Description 

Unexplainable points in data from the Northern latitude, particularly from their hometown (Hue Province).
The students found that Hue Province used to belong to the south of Vietnam; however, the data in your war_data_district.dta with the variable "north_lat" seems too difficult for us to explain (the north_lat of Hue is larger than 17 - you basically used instrumental variable as 17th parallel. Hue Province is supposedly under the 17th parallel and belongs to the Southern part of Vietnam). When we look at the north_lat (at the 17th parallel, the province is by far from the official one on document)

As your data mentioned, the 17th latitude should be somewhere in Quang Nam and Quang Ngai (which is 20 kilometers south of the original documents). On some historical data, the 17th parallel should belong to Quang Tri Province, while your data showed that Quang Tri Province is on the 18th parallel.

After that, I collected the GIS data today for each province and used the center of the provincial government as the pointer from your war_data_province.dta. I matched again and calculated from district to province level (Please find the attached file), and each variation has around ~2.0-degree difference (around 200 kilometers). 

Our students and I attempted to look at the data, and we do not understand the difference in the instrumental variable about the north-latitude. When we use the new north latitude to estimate again, the IV becomes a weak IV, and the regression results might not hold anymore. 

Thanks a lot for your prompt reply and willingness to help us to explain it. 

I downloaded the data from your archived website (clear and well-organised one, personally I like it, here is http://emiguel.econ.berkeley.edu/research/the-long-run-impact-of-bombing-vietnam/).

Then, we have two .dta files (war_data_province.dta and war_data_district.dta) with the variables "north_lat" (North latitude). 

Just picked one province: Thuathien-Hue (currently, located at around 18 northern latitude in your data - above 17th parallel - belonging to the above-side). However, as far as I checked at NASA (Located at 16.5 degrees north latitude, Google GIS is around 16.4860° N). I expanded by collecting my own data collection and found some differences (attached file) for all provinces around 2 degree differences. How does it influence results? north_lat is used to calculate the "diff_17" (with abs) the differences from 17th parallel. The current version (probably) used the 15th parallel with no variation at another province but it is not the Vietnamese Demilitarized Zone, previously defined.

Thank you very much for your time and consideration. I know that it is so annoying that after many years, there is a guy who looks at the data and the paper and asks many annoying questions but my student and I really enjoyed reading the paper. We had a great conversation about the bombing in Vietnam (please accept my apologies to talk a bit). We also believed that there are still unexploded bombs in my country (not only all exploded during the war). It is our expansion of your study about Vietnam for many years after the Vietnam War. It is a side thing (not related to the data that we are mentioning at all).

Once again, I am looking forward to having your reply and please accept my sincerest apologies if having any inconvenience. In the meantime, if there is anything that we can do to support the process, please do not hesitate to contact me. 

https://www.jpl.nasa.gov/images/pia14554-hue-vietnam