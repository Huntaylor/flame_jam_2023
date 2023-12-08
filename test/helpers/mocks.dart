import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flame_jam_2023/loading/loading.dart';
import 'package:mocktail/mocktail.dart';

class MockPreloadCubit extends MockCubit<PreloadState>
    implements PreloadCubit {}

class MockAudioCache extends Mock implements AudioCache {}
