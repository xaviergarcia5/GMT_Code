#!/bin/bash

proj="M2i"
gmt set MAP_FRAME_TYPE plain
gmt set FORMAT_GEO_MAP D
scale="0.05"
region="-R-115.82/-115.37/32.99/33.3"
datafile_asc="../InSAR_Proc_Pipeline/intermediate/ASC/20210519_20210612.grd"
datafile_des="../InSAR_Proc_Pipeline/intermediate/DESC/20210525_20210612.grd"
fielddata="../../_Data/Fields_Boundaries.txt"
modeldir="Outputs/depth7.0/"

gmt begin $modeldir"/PredicAscGrid" png 
gmt subplot begin 1x3 -Fs5c -A -SCb -SRl
gmt makecpt -T-0.03/0.03/0.001 -Croma
gmt subplot set
  gmt coast $region -J$proj -Bx0.25 -By0.25 -Wthin,black
  gmt grdmath $datafile_asc 0.0044585987261146 MUL = asc_meter.grd #converting radians to m
  gmt grdimage asc_meter.grd -J$proj 
  gmt psxy $fielddata -W0.3p,firebrick -J$proj
  gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.42 33.01 -3 15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.42 33.01 10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
gmt subplot set
  gmt coast $region -J$proj -Bx0.5 -By0.25 -Wthin,black 
  gmt grdmath $modeldir"east.grd" 0.5814047715527206 NEG MUL = ascgrid1.grd
  gmt grdmath $modeldir"north.grd" 0.13422786792014785 NEG MUL = ascgrid2.grd 
  gmt grdmath $modeldir"vert.grd" 0.8024658 MUL = ascgrid3.grd
  gmt grdmath ascgrid1.grd ascgrid2.grd ADD = ascgrid4.grd
  gmt grdmath ascgrid3.grd ascgrid4.grd ADD NEG = ascgrid5.grd
  gmt grdsample ascgrid5.grd -Gasc_modelraw.grd `gmt grdinfo -I $datafile_asc` `gmt grdinfo -I- $datafile_asc` #G = new grd file  `` 
  temp=`echo "-115.428705 33.247781" | gmt grdtrack -Gasc_modelraw.grd` #substracting referenced pixels
  refval=`echo $temp | awk '{print $3}'`
  gmt grdmath asc_modelraw.grd $refval SUB = asc_model.grd
  gmt grdimage asc_model.grd -J$proj 
  gmt psxy $fielddata -W0.3p,firebrick -J$proj
  gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.42 33.01 -3 15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.42 33.01 10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1  
gmt subplot set
  gmt coast $region -J$proj -Bx0.5 -By0.25 -Wthin,black
  gmt grdmath asc_meter.grd asc_model.grd SUB = asc_residual.grd
  gmt grdimage asc_residual.grd -J$proj 
  gmt psxy $fielddata -W0.3p,firebrick -J$proj
  gmt coast -Wthin,black -Dh -J$proj
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.42 33.01 -3 15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.42 33.01 10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1  
  gmt psscale -Dx5.8c/4.0c+w3.9c/0.3c+jTC -Bx0.02+l"LOS(m)" -J$proj
gmt subplot end
gmt end
rm ascgrid1.grd ascgrid2.grd ascgrid3.grd ascgrid4.grd #rm = remove


proj="M2i"
gmt set MAP_FRAME_TYPE plain
gmt set FORMAT_GEO_MAP D
gmt begin $modeldir"/PredicDescGrid" png
gmt subplot begin 1x3 -Fs5c -A -SCb -SRl
gmt makecpt -T-0.03/0.03/0.001 -Croma
gmt subplot set
  gmt coast $region -J$proj -Bx0.5 -By0.25 -Wthin,black
  gmt grdmath $datafile_des 0.0044585987261146 MUL = des_meter.grd
  gmt grdimage des_meter.grd -J$proj
  gmt psxy $fielddata -W0.3p,firebrick -J$proj
  gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.46 33.28 -3 -15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.46 33.28 -10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1  
gmt subplot set
  gmt coast $region -J$proj -Bx0.5 -By0.25 -Wthin,black 
  gmt grdmath $modeldir"east.grd" 0.5954056798898428 MUL = desgrid1.grd
  gmt grdmath $modeldir"north.grd" 0.1374602323020541 NEG MUL = desgrid2.grd 
  gmt grdmath $modeldir"vert.grd" 0.79157865 MUL = desgrid3.grd
  gmt grdmath desgrid1.grd desgrid2.grd ADD = desgrid4.grd
  gmt grdmath desgrid3.grd desgrid4.grd ADD NEG = desgrid5.grd
  gmt grdsample desgrid5.grd -Gdes_modelraw.grd `gmt grdinfo -I $datafile_des` `gmt grdinfo -I- $datafile_des`
  temp=`echo "-115.428705 33.247781" | gmt grdtrack -Gdes_modelraw.grd` #substracting referenced pixels
  refval=`echo $temp | awk '{print $3}'`
  gmt grdmath des_modelraw.grd $refval SUB = des_model.grd
  gmt grdimage des_model.grd -J$proj
  gmt psxy $fielddata -W0.3p,firebrick -J$proj
  gmt coast -Wthin,black -Dh -J$proj -LjBL+o0.1i/0.3i+w5+u+c33
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.46 33.28 -3 -15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.46 33.28 -10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1  
gmt subplot set
  gmt coast $region -J$proj -Bx0.5 -By0.25 -Wthin,black
  gmt grdmath des_meter.grd des_model.grd SUB = des_residual.grd #also residual= model - data 
  gmt grdimage des_residual.grd -J$proj
  gmt psxy $fielddata -W0.3p,firebrick -J$proj 
  gmt coast -Wthin,black -Dh -J$proj
  echo "-115.428705 33.247781" | gmt psxy -Wthin,black -Gwhite -Sc0.05i -J$proj  # reference pixel
  echo "-115.46 33.28 -3 -15 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1
  echo "-115.46 33.28 -10 2 0 0 0" | gmt psvelo -J$proj -W2.2p,blue3,solid -Gwhite -Se$scale/0.68/0 -A12p+e+a30+h0+n0.02/1  
  gmt psscale -Dx5.8c/4.0c+w3.9c/0.3c+jTC -Bx0.02+l"LOS(m)" -J$proj  
gmt subplot end
gmt end
rm desgrid1.grd desgrid2.grd desgrid3.grd desgrid4.grd
