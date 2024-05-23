TOTAL_FILES = 1000
SAMPLES = [f'sample{i}' for i in range(TOTAL_FILES)]

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
        expand('benchmarks/create_files/{sample}.log', sample=SAMPLES),
        'downloads/' + FILE,
        'benchmarks/download_files.log',
        'benchmarks/copy_files.log'
    output:
        'benchmarks/total_time_create_files.log'
    script:
        'metrics.py'

        