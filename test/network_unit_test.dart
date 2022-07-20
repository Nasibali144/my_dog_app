import 'package:flutter_test/flutter_test.dart';
import 'package:my_dog_app/models/vote_model.dart';
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

    List<Vote> votes;
    late String id;
    test("test2: parsing votes", () {
      votes = voteListFromJson(response!);
      id = votes.first.id.toString();
      expect(votes, isList);
    });

    String? responseOne;
    test("test3: get one vote", () async {
      responseOne = await NetworkService.GET(NetworkService.API_ONE_VOTE + id, NetworkService.paramsEmpty());
      expect(responseOne, isNotNull);
    });

    Vote? vote;
    test("test4: parsing one vote", () {
      vote = voteFromJson(responseOne!);
      expect(vote is Vote, true);
    });

    String? responseCreate;
    test("test5: create new vote", () async {
      responseCreate = await NetworkService.POST(NetworkService.API_LIST_VOTES, NetworkService.paramsEmpty(), NetworkService.bodyVotes("LmGFTdAev", "subIdOne", 1));
      expect(responseCreate, isNotNull);
    });

    String? responseDelete;
    test("test6: delete my old vote", () async {
      responseDelete = await NetworkService.DELETE(NetworkService.API_ONE_VOTE + "104025", NetworkService.paramsEmpty());
      expect(responseDelete is String, true);
    });
  });
}