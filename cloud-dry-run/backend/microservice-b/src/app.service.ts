import { Injectable } from '@nestjs/common';
import { MessageDto } from './dto/message.dto';

@Injectable()
export class AppService {
  getHello(): MessageDto {
    return { message: 'Hello from Microservice B' };
  }
}
