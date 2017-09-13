import { Injectable } from '@angular/core';
import { Http, Headers, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map'
import {ServerInfoService} from './server_info.service'

@Injectable()
export class AuthenticationService {
    constructor(private http: Http, private serverInfo: ServerInfoService) { }

    login(username: string, password: string) {
        return this.http.post(this.serverInfo.getServerURL()+'/oauth/token', ({ email: username, password: password, grant_type:"password" }))
            .map((response: Response) => {
                // login successful if there's a jwt token in the response
                let user = {access_token: response.json().access_token, email: username};
                if (user && user.access_token) {
                    // store user details and jwt token in local storage to keep user logged in between page refreshes
                    localStorage.setItem('currentUser', JSON.stringify(user));
                }

                return user;
            });
    }

    logout() {
        // remove user from local storage to log user out
        localStorage.removeItem('currentUser');
    }
}


// curl -X POST -d 'grant_type=password&email=ronalanto03@gmail.com&password=19911991' localhost:3000/oauth/token