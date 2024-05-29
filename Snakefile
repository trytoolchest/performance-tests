TOTAL_FILES = 1000
SAMPLES = [f'sample{i}' for i in range(TOTAL_FILES)]

LINK = 'https://s3.amazonaws.com/igenomes.illumina.com/Escherichia_coli_K_12_DH10B/Ensembl/EB1/Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'
FILE = 'Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'

rule all:
    input:
        'results/benchmarks/create_files.log',
        'results/benchmarks/download_files.log',
        'results/benchmarks/copy_files.log',
        'results/benchmarks/speeds.log'

rule create_files:
    output:
        directory('results/created_files/')
    benchmark:
        'results/benchmarks/create_files.log'
    shell:
        """
        mkdir -p results/
        mkdir -p results/created_files/
        for i in `seq 1 {TOTAL_FILES}`
        do
            touch results/created_files/sample$i.txt
        done
        """

rule download_files:
    params:
        link=LINK,
    output:
        'results/downloads/' + FILE
    benchmark:
        'results/benchmarks/download_files.log'
    shell:
        'curl -o {output} {params.link}'

rule copy_files:
    input:
        'results/downloads/' + FILE
    output:
        'results/copies/' + FILE
    benchmark:
        'results/benchmarks/copy_files.log'
    shell:
        'cp {input} {output}'

rule calculate_total_time:
    input:
        'results/benchmarks/create_files.log',
        'results/downloads/' + FILE,
        'results/benchmarks/download_files.log',
        'results/benchmarks/copy_files.log'
    output:
        'results/benchmarks/speeds.log'
    script:
        'metrics.py'

        