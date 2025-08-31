import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
//new comment added
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: true, // frontend address 
    credentials: true,
  });

  await app.listen(3002);
  console.log('Microservice B running on http://localhost:3002');
}
bootstrap();
