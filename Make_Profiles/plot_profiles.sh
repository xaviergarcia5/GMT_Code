#!/bin/bash

# THIS IS A BASH SCRIPT. Step 1: create projections of data and model
# Descending data first
modeldir="/mnt/d/USGSInternship/Analysis/ExperimentDepthSearch/Outputs/depth5.8/"
des_datafile="/mnt/d/USGSInternship/Analysis/grd/des_meter.grd" 
des_modelfile=$modeldir"/des_model.grd"
asc_datafile="/mnt/d/USGSInternship/Analysis/grd/asc_meter.grd"
asc_modelfile=$modeldir"/asc_model.grd"

# Projection: C-115.6/33.13 = origin; A130 = azimuth; L=length(km); W=width(km) -Q=use km
# Generate profile for DATA
gmt grd2xyz $des_datafile | gmt project -C-115.6/33.13 -A130 -L-8/15 -W-0.5/0.5 -Q > descending_profile.txt
# generate profile for MODEL PREDICTIONS
gmt grd2xyz $des_modelfile | gmt project -C-115.6/33.13 -A130 -L-8/15 -W-0.5/0.5 -Q > descending_model_profile.txt
# Start Plotting DATA
proj="M4i"
gmt set MAP_FRAME_TYPE plain
gmt set FORMAT_GEO_MAP D
region="-R-115.82/-115.37/32.99/33.3"
gmt begin "Desc_Data_Plus_Profile" png 
gmt makecpt -T-0.03/0.03/0.001 -Croma
gmt coast $region -J$proj -Bx0.25 -By0.25 -Wthin,black
gmt grdimage $des_datafile -J$proj 
gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
gmt psscale -Dx10.8c/1.0c+w6.5c/0.3c+jBR -Bx0.01+l"LOS(m)" -J$proj
echo "-115.6 33.13" | gmt psxy -Sc0.1i -Wthick,black -Gwhite -J$proj
gmt end

gmt grd2xyz $asc_datafile | gmt project -C-115.6/33.13 -A130 -L-8/15 -W-0.5/0.5 -Q > ascending_profile.txt
# generate profile for MODEL PREDICTIONS
gmt grd2xyz $asc_modelfile | gmt project -C-115.6/33.13 -A130 -L-8/15 -W-0.5/0.5 -Q > ascending_model_profile.txt
# Start Plotting DATA
proj="M4i"
gmt set MAP_FRAME_TYPE plain
gmt set FORMAT_GEO_MAP D
region="-R-115.82/-115.37/32.99/33.3"
gmt begin "Asc_Data_Plus_Profile" png 
gmt makecpt -T-0.03/0.03/0.001 -Croma
gmt coast $region -J$proj -Bx0.25 -By0.25 -Wthin,black
gmt grdimage $asc_datafile -J$proj 
gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
gmt psscale -Dx10.8c/1.0c+w6.5c/0.3c+jBR -Bx0.01+l"LOS(m)" -J$proj
echo "-115.6 33.13" | gmt psxy -Sc0.1i -Wthick,black -Gwhite -J$proj
gmt end