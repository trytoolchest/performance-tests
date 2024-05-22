SAMPLES = [f'sample{i}' for i in range(1000)]

LINK = 'https://s3.amazonaws.com/igenomes.illumina.com/Escherichia_coli_K_12_DH10B/Ensembl/EB1/Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'
FILE = 'Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'

rule all:
    input:
        expand('created_files/{sample}.txt', sample=SAMPLES),
        'downloads/' + FILE,
        'copies/' + FILE,
        'benchmarks/total_time_create_files.log'

rule create_files:
    output:
        'created_files/{sample}.txt'
    benchmark:
        'benchmarks/create_files/{sample}.log'
    shell:
        'touch {output}'

rule download_files:
    params:
        link=LINK,
    output:
        'downloads/' + FILE
    benchmark:
        'benchmarks/download_files.log'
    shell:
        'curl -o {output} {params.link}'

rule copy_files:
    input:
        'downloads/' + FILE
    output:
        'copies/' + FILE
    benchmark:
        'benchmarks/copy_files.log'
    shell:
        'cp {input} {output}'

rule calculate_total_time:
    input:
        expand('benchmarks/create_files/{sample}.log', sample=SAMPLES)
    output:
        'benchmarks/total_time_create_files.log'
    run:
        total_time = 0
        for benchmark_file in input:
            with open(benchmark_file, 'r') as f:
                time = float(f.readlines()[1].split('\t')[0])
                total_time += time
        with open(output[0], 'w') as f:
            f.write(f'Total time: {total_time}\n')