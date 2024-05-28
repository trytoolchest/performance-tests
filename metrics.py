import os

# # Get metrics for creating files (total time and files/s)
# total_time = 0
# total_files = 0
# for benchmark_file in snakemake.input[:-3]:
#     total_files += 1
#     with open(benchmark_file, 'r') as f:
#         time = float(f.readlines()[1].split('\t')[0])
#         total_time += time

# fps = int(total_files/total_time)
# with open(snakemake.output[0], 'w') as f:
#     f.write(f'Total time: {total_time}\n')

total_files = len(os.listdir('created_files'))
with open(snakemake.input[-4], 'r') as f: # open download log
    time = float(f.readlines()[1].split('\t')[0])
fps = int(total_files/time)
with open (snakemake.output[0], 'w') as f:
    f.write(f'Files created per second: {fps}\n')


# Calculate network download speed (MB/s)
size = os.path.getsize(snakemake.input[-3])/(1024**2) # get size of downloaded file
with open(snakemake.input[-2], 'r') as f: # open download log
    time = float(f.readlines()[1].split('\t')[0])
    speed = size/time
with open (snakemake.output[0], 'a') as f:
    f.write(f'Network download speed: {speed} MB/s\n')


# Calculate disk throughput (MB/s)
with open(snakemake.input[-1], 'r') as f: # open copy log
    time = float(f.readlines()[1].split('\t')[0])
    speed = size/time
with open (snakemake.output[0], 'a') as f:
    f.write(f'Disk throughput: {speed} MB/s\n')
