# Snakemake Performance Testing
Snakemake pipeline to test file system performance. This tests file creation, network download, and disk throughput speeds.

## General Configuration
Modify [`config.yaml`](config/config.yaml) based on the desired parameters.
* Edit `numfiles` to change number of files to create.
* Edit `filesize` to change the size of a single file to create. This will be copied to test disk throughput speeds.
* Edit `download` to the source of file to be downloaded. This is to test network download speed.

## Output
All files and raw benchmarks from Snakemake can be found in [`results/`]. The calculated speeds are reported in [`results/benchmarks/speeds.log`].

## Results
Below are testing results of the pipeline with FlowDeploy on different AWS file system configurations.
| **Operation**                 | **EBS** | **Instance Store** | **FSx** | **ObjectiveFS** | **S3Fs** |
|-------------------------------|---------|--------------------|---------|-----------------|----------|
| Files created per second      | -       | -                  | 418     | 582             | 8        |
| Network download speed (MB/s) | -       | -                  | 33.04   | 48.42           | 33.47    |
| Disk throughput (MB/s)        | -       | -                  | 862.3   | 215.6           | 45.13    |