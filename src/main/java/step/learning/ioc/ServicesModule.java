package step.learning.ioc;

import com.google.inject.AbstractModule;
import step.learning.services.formparse.FormParseService;
import step.learning.services.formparse.MixedFormParseService;

public class ServicesModule extends AbstractModule {
    @Override
    protected void configure()
    {
        bind(FormParseService.class).to(MixedFormParseService.class);
    }
}
