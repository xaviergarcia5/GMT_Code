#!/usr/bin/env python
# THIS IS A PYTHON SCRIPT: Step 2: make a pretty plot of displacement vs. distance

import numpy as np 
import matplotlib.pyplot as plt 


def plot_with_dots(data_file, model_file, outname):
	# THE DREAM: CHANGE LABEL FONT SIZE, METERS --> CENTIMETERS
	[xd, yd, zd, pd, qd, _, _] = np.loadtxt(data_file, unpack=True);  # read in data (black dots)
	[xm, ym, zm, pm, qm, _, _] = np.loadtxt(model_file, unpack=True);  # read in model 
	plt.figure(dpi=300, figsize=(12,7));
	plt.plot(pd, zd, marker='.', color='black', linewidth=0, label="Desc Data");
	plt.plot(pm, zm, marker='.', color='orange', linewidth=0, label="Desc Model, 1 km depth, Mw5.4");
	plt.xlabel('Distance (km)');
	plt.ylabel('LOS (m)');
	plt.legend();
	plt.grid(True);
	plt.savefig(outname);
	return;


if __name__ == "__main__":
	data_file = "descending_profile.txt"
	model_file = "descending_model_profile.txt"
	outname = "profile_for_desc.png"
	plot_with_dots(data_file, model_file, outname);



