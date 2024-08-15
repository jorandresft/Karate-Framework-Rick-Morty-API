
# Karate-Framework-Rick And Morty

Proyecto de Karate Framework para probar la API Rick And Morty

## Pasos para replicar el proyecto

Seguir el paso a paso

```bash
  Abrir IntelliJ y crear un nuevo proyecto Java - Gradle
```

Modificar el archivo build.gradle con la siguiente estructura

```bash
plugins {
    id 'java'
}

repositories {
    maven {
        url 'https://repo.maven.apache.org/maven2'
    }
}

dependencies {
    testImplementation 'com.intuit.karate:karate-junit5:1.2.0.RC5'
    testImplementation 'net.masterthought:cucumber-reporting:5.7.0'
}

test {
    useJUnitPlatform()
    systemProperty "karate.env", System.properties.getProperty("karate.env")
    systemProperty "baseUrl", System.properties.getProperty("baseUrl")
    systemProperty "user", System.properties.getProperty("user")

    outputs.upToDateWhen { false }
}

sourceSets {
    test {
        resources {
            srcDir file('src/test/java')
            exclude '**/*.java'
        }
    }
}
```

Crear la estructura del proyecto

```bash
src/test/java/nombre_proyecto/get, post, etc...
```

Dentro de la carpeta src/test/java crear el archivo karate-config.js con la siguiente estructura

```bash
function fn(){
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);

    return{
        api:{
            baseUrl: 'https://rickandmortyapi.com/api/'
        }
    }
}
```

Dentro de la src/test/java puede crear otros archivos de configuración según el ambiente Ej. karate-config-preproductive.js con la siguiente estructura

```bash
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
```

Dentro de la carpeta src/test/java crear el archivo logback-test.xml con la siguiente estructura

```bash
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <appender name="FILE" class="ch.qos.logback.core.FileAppender">
        <file>build/karate.log</file>
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="com.intuit.karate" level="DEBUG"/>

    <root level="info">
        <appender-ref ref="STDOUT" />
        <appender-ref ref="FILE" />
    </root>

</configuration>
```

Para ejecutar test de forma paralela crear en la carpeta src/test/java el archivo ParallelTest con la siguiente estructura

```bash
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ParallelTest {

    @Test
    void testAll() {
        Results results = Runner.path("classpath:rickandmorty").outputCucumberJson(true).tags("~@ignore").parallel(4);
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("build"), "Karate-Framework-Rick-Morty-API");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
```

Crear los features y archivos necesarios para el proyecto

## Ejecutar Tests

Para ejecutar los casos de prueba, abrir una terminal y copiar el comando

```bash
  gradle clean test
```

Para ejecutar los casos de prueba según el ambiente, abrir una ventana cmd en la ruta del proyecto y copiar el comando

```bash
  gradle test --tests ParallelTest -Dkarate.env=preproductive -DbaseUrl=https://rickandmortyapi.com/api/ -i
```

## Authors

- Jorge Franco