import { isDevMode, Injectable } from '@angular/core';


@Injectable()
export class ServerInfoService {
    constructor() { }

    getServerURL() {
    	if(isDevMode())
          return 'http://localhost:3000';
        else
          return 'https://geta.herokuapp.com';
    }

}