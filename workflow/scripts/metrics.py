import os

# Calculate files created per second (files/s)
total_files = len(os.listdir('results/created_files'))
with open(snakemake.input[0], 'r') as f: # open created log
    time = float(f.readlines()[1].split()[0])
fps = int(total_files/time)
with open (snakemake.output[0], 'w') as f:
    f.write(f'Files created per second: {fps}\n')


# Calculate network download speed (MB/s)
size = os.path.getsize(snakemake.input[1])/(1024**2) # get size of downloaded file
with open(snakemake.input[2], 'r') as f: # open download log
    time = float(f.readlines()[1].split()[0])
    speed = size/time
with open (snakemake.output[0], 'a') as f:
    f.write(f'Network download speed: {speed} MB/s\n')


# Calculate disk throughput (MB/s)
with open(snakemake.input[3], 'r') as f: # open copy log
    time = float(f.readlines()[1].split()[0])
    speed = size/time
with open (snakemake.output[0], 'a') as f:
    f.write(f'Disk throughput: {speed} MB/s\n')
