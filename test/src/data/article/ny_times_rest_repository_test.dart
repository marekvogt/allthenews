import 'dart:convert';

import 'package:allthenews/src/data/article/ny_times_rest_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../api_stubs/api_stubs_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  NYTimesRestRepository nyTimesRestRepository;
  MockHttpClient mockHttpClient;
  MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSettingsRepository = MockSettingsRepository();
    nyTimesRestRepository = NYTimesRestRepository(mockHttpClient, mockSettingsRepository);

    when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
  });

  group('contract tests', () {
    test(
      'should return valid most popular news when nytimes api call finish successfully',
      () async {
        when(mockHttpClient.get(any)).thenAnswer((_) async => json.decode(findApiStubBy('most_popular_news.json')));

        final articles = await nyTimesRestRepository.getMostPopularArticles();

        expect(articles, isA<List<Article>>());
        expect(articles, isNot([]));

        final article = articles.first;

        expect(article, isNot(null));
        expect(article.abstract, isNot(null));
        expect(article.url, isNot(null));
        expect(article.updateDateTime, isNot(null));
        expect(article.authorName, isNot(null));
        expect(article.title, isNot(null));
        expect(article.thumbnail, isNot(null));
      },
    );

    test(
      'should return valid latest news when nytimes api call finish successfully',
      () async {
        when(mockHttpClient.get(any)).thenAnswer((_) async => json.decode(findApiStubBy('latest_news.json')));

        final articles = await nyTimesRestRepository.getNewestArticles();

        expect(articles, isA<List<Article>>());
        expect(articles, isNot([]));

        final article = articles.first;

        expect(article, isNot(null));
        expect(article.abstract, isNot(null));
        expect(article.url, isNot(null));
        expect(article.updateDateTime, isNot(null));
        expect(article.authorName, isNot(null));
        expect(article.title, isNot(null));
        expect(article.thumbnail, isNot(null));
      },
    );
  });
}