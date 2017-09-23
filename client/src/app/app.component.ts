import { Component, OnInit } from '@angular/core';

@Component({
    moduleId: module.id,
    selector:'app',
    templateUrl: 'app.component.html',
    styleUrls: ['./app.component.css']
})

export class AppComponent implements OnInit{

	ngOnInit() {
		navigator.geolocation.getCurrentPosition(position => {
        // this.location = position.coords;
        console.log(position.coords);
      });
    }


}