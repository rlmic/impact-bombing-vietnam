import geopandas as gpd
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np


gdf = gpd.read_file("../../data/raw/province.shp")

gdf.set_crs(
    epsg="32648", inplace=True
)  

gdf.to_crs(
    epsg="4326", inplace = True
)

gdf = gdf.to_crs(epsg=4326) 

gdf.rename({'C99_RP': 'province'}, axis=1, inplace=True)

gdf['geometry'] = gdf.geometry.to_crs("epsg:4326")

gdf['centroid'] = gdf.centroid.to_crs("epsg:4326")



prov = pd.read_stata('../../data/clean/district_bombing_corrected.dta')
prov_orig = gpd.GeoDataFrame(
    prov[['north_lat', 'east_long']],
    geometry=gpd.points_from_xy(prov.east_long, prov.north_lat)
)


dist = pd.read_stata('../../data/clean/district_bombing_corrected.dta')

dist_orig = gpd.GeoDataFrame(
    dist[['north_lat', 'east_long']],
    geometry=gpd.points_from_xy(dist_orig.east_long, dist_orig.north_lat)
)

dist_corr = gpd.GeoDataFrame(
    dist[['north_lat_corrected', 'east_long_corrected']],
    geometry=gpd.points_from_xy(dist_corr.east_long_corrected, dist_corr.north_lat_corrected)
)


plt.rcParams.update({'font.size': 18})

fig, ax = plt.subplots(
    figsize=(20, 10)
)

gdf.plot(
    ax=ax,
    facecolor="none", 
    alpha=0.5,
    edgecolor='k',
    aspect=2
)


prov_orig.plot(
    ax=ax,
    marker='*',
    color='grey',
    markersize=7,
    label='Original coordinates'
)


gdf['centroid'].plot(
    ax=ax,
    marker='o',
    color='#4682B4',
    markersize=5,
    label='Corrected coordinates'
)


plt.plot(
    [100, 110],
    [17, 17],
    linewidth = 1,
    linestyle = "--",
    color = "k",
    label='17° North Latitude'
)

ax.spines[['right', 'top', 'left']].set_visible(False)

ax.get_yaxis().set_visible(False)

ax.legend(
    scatterpoints=1, 
    frameon=True,
    labelspacing=0.6, 
    loc='lower right', 
    fontsize=12, 
    bbox_to_anchor=(0.75,.95), 
    title_fontsize=10
)
listOf_Xticks = np.arange(100, 111, 5)
plt.xticks(listOf_Xticks)
listOf_Yticks = np.arange(7, 28, 5)
plt.yticks(listOf_Yticks)
plt.xlabel('East Longitude')
plt.show()
fig.savefig("../../outputs/figures/provinces_erratum.png", bbox_inches='tight', dpi=600)


plt.rcParams.update({'font.size': 18})

fig, ax = plt.subplots(
    figsize=(20, 10)
)
gdf.plot(
    ax=ax,
    facecolor="none", 
    alpha=0.5,
    edgecolor='k',
    aspect=2
)

dist_corr.plot(
    ax=ax,
    marker='o',
    color='#4682B4',
    markersize=2,
    label='Corrected coordinates'
)

dist_orig.plot(
    ax=ax,
    marker='*',
    color='grey',
    markersize=7,
    label='Original coordinates'
)


plt.plot(
    [100, 110],
    [17, 17],
    linewidth = 1,
    linestyle = "--",
    color = "k",
    label='17° North Latitude'
)

ax.legend(
    scatterpoints=1, 
    frameon=True,
    labelspacing=0.6, 
    loc='lower right', 
    fontsize=12, 
    bbox_to_anchor=(0.75,.95), 
    title_fontsize=10
)
ax.spines[['right', 'top']].set_visible(False)
listOf_Xticks = np.arange(100, 111, 5)
plt.xticks(listOf_Xticks)
listOf_Yticks = np.arange(7, 28, 5)
plt.yticks(listOf_Yticks)
 

plt.xlabel('East Longitude')
plt.ylabel('North Latitude')
plt.show()

fig.savefig("../../outputs/figures/districts_erratum.png", bbox_inches='tight', dpi=600)