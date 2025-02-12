abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data, error: null);
}

class DataError<T> extends DataState<T> {
  const DataError(Exception error) : super(error: error);
}
