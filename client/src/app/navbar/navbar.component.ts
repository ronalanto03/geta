import { Component, OnInit } from '@angular/core';

import { User, Service} from '../_models/index';
import { ServiceService, AlertService } from '../_services/index';

@Component({
    moduleId: module.id,
    templateUrl: './navbar.component.html',
    styleUrls: ['./navbar.css'],
    selector: 'navbar',

})

export class NavbarComponent implements OnInit {
    currentUser: User;
    opened: Boolean = false;

    constructor(private serviceService: ServiceService, private alertService: AlertService) {
        this.currentUser = JSON.parse(localStorage.getItem('currentUser'));
    }

    toggle () {
      this.opened = !this.opened;
    }


    ngOnInit() {
    }



}