function fn() {
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);

    var baseUrl = karate.properties['baseUrl'] || 'https://rickandmortyapi.com/api/'

    return {
        api: {
           baseUrl: baseUrl
        }
    };
}