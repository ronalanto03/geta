import { Injectable } from '@angular/core';


@Injectable()
export class ServerInfoService {
    constructor() { }

    getServerURL() {
        return 'http://localhost:3000/';
    }

}