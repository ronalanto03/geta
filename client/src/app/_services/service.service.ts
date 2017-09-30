import { Injectable } from '@angular/core';
import { Http, Headers, RequestOptions, Response } from '@angular/http';
import {ServerInfoService } from './server_info.service'

import { Service } from '../_models/index';

@Injectable()
export class ServiceService {
    constructor(private http: Http, private serverInfo: ServerInfoService) { }

    getAll() {
        // console.log('HERE'  + this.http.get(this.serverInfo.getServerURL() + '/api/v1/services'));
        return this.http.get(this.serverInfo.getServerURL() + '/api/v1/services', this.jwt()).map((response: Response) => {
                // login successful if there's a jwt token in the response
                // let user = {access_token: response.json().access_token, email: username};
                // console.log('HERE' + response.json().data[0]);
                // if (user && user.access_token) {
                //     // store user details and jwt token in local storage to keep user logged in between page refreshes
                //     localStorage.setItem('currentUser', JSON.stringify(user));
                // }

                return response.json().data;
            });
    }

    getById(id: string) {
        // return this.http.get('/api/users/' + id, this.jwt()).map((response: Response) => response.json());

        return this.http.get(this.serverInfo.getServerURL() + '/api/v1/services/' + id, this.jwt()).map((response: Response) => {
                console.log('ID' + response.json());
                return response.json();
            });

    }

    create(service: Service) {
        return this.http.post('/api/v1/services', service, this.jwt()).map((response: Response) => response.json());
    }

    // update(user: User) {
    //     return this.http.put('/api/users/' + user.id, user, this.jwt()).map((response: Response) => response.json());
    // }

    // delete(id: number) {
    //     return this.http.delete('/api/users/' + id, this.jwt()).map((response: Response) => response.json());
    // }

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