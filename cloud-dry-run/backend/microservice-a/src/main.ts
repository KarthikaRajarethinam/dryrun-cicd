import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
//test command
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: true, // frontend address
    credentials: true,
  });

  await app.listen(3001);
  console.log('Microservice A running on http://localhost:3001');
}
bootstrap();
