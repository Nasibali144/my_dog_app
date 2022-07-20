import 'package:flutter_test/flutter_test.dart';
import 'package:my_dog_app/models/breed_model.dart';
import 'package:my_dog_app/services/network_service.dart';

void main() {

  // API_LIST_BREADS
  group("Test: Breed Category in Server", () {

    String? response;
    test("test1: check network: one element", () async {
      response = await NetworkService.GET("${NetworkService.API_LIST_BREADS}/1", NetworkService.paramsEmpty());
      expect(response, isNotNull);
    });

    test("test2: check model", () {
      Breed breed = breedFromJson(response!);
      expect(breed.id, 1);
    });

    test("test3: check network: list", () async {
      response = await NetworkService.GET(NetworkService.API_LIST_BREADS, NetworkService.paramsEmpty());
      expect(response, isNotNull);
    });

    test("test4: check model list", () async {
      List<Breed> breedList = breedListFromJson(response!);
      expect(breedList, isList);
    });
  });

  // API_LIST_VOTES
  group("Test: Votes", () {
    String? response;
    test("test1: get all votes", () async {
      response = await NetworkService.GET(NetworkService.API_LIST_VOTES, NetworkService.paramsVotesList());
      expect(response, isNotNull);
    });

    test("test2: parsing votes", () {});
  });
}