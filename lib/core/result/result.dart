abstract class Result<L, R> {}

class Left<L, R> extends Result<L, R> {
  final L value;
  Left(this.value);
}

class Right<L, R> extends Result<L, R> {
  final R value;
  Right(this.value);
}

extension ResultFold<L, R> on Result<L, R> {
  T fold<T>(T Function(L l) leftOp, T Function(R r) rightOp) {
    if (this is Left<L, R>) {
      return leftOp((this as Left<L, R>).value);
    } else if (this is Right<L, R>) {
      return rightOp((this as Right<L, R>).value);
    }
    throw Exception('Invalid Result type');
  }
}