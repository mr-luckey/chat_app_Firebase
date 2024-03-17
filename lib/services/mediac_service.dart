// import 'package:file_picker/file_picker.dart';

// class MediaService {
//   MediaService() {}
//   Future<PlatformFile?> pickImageFromLaibrary() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowCompression: true,
//     );
//     if (result != null) {
//       return result.files.first;
//     }
//     return null;
//   }
// }
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';

// class MediaService {
//   MediaService() {}

//   Future<File?> pickImageFromLibrary() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowCompression: true,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       PlatformFile file = result.files.first;
//       return File(file.path!);
//     }
//     return null;
//   }
// }
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class MediaService {
  MediaService() {}

  Future<File?> pickImageFromLibrary() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}
