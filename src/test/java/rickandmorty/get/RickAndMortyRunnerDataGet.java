package rickandmorty.get;

import com.intuit.karate.junit5.Karate;

public class RickAndMortyRunnerDataGet {
    @Karate.Test
    Karate rickAndMortyDataGet () {
        return Karate.run().relativeTo(getClass());
    }
}
