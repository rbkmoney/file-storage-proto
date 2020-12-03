include "base.thrift"
include "msgpack.thrift"

namespace java com.rbkmoney.file.check
namespace erlang file_check

// id файла
typedef base.ID FileID

struct File {
    1: required string name
    2: required binary data
}

struct Options {
    1: optional list<FileExtension> allowed_file_extensions
    2: optional i8 max_file_name_size = 100
    3: optional string allowed_file_name_symbols = '^[\w\-. ]+$'
    4: optional i8 max_file_size_mb = 10
    5: optional i8 max_count_files = 10
}

enum FileExtension {
    jpg
    jpeg
    pdf
}

union FileStatus {
    1: FileStatusOk ok
    2: FileStatusError error
}

struct FileStatusOk {}

struct FileStatusError {
    1: required list<FileStatusErrorReason> errors
}

struct FileStatusErrorReason {
    1: required FileStatusErrorType type
    2: required string allowed_value
}

enum FileStatusErrorType {
    allowed_file_extensions
    max_file_name_size
    allowed_file_name_symbols
    max_file_size_mb
    max_count_files
}

exception FileNotFound {}

/*
* Сервис для проверки файлов
* */
service FileCheck {

    /*

    * */
    FileID CheckFile (1: File file, 2: Options options)

    /*

    * */
    FileStatus GetStatus (1: FileID file_id)
        throws (1: FileNotFound ex1)

}
