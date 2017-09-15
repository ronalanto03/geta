import { Component, OnInit } from '@angular/core';
import {Router} from '@angular/router';

import { User, Service} from '../_models/index';
import { AuthenticationService, AlertService } from '../_services/index';

@Component({
    moduleId: module.id,
    templateUrl: './navbar.component.html',
    styleUrls: ['./navbar.css'],
    selector: 'navbar',

})

export class NavbarComponent implements OnInit {
    currentUser: User;
    opened: Boolean = false;
    isLoggedin: Boolean = false;


    constructor(private authService: AuthenticationService,private router: Router, private alertService: AlertService) {
        this.currentUser = JSON.parse(localStorage.getItem('currentUser'));
        this.router.events.subscribe(route => {
            this.updateIsLoggedIn();
        });
    }

    toggle () {
      this.opened = !this.opened;
    }


    ngOnInit() {
    }

    private updateIsLoggedIn() {
        let currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (currentUser && currentUser.access_token) {
            this.isLoggedin = true;
        }
        else {
            this.isLoggedin = false;
        }
    }

    public logOut() {
         this.authService.logout();  
    }




}