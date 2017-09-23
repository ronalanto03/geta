import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  templateUrl: './newservice.component.html',
  styleUrls: ['./newservice.css']
})

export class NewServiceComponent implements OnInit {

	userForm: FormGroup;

	constructor(private _formBuilder: FormBuilder){}

	ngOnInit(){

		this.userForm = this._formBuilder.group({

			name: [null,[Validators.required]],
			description: ['',Validators.required],
			address: this._formBuilder.group({
				category: [null,Validators.required],
				status: [null,Validators.required],
				coordinates: ['',[Validators.pattern('^[0-9][1-9]{4}$'),Validators.required]]
			})

		})
	}

	onSubmit(){
		console.log(this.userForm.value);
	}

}
