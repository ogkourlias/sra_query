nextflow.enable.dsl=2

process fastq_dump {
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
  fastq-dump --gzip ${sra_path}
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
  val id

  output:
  path "${id}/${id}.{}"
  
  script:
  """
  prefetch ${id}
  """
}


workflow {
    ids = Channel.fromPath(params.input_txt).splitText().view()
    prefetch(ids)
    }