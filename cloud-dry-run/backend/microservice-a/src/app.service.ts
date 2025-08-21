// cloud-dry-run/backend/microservice-a/src/app.service.ts

import { Injectable } from '@nestjs/common';
import { MessageDto } from './dto/message.dto';

@Injectable()
export class AppService {
  getHello(): MessageDto {
    return { message: 'Hello from Microservice A' };
  }
}