params.input = "input/*.xlsx"

process  xlsxConvert {
  input:
  publishDir "/home/orfeas/Documents/sraQuery/output/"
    path xlsx_file
  output:
    path "${xlsx_file.baseName}.csv"

  script:
  """
  python3 /home/orfeas/Documents/sraQuery/xlsx.py ${xlsx_file}
  """
}

workflow {
    xlsx_file = Channel.fromPath(params.input) | xlsxConvert
    }