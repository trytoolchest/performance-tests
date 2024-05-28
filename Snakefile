TOTAL_FILES = 5
SAMPLES = [f'sample{i}' for i in range(TOTAL_FILES)]

LINK = 'https://s3.amazonaws.com/igenomes.illumina.com/Escherichia_coli_K_12_DH10B/Ensembl/EB1/Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'
FILE = 'Escherichia_coli_K_12_DH10B_Ensembl_EB1.tar.gz'

rule all:
    input:
        'benchmarks/create_files.log',
        'benchmarks/download_files.log',
        'benchmarks/copy_files.log',
        'benchmarks/speeds.log'

rule create_files:
    output:
        directory('created_files/')
    benchmark:
        'benchmarks/create_files.log'
    shell:
        """
        mkdir created_files
        for i in `seq 1 {TOTAL_FILES}`
        do
            touch created_files/sample$i.txt
        done
        """

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
        'benchmarks/create_files.log',
        'downloads/' + FILE,
        'benchmarks/download_files.log',
        'benchmarks/copy_files.log'
    output:
        'benchmarks/speeds.log'
    script:
        'metrics.py'

        