class CamadaDeErros implements Exception {
  final String cause;
  final String? code;
  final StackTrace? stackTrace;

  CamadaDeErros(this.cause, {this.code, this.stackTrace});

  @override
  String toString() {
    final mensagem = code != null ? '[$code] $cause' : cause;
    return stackTrace != null ? '$mensagem\nStackTrace: $stackTrace' : mensagem;
  }
}