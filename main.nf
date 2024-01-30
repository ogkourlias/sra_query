nextflow.enable.dsl=2

process fetch {
  containerOptions '--bind /groups/'
  publishDir "${params.out_dir}", mode: 'symlink'
  errorStrategy 'retry'
  time '6h'
  memory '8 GB'
  cpus 1
  maxRetries 16
  
  input:
  path sra_path

  output:
  path "${sra_path.simpleName}.fastq.gz"
  
  script:
  """
  fastq-dump --gzip ${sra_path.simpleName}.sra
  """
}

process prefetch {
  containerOptions '--bind /groups/'
  errorStrategy 'retry'
  time '6h'
  memory '8 GB'
  cpus 1
  maxRetries 16
  
  input:
  val id_str

  output:
  path "${id_str.id}/*"
  
  script:
  """
  prefetch ${id_str.id}
  """
}


workflow {
    Channel.fromPath(params.input_csv).splitCsv(header: true, quote: '\"') | 
    view {row -> "$row.id"} |
    prefetch |
    fetch
    }