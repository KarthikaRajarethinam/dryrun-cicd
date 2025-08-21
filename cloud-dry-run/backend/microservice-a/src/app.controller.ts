import { Controller, Get } from '@nestjs/common';
import { MessageDto } from './dto/message.dto';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('hello')
  getHello(): MessageDto {
    return this.appService.getHello();
  }
}
