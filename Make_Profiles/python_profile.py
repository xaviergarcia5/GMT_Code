#!/usr/bin/env python
# THIS IS A PYTHON SCRIPT: Step 2: make a pretty plot of displacement vs. distance

import numpy as np 
import matplotlib.pyplot as plt 


def plot_with_dots(data_file, model_file, outname, data_label, model_label):
	print("Plotting", outname)
	# THE DREAM: CHANGE LABEL FONT SIZE, METERS --> CENTIMETERS
	[xd, yd, zd, pd, qd, _, _] = np.loadtxt(data_file, unpack=True);  # read in data (black dots)
	[xm, ym, zm, pm, qm, _, _] = np.loadtxt(model_file, unpack=True);  # read in model 
	plt.figure(dpi=300, figsize=(12,7));
	zd=np.multiply(zd, 100)
	zm=np.multiply(zm, 100) #unit cnversion into cm
	plt.plot(pd, zd, marker='.', color='black', linewidth=0, label=data_label);
	plt.plot(pm, zm, marker='.', color='orange', linewidth=0, label=model_label);
	plt.xlabel('Distance (km)');
	plt.ylabel('LOS (cm)');
	plt.legend();
	plt.grid(True);
	plt.savefig(outname);
	return;

if __name__ == "__main__":
	asc_data_file = "ascending_profile.txt"
	asc_model_file = "ascending_model_profile.txt"
	asc_outname = "profile_for_asc.png"
	plot_with_dots(asc_data_file, asc_model_file, asc_outname, data_label="Asc Data", model_label="Asc Model, 5.8 km depth, Mw5.3");
	des_data_file = "descending_profile.txt"
	des_model_file = "descending_model_profile.txt"
	des_outname = "profile_for_desc.png"
	plot_with_dots(des_data_file, des_model_file, des_outname, data_label="Desc Data", model_label="Desc Model, 5.8 km depth, Mw5.3");