class AuthException implements Exception {
  static const erros = <String, String>{
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente. Tente novamente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha incorreta.',
    'USER_DISABLED': 'Usuário desabiltado.',
    'INVALID_LOGIN_CREDENTIALS': 'As credencias informadas não conferem.'

  };

  final String key;

  const AuthException({
    required this.key,
  });

  @override
  String toString() {
    return (erros[key] ?? 'Ocorreu um erro na autenticação!').toString();
  }
}
