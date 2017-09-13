import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import {Service} from '../_models/index';
import { ServiceService, AlertService } from '../_services/index';
import { AgmCoreModule } from '@agm/core';//to handle google maps (https://angular-maps.com/)


@Component({
    moduleId: module.id,
    templateUrl: 'service.component.html',
    styleUrls: ['./service.css']
})

export class ServiceComponent implements OnInit {
    service: Service;
    link: string = "https://www.shareicon.net/download/2016/07/06/107523_map_512x512.png";

    constructor(private serviceService: ServiceService, private alertService: AlertService, private route: ActivatedRoute) {
    }

    ngOnInit() {

        this.route.params.subscribe(params => {
        this.loadService(params['id']); // (+) converts string 'id' to a number

       // In a real app: dispatch action to load the details here.
    });
    }

    // deleteUser(id: number) {
    //     this.userService.delete(id).subscribe(() => { this.loadAllUsers() });
    // }

    private loadService(id: string) {
        // this.alertService.error("Starting");
        this.serviceService.getById(id).subscribe(
            data => { this.service = data.data; 
                     this.link = 'http://maps.googleapis.com/maps/api/staticmap?center=' + data.data.coordinates[0]+',' + data.data.coordinates[1] + '&size=200x200&sensor=false'; console.warn(this.service.status)},
            error => {
                    console.error('error=' + error);
                    this.alertService.error('There is no service with that id');
                }
            );
    }
}