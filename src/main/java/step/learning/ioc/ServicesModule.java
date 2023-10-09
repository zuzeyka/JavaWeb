package step.learning.ioc;

import com.google.inject.Provides;
import com.google.inject.name.Names;
import step.learning.services.random.RandomServiceV1;
import step.learning.services.random.RandomService;
import step.learning.services.hash.Md5HashService;
import step.learning.services.hash.HashService;
import step.learning.services.hash.Sha1HashService;
import com.google.inject.AbstractModule;

public class    ServicesModule extends AbstractModule {


    private RandomService randomService ;
    @Provides
    private RandomService injectRandomService() {
        /* Провайдери - методи, які дозволяють більш гнучко керувати процесом
           інжекції залежностей. Зв'язується за типом даних - включається для
           кожної точки інжекції з типом RandomService. У якості інжектованого
           об'єкту буде те, що поверне даний метод. Назва методу - не має значення,
           тільки тип повернення.
         */
        if( randomService == null ) {
            randomService = new RandomServiceV1() ;
            randomService.seed( "0" ) ;  // як приклад того, що самого конструктора не достатньо
        }
        return randomService ;
    }
    @Override
    protected void configure() {
        bind( HashService.class )
                .annotatedWith( Names.named( "Digest-Hash" ) )
                .to( Md5HashService.class ) ;



        bind( HashService.class )
                .annotatedWith( Names.named( "DSA-Hash" ) )
                .to( Sha1HashService.class ) ;
    }
}
