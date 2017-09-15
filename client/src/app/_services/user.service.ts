import { Injectable } from '@angular/core';
import { Http, Headers, RequestOptions, Response } from '@angular/http';

import { User } from '../_models/index';
import {ServerInfoService } from './server_info.service'

@Injectable()
export class UserService {
    constructor(private http: Http, private serverInfo: ServerInfoService) { }

    getAll() {
        return this.http.get(this.serverInfo.getServerURL() + '/api/v1/services', this.jwt()).map((response: Response) => response.json());
    }

    getById(id: number) {
        return this.http.get(this.serverInfo.getServerURL() + '/api/users/' + id, this.jwt()).map((response: Response) => response.json());
    }

    create(user: User) {
        return this.http.post(this.serverInfo.getServerURL() + '/api/v1/registrations', {email:user.email, password:user.password}, this.jwt()).map((response: Response) => response.json());
    }

    update(user: User) {
        return this.http.put(this.serverInfo.getServerURL() + '/api/users/' + user.id, user, this.jwt()).map((response: Response) => response.json());
    }

    delete(id: number) {
        return this.http.delete(this.serverInfo.getServerURL() + '/api/users/' + id, this.jwt()).map((response: Response) => response.json());
    }

    // private helper methods

    private jwt() {
        // create authorization header with jwt token
        let currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (currentUser && currentUser.token) {
            let headers = new Headers({ 'Authorization': 'Bearer ' + currentUser.token });
            return new RequestOptions({ headers: headers });
        }
    }
}