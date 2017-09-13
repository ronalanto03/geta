import { Component, OnInit } from '@angular/core';

import { User, Service} from '../_models/index';
import { ServiceService, AlertService } from '../_services/index';

@Component({
    moduleId: module.id,
    templateUrl: 'home.component.html',
    styleUrls: ['./home.css']
})

export class HomeComponent implements OnInit {
    currentUser: User;
    services: Service[] = [];

    constructor(private serviceService: ServiceService, private alertService: AlertService) {
        this.currentUser = JSON.parse(localStorage.getItem('currentUser'));
        console.log(this.currentUser);
    }

    ngOnInit() {
        this.loadAllUsers();
    }

    // deleteUser(id: number) {
    //     this.userService.delete(id).subscribe(() => { this.loadAllUsers() });
    // }

    private loadAllUsers() {
        this.serviceService.getAll().subscribe(
            data => { this.services = data;},
            error => {
                    this.alertService.error(error);
                }
            );

            // .subscribe(
            //     data => {
            //         this.router.navigate([this.returnUrl]);
            //     },
// );


    }
}