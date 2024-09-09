import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  double menorFaturamento = double.infinity;
  double maiorFaturamento = 0;
  double somaFaturamento = 0;
  int diasAcimaMedia = 0;

  var map = await readJsonFile("C:\\Codes\\target-desafio\\lib\\dados.json");
  Map<int, double> faturamentoAnual = {};

  for (var item in map) {
    double valor = item['valor'];
    int dia = item['dia'];
    if(valor <= 0.0) {
      continue;
    }
    if(valor < menorFaturamento) {
      menorFaturamento = valor;
    }else if(valor > maiorFaturamento) {
      maiorFaturamento = valor;
    }
    somaFaturamento += valor;
    faturamentoAnual.addAll({dia: valor});
  }

  double mediaAnual = somaFaturamento / faturamentoAnual.length;

  print('Menor faturamento: \$${menorFaturamento.toStringAsFixed(2)}');
  print('Maior faturamento: \$${maiorFaturamento.toStringAsFixed(2)}');
  print('Dias acima da média anual:');
  for (var item in faturamentoAnual.entries) {
    if(item.value > mediaAnual) {
      diasAcimaMedia++;
      print('Dia ${item.key}: \$${item.value.toStringAsFixed(2)}');
    }
  }
  print('Total de dias acima da média anual: $diasAcimaMedia');
}

Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);
  return map;
}