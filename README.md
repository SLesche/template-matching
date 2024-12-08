# Template Matching for ERP Latency Measurement

Welcome to the repository for our **Template Matching Algorithm**, developed to measure ERP (Event-Related Potential) latencies with high precision. This repository includes MATLAB functions to implement the algorithm, example data, and an example script to help users get started.

---

## Contents

1. **`functions/`**  
   This folder contains the core MATLAB functions for performing template matching and ERP latency measurement. Each function is well-documented and designed for modular use.

2. **`data/`**  
   Example datasets for testing the algorithm, including synthetic and real ERP waveforms to illustrate the algorithm's robustness.

3. **`app/`**
   This folder contains scripts needed to run the interactive review app of the algorithm.

5. **`example_script.m`**  
   A MATLAB script that demonstrates the full workflow, from loading data to running the template matching algorithm and interpreting the results.

6. **`README.md`**  
   You’re reading it now!
---

## Requirements

To use this repository, ensure you have the following:

- MATLAB R2023b or later (earlier versions may work but are untested).
- Signal Processing Toolbox (required for certain operations).
- Parallel Processing Toolbox (in case you want to parallelize template matching).

---

## Usage

1. Clone this repository to your local machine or download and un-zip this entire repository manually.
   ```bash
   git clone https://github.com/SLesche/template-matching.git
   cd template-matching
   ```

2. Open MATLAB and add the repository to your MATLAB path:
   ```matlab
   addpath(genpath('path_to_repository'));
   ```

3. Run the example script to see the algorithm in action:
   ```matlab
   example_script
   ```

4. Explore and modify the script `example_script.m` to fit your data and analysis needs.

---

## Algorithm Overview

This template matching algorithm:
1. Generates a dynamic template from the grand average, allowing for linear transformation along the time- and amplitude-axis.
2. Generates a weighting function based on the user-specified weighting window and type of weighting function.
3. Optimizes the template's fit to a subject-level ERP in order to measure latency relative to the grand average.
4. Provides outputs on subject-level latency as well as fit statistics

The method is designed to be robust against noise and waveform variability, making it suitable for a wide range of ERP studies.

---

## Example Workflow

Here’s a brief outline of how to use the provided tools:

1. Load your ERP data using `load` or other data import functions.
2. Define the hyperparameters such as the relevant electrode, the weighting window, the type of weighting function and whether to apply a penalty.
3. Use the template matching functions (e.g., `run_template_matching.m`) to compute latencies.
4. If needed, review the algorithm using the `review_app`.
5. Visualize and analyze the results using the provided plotting utilities.

---

## Contributing

Contributions are welcome! Whether you’ve discovered a bug, have an idea for improvement, or want to extend the algorithm, feel free to submit an issue or a pull request.

---

## Questions or Feedback?

If you have any questions, encounter issues, or need assistance, please don’t hesitate to contact me:  
📧 **sven.lesche@psychologie.uni-heidelberg.de**

---

Thank you for using this repository! We hope it enhances your ERP research and analysis.

--- 
