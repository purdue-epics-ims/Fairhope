/**
 * Backend Report javasript namespace. Contains the main functionality 
 * of the backend Report page. If you need to use this namespace in a 
 * different page, do not bind the default event handlers during initialization.
 *
 * @namespace BackendReport
 */
 $(document).ready(function() { 
    $('#generate-daily').click(function() {
            var start;
			var end;
			if($('#daily-radio-today').prop('checked'))
			{
			start = new Date();
			start.set({ 'hour': 23 });
			start.set({ 'minute': 59 });
			start.set({ 'second': 59 });
			
			end = new Date();
			end.set({ 'hour': 00 });
			end.set({ 'minute': 00 });
			end.set({ 'second': 00 });
			
			}
			else if($('#daily-radio-daypicker').prop('checked')){
			start = Date.parseExact($('#daily-report #start-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 23:59:59');
			start = new Date(start);
			end = Date.parseExact($('#daily-report #start-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 00:00:00');
			end = new Date(end);
			}
			var serviceId = $('#daily-report #select-service').val();
			
			var divi =  document.createElement("div"); divi.setAttribute("id","Daily-Report");
			var table = document.createElement("table");table.setAttribute("id","datagrid");table.style.whiteSpace = "nowrap";table.style.textAlign = "center";
			var tableBody = document.createElement("tbody");
			var headtext = ["First Name ","Last Name ","Date of Birth ","No show ","Date ","Referrer_Agency","Referers","Service type"];
			var header = document.createElement("tr");
			header.className = "header";
			header.style.fontSize = "15px";header.style.background = "#0070A8";
			
			for (var i = 0; i < 8; i++) {
			var headercell = document.createElement("th");
			var headerText = document.createTextNode(headtext[i]);
			headercell.appendChild(headerText);
			header.appendChild(headercell);
			}	
			tableBody.appendChild(header);
			
			console.log(GlobalVariables);
			var appointment = GlobalVariables.appointments;
			var customers =  GlobalVariables.customers;
			var row = 0;
			var rownum = 0;
	    		var services=["Clothing","Clothing, PNP","Clothing Layette B","Clothing Layette G","Clothing Layette B, PNP","Clothing Layette G, PNP","Maternity Clothing","Others"];
			$.each(appointment, function(index, a) {
				console.log(a);
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
					sdt = new Date(sdt);
                			if (sdt <= start & sdt >= end) {
					$.each(customers, function(index, c) {
						
						if(c.id == a.id_users_customer)
						{
							console.log(c);
							var content = [c.first_name,c.last_name,c.dob,a.no_show_flag,a.start_datetime.toString('yyyy/MM/dd'),c.agency,c.name,services[a.id_services-3]];
							row = document.createElement("tr");
							if(rownum % 2 == 0)
							{
								row.className = "alt";
								row.style.background = "#E1EEF4";
							}
							for (var i = 0; i < 8; i++) {
							var cell = document.createElement("td");
							var cellText = document.createTextNode(content[i]);
							cell.appendChild(cellText);
							row.appendChild(cell);
							tableBody.appendChild(row);
							rownum = rownum + 1;
							}
						}
					});
                }
            });



			table.appendChild(tableBody);
			divi.appendChild(table);

			var printWin = window.open('', '', 'left=0,top=0,width=700,height=500,toolbar=0,scrollbars=0,status  =0');
			//printWin.document.write(html);

			printWin.document.body.appendChild(divi);
    });
	$('#generate-monthly').click(function() {
            var date = new Date();
			var start;
			var end;
			if($('#monthly-radio-single').prop('checked'))
			{
			start = new Date(date.getFullYear(), date.getMonth() + 1, 0);
			start.set({ 'hour': 23 });
			start.set({ 'minute': 59 });
			start.set({ 'second': 59 });
			
			end = new Date(date.getFullYear(), date.getMonth(), 1);
			end.set({ 'hour': 00 });
			end.set({ 'minute': 00 });
			end.set({ 'second': 00 });
			}
			else if($('#monthly-radio-ranged').prop('checked')){
			end = Date.parseExact($('#monthly-report #start-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 00:00:00');
			end = new Date(end);
			start = Date.parseExact($('#monthly-report #end-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 23:59:59');
			start= new Date(start);
			}
			
			var serviceId = $('#monthly-report #select-service').val();
		//Monthly report title
			var monthNames=["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];
			var title=document.createElement("tr");
			var titletext=["Month of ", monthNames[end.getMonth()] , end.getFullYear(), "Client report "];
			var counter = 0;
			for(counter=0; counter < 4; counter++){
				var title_cell=document.createElement("th");
				var title_text=document.createTextNode(titletext[counter]);
				title_cell.appendChild(title_text);
				title.appendChild(title_cell);
			}
			
			var divi =  document.createElement("div"); divi.setAttribute("id","Monthly-Report");
			var table = document.createElement("table");table.setAttribute("id","datagrid");table.style.whiteSpace = "nowrap";table.style.textAlign = "center";
			var tableBody = document.createElement("tbody");
			var headtext = ["Clients Seen ","Children ","Layettes ","Pack&Play ","Clients Scheduled ","No Show ", "%No Show "];
			var header = document.createElement("tr");
			header.className = "header";
			header.style.fontSize = "15px";header.style.background = "#0070A8";
			for (var i = 0; i <= 6; i++) {
			var headercell = document.createElement("th");
			var headerText = document.createTextNode(headtext[i]);
			headercell.appendChild(headerText);
			header.appendChild(headercell);
			}	
			tableBody.appendChild(title);
			tableBody.appendChild(header);	
			var appointment = GlobalVariables.appointments;
			var customers =  GlobalVariables.customers;
			var row;
			var rownum = 0;
		//Current Month Statistics
			 var num_noshow=0;
			 var total_children=0;
			 var total_layettes=0;
			 var percent_noshow=0;
			 var total_pnp=0;
			 var total_clients=0;
			 $.each(appointment,function(index,a) {
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
				sdt = new Date(sdt);
                		if (sdt <= start & sdt >= end) { 
			 		$.each(customers,function(index,c){
						if(c.id==a.id_users_customer) {
							total_clients++;
							if(a.no_show_flag==1){
								num_noshow++;
							}
						       	total_children += Number(c.num_of_children);
							total_layettes+=(Number(a.layette_boy)+Number(a.layette_girl));
							total_pnp+=Number(a.pnp_qty);
						}
					});
				}
			}); 
			var num_showup=total_clients-num_noshow;
			percent_noshow=(100*num_noshow/total_clients).toFixed(2) + "%";
			var content=[num_showup,total_children,total_layettes,total_pnp,total_clients,num_noshow,percent_noshow];
			row = document.createElement("tr");
			for(var i=0;i<=6;i++){
				var cell = document.createElement("td");
				var cellText = document.createTextNode(content[i]);
				cell.appendChild(cellText);
				row.appendChild(cell);
			}
			tableBody.appendChild(row);
		//Year-to-date-report tile	
			var title=document.createElement("tr");
			var titletext=["Year-To-Date Client Report", start.getFullYear()];
			var counter = 0;
			for(counter=0; counter < 2; counter++){
				var title_cell=document.createElement("th");
				var title_text=document.createTextNode(titletext[counter]);
				title_cell.appendChild(title_text);
				title.appendChild(title_cell);
			}
			tableBody.appendChild(title);
			var header = document.createElement("tr");
			header.className = "header";
			header.style.fontSize = "15px";header.style.background = "#0070A8";
			for (var i = 0; i <= 6; i++) {
			var headercell = document.createElement("th");
			var headerText = document.createTextNode(headtext[i]);
			headercell.appendChild(headerText);
			header.appendChild(headercell);
			}
			tableBody.appendChild(header);
		//Year-to-date statistic
			var num_noshow=0;
			 var total_children=0;
			 var total_layettes=0;
			 var percent_noshow=0;
			 var total_pnp=0;
			 var total_clients=0;
			 var start_year=start.getFullYear();
		 	 var Jan=new Date();
			 Jan.setFullYear(Number(start_year), 0, 1);
			 Jan.setHours(0);
			 Jan.setMinutes(0);
			 Jan.setSeconds(0);
			 console.log("Jan",Jan);
			 console.log("old start",start);
			 $.each(appointment,function(index,a) {
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
				sdt = new Date(sdt);
                		if (sdt <= start & sdt >= Jan) { 
			 		$.each(customers,function(index,c){
						if(c.id==a.id_users_customer) {
							total_clients++;
							if(a.no_show_flag==1){
								num_noshow++;
							}
						       	total_children += Number(c.num_of_children);
							total_layettes+=(Number(a.layette_boy)+Number(a.layette_girl));
							total_pnp+=Number(a.pnp_qty);
						}
					});
				}
			}); 
			var num_showup=total_clients-num_noshow;
			percent_noshow=(100*num_noshow/total_clients).toFixed(2) + "%";
			var content=[num_showup,total_children,total_layettes,total_pnp,total_clients,num_noshow,percent_noshow];
			row = document.createElement("tr");
			for(var i=0;i<=6;i++){
				var cell = document.createElement("td");
				var cellText = document.createTextNode(content[i]);
				cell.appendChild(cellText);
				row.appendChild(cell);
			}
			tableBody.appendChild(row);
		//Previous Year-to-date report
		//Previous Year report title
			var title=document.createElement("tr");
			var titletext=["Previous Year Report", start.getFullYear()-1];
			var counter = 0;
			for(counter=0; counter < 2; counter++){
				var title_cell=document.createElement("th");
				var title_text=document.createTextNode(titletext[counter]);
				title_cell.appendChild(title_text);
				title.appendChild(title_cell);
			}
			tableBody.appendChild(title);
			var header = document.createElement("tr");
			header.className = "header";
			header.style.fontSize = "15px";header.style.background = "#0070A8";
			for (var i = 0; i <= 6; i++) {
			var headercell = document.createElement("th");
			var headerText = document.createTextNode(headtext[i]);
			headercell.appendChild(headerText);
			header.appendChild(headercell);
			}
			tableBody.appendChild(header);
		//Previous Year Statistics(Both "start" and Jan are set to one year earlier. They will be reset to curret year later)
			var num_noshow=0;
			 var total_children=0;
			 var total_layettes=0;
			 var percent_noshow=0;
			 var total_pnp=0;
			 var total_clients=0;
		         var start_year=start.getFullYear();
		 	// var Jan=new Date();
			 start.setFullYear(Number(start_year)-1);
			 console.log("start",start);
			 Jan.setFullYear(Number(start_year)-1);
			 console.log("Jan",Jan);
			 $.each(appointment,function(index,a) {
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
				sdt = new Date(sdt);
                		if (sdt <= start & sdt >= Jan) { 
			 		$.each(customers,function(index,c){
						if(c.id==a.id_users_customer) {
							total_clients++;
							if(a.no_show_flag==1){
								num_noshow++;
							}
						       	total_children += Number(c.num_of_children);
							total_layettes+=(Number(a.layette_boy)+Number(a.layette_girl));
							total_pnp+=Number(a.pnp_qty);
						}
					});
				}
			}); 
			var num_showup=total_clients-num_noshow;
			percent_noshow=(100*num_noshow/total_clients).toFixed(2) + "%";
			var content=[num_showup,total_children,total_layettes,total_pnp,total_clients,num_noshow,percent_noshow];
			row = document.createElement("tr");
			for(var i=0;i<=6;i++){
				var cell = document.createElement("td");
				var cellText = document.createTextNode(content[i]);
				cell.appendChild(cellText);
				row.appendChild(cell);
			}
			tableBody.appendChild(row);
		//Current Month Referring Agency
		 	var agencies=[];
			var times=[];
			start.setFullYear(Number(start_year));
			console.log("new start",start);
			console.log("end",end);
			$.each(appointment,function(index,a) {
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
				sdt = new Date(sdt);
                		if (sdt <= start & sdt >= end) {
					$.each(customers,function(index,c){
						if(c.id==a.id_users_customer) {
							if(agencies.includes(c.agency)){
								times[agencies.indexOf(c.agency)]++;
							}
							else{
								agencies.push(c.agency);
								times[agencies.indexOf(c.agency)]=1;
							}
						}
					})
				}
			})
			console.log("agencies",agencies);
			console.log("times",times);
			var title=document.createElement("tr");
			var titletext=["Month of ", monthNames[end.getMonth()] , end.getFullYear(), "Agency report "];
			var counter = 0;
			for(counter=0; counter < 4; counter++){
				var title_cell=document.createElement("th");
				var title_text=document.createTextNode(titletext[counter]);
				title_cell.appendChild(title_text);
				title.appendChild(title_cell);
			}
			tableBody.appendChild(title);
			var i=agencies.length;
			console.log("i",i);
			for(counter=0; counter<i; counter++){
				var row = document.createElement("tr");
				if(rownum % 2 == 0){
					row.className = "alt";
					row.style.background = "#E1EEF4";
				}
				for (var j = 0; j < 2; j++) {
					var cell = document.createElement("td");
					if(j==0){
						cellText=document.createTextNode(agencies[counter]);		
					}else{
						cellText=document.createTextNode(times[counter]);
					}
					cell.appendChild(cellText);
					row.appendChild(cell);
				}
			//	row.appendChild(cell);
				tableBody.appendChild(row);
				rownum ++;
			}
		//Previous Month Referring Agency
			table.appendChild(tableBody);
			divi.appendChild(table);			
			var printWin = window.open('', '', 'left=0,top=0,width=700,height=500,toolbar=0,scrollbars=0,status  =0');
			printWin.document.body.appendChild(divi);
    });
	$('#generate-noshow').click(function() {
            var start;
			var end;
			var appointment = GlobalVariables.appointments;
			var customers =  GlobalVariables.customers;
			var serviceId = $('#monthly-report #select-service').val();
			
			if($('#noshow-radio-active').prop('checked'))
			{
			start = new Date();
			start.set({ 'hour': 23 });
			start.set({ 'minute': 59 });
			start.set({ 'second': 59 });
			
			var dayadd = 0;
			$.each(GlobalVariables.availableProviders, function(index, provider) {
				$.each(provider['services']['id'], function(si, id) {
					if(serviceId == id){
						dayadd = provider['services']['no_show_count_period'][si];
					}
				});
			});
			end = new Date();
			end.setDate(end.getDate() - dayadd);
			
			end.set({ 'hour': 00 });
			end.set({ 'minute': 00 });
			end.set({ 'second': 00 });
			}
			else if($('#noshow-radio-select').prop('checked')){
			end = Date.parseExact($('#noshow-report #start-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 23:59:59');
			end = new Date(end);
			start = Date.parseExact($('#noshow-report #end-datetime').val(),
                    'MM/dd/yyyy').toString('yyyy,MM,dd 00:00:00');
			start= new Date(start);
			}
			
			var serviceId = $('#noshow-report #select-service').val();
			
			var divi =  document.createElement("div"); divi.setAttribute("id","Noshow-Report");
			var table = document.createElement("table");table.setAttribute("id","datagrid");table.style.whiteSpace = "nowrap";table.style.textAlign = "center";
			var tableBody = document.createElement("tbody");
			var headtext = ["First Name ","Last Name ","Date of Birth ","No show ","Date ","Referral "];
			var header = document.createElement("tr");
			header.className = "header";
			header.style.fontSize = "15px";header.style.background = "#0070A8";
			
			for (var i = 0; i < 6; i++) {
			var headercell = document.createElement("th");
			var headerText = document.createTextNode(headtext[i]);
			headercell.appendChild(headerText);
			header.appendChild(headercell);
			}	
			tableBody.appendChild(header);
			
			
			var appointment = GlobalVariables.appointments;
			var customers =  GlobalVariables.customers;
			var row;
			var rownum = 0;
			$.each(appointment, function(index, a) {
				var sdt = a.start_datetime.toString('yyyy,MM,dd HH:mm:ss');
					sdt = new Date(sdt);
					//console.log(serviceId,a.id_services);
                if (sdt <= start & sdt >= end & serviceId == a.id_services & a.no_show_flag == 1) {
					$.each(customers, function(index, c) {
						if(c.id == a.id_users_customer)
						{
							var content = [c.first_name,c.last_name,c.dob,a.no_show_flag,a.start_datetime.toString('yyyy/MM/dd')];
							row = document.createElement("tr");
							if(rownum % 2 == 0)
							{
								row.className = "alt";
								row.style.background = "#E1EEF4";
							}
							for (var i = 0; i < 5; i++) {
							var cell = document.createElement("td");
							var cellText = document.createTextNode(content[i]);
							cell.appendChild(cellText);
							row.appendChild(cell);
							tableBody.appendChild(row);
							rownum = rownum + 1;
							}
						}
					});		
                }
            });
	
			table.appendChild(tableBody);
			divi.appendChild(table);

			var printWin = window.open('', '', 'left=0,top=0,width=700,height=500,toolbar=0,scrollbars=0,status  =0');
			//printWin.document.write(html);

			printWin.document.body.appendChild(divi);
    });
	
	Datepicker($('#daily-report #start-datetime'),$(),0);
	Datepicker($('#monthly-report #start-datetime'),$('#monthly-report #end-datetime'),30);
	Datepicker($('#noshow-report #start-datetime'),$('#noshow-report #end-datetime'),30);
	$('#selectbasic').click(function() {
		console.log($('#selectbasic option:selected').text());
	});
});
function Datepicker($start_pick,$end_pick,interval){
		var startDatetime = new Date();
		startDatetime.setDate(startDatetime.getDate() - interval);
        startDatetime = startDatetime.toString('MM/dd/yyyy');
        var endDatetime  = new Date().toString('MM/dd/yyyy');
		
        $start_pick.datetimepicker({
            'dateFormat': 'mm/dd/yy',
            // Translation
            dayNames: [EALang['sunday'], EALang['monday'], EALang['tuesday'], EALang['wednesday'], 
                    EALang['thursday'], EALang['friday'], EALang['saturday']],
            dayNamesShort: [EALang['sunday'].substr(0,3), EALang['monday'].substr(0,3), 
                    EALang['tuesday'].substr(0,3), EALang['wednesday'].substr(0,3), 
                    EALang['thursday'].substr(0,3), EALang['friday'].substr(0,3),
                    EALang['saturday'].substr(0,3)],
            dayNamesMin: [EALang['sunday'].substr(0,2), EALang['monday'].substr(0,2), 
                    EALang['tuesday'].substr(0,2), EALang['wednesday'].substr(0,2), 
                    EALang['thursday'].substr(0,2), EALang['friday'].substr(0,2),
                    EALang['saturday'].substr(0,2)],
            monthNames: [EALang['january'], EALang['february'], EALang['march'], EALang['april'],
                    EALang['may'], EALang['june'], EALang['july'], EALang['august'], EALang['september'],
                    EALang['october'], EALang['november'], EALang['december']],
            prevText: EALang['previous'],
            nextText: EALang['next'],
            currentText: EALang['now'],
            closeText: EALang['close'],
            timeOnlyTitle: EALang['select_time'],
            timeText: EALang['time'],
            hourText: EALang['hour'],
            minuteText: EALang['minutes'],
            firstDay: 1
        });
        $start_pick.val(startDatetime);
        if($end_pick != $())
		{
			$end_pick.datetimepicker({
				'dateFormat': 'mm/dd/yy',
				// Translation
				dayNames: [EALang['sunday'], EALang['monday'], EALang['tuesday'], EALang['wednesday'], 
						EALang['thursday'], EALang['friday'], EALang['saturday']],
				dayNamesShort: [EALang['sunday'].substr(0,3), EALang['monday'].substr(0,3), 
						EALang['tuesday'].substr(0,3), EALang['wednesday'].substr(0,3), 
						EALang['thursday'].substr(0,3), EALang['friday'].substr(0,3),
						EALang['saturday'].substr(0,3)],
				dayNamesMin: [EALang['sunday'].substr(0,2), EALang['monday'].substr(0,2), 
						EALang['tuesday'].substr(0,2), EALang['wednesday'].substr(0,2), 
						EALang['thursday'].substr(0,2), EALang['friday'].substr(0,2),
						EALang['saturday'].substr(0,2)],
				monthNames: [EALang['january'], EALang['february'], EALang['march'], EALang['april'],
						EALang['may'], EALang['june'], EALang['july'], EALang['august'], EALang['september'],
						EALang['october'], EALang['november'], EALang['december']],
				prevText: EALang['previous'],
				nextText: EALang['next'],
				currentText: EALang['now'],
				closeText: EALang['close'],
				timeOnlyTitle: EALang['select_time'],
				timeText: EALang['time'],
				hourText: EALang['hour'],
				minuteText: EALang['minutes'],
				firstDay: 1
			});
			$end_pick.val(endDatetime);
		}
}

		/*
var BackendReport = {
    // :: CONSTANTS
    FILTER_TYPE_PROVIDER: 'provider',
    FILTER_TYPE_SERVICE: 'service',
    
    // :: VALIABLES
    lastFocusedEventData: undefined, // Contain event data for later use.
    
    
    /**
     * Event: Add Customer Button "Click"
     *//*
	 $('#generateButton1').click(function() {
            var start;
			if($('daily-radio-today').prop("checked", true))
			{
			start = new Date();
            var currentMin = parseInt(start.toString('mm'));
            
            if (currentMin > 0 && currentMin < 15) 
                start.set({ 'minute': 15 });
            else if (currentMin > 15 && currentMin < 30)
                start.set({ 'minute': 30 });
            else if (currentMin > 30 && currentMin < 45)
                start.set({ 'minute': 45 });
            else 
                start.addHours(1).set({ 'minute': 0 });
			console.log(start);
			}
			else if($('daily-radio-daypicker').prop("checked", true)){
			start = Date.parseExact($('#start-datetime').val(),
                    'MM/dd/yyyy HH:mm').toString('yyyy-MM-dd HH:mm:ss');
			console.log(start);
			}
        });
	       
    /**
     * This method reloads the registered appointments for the selected date period 
     * and filter type.
     * 
     * @param {object} $calendar The calendar jQuery object.
     * @param {int} recordId The selected record id.
     * @param {string} filterType The filter type, could be either FILTER_TYPE_PROVIDER
     * or FILTER_TYPE_SERVICE.
     * @param {date} startDate Visible start date of the calendar.
     * @param {type} endDate Visible end date of the calendar.
     */
    /*GetAppointmentsByDate: function(recordId, filterType, startDate, endDate) {
        var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_get_appointments';
        var postData = {
            'record_id': recordId,
            'start_date': startDate.toString('yyyy-MM-dd'),
            'end_date': endDate.toString('yyyy-MM-dd'),
            'filter_type': filterType
        };

        $.post(postUrl, postData, function(response) {
            ////////////////////////////////////////////////////////////////////
            console.log('Get Appointments by Date Response :', response);
            ////////////////////////////////////////////////////////////////////
            
            if (!GeneralFunctions.handleAjaxExceptions(response)) return;
            
            // :: ADD APPOINTMENTS TO CALENDAR
            var calendarEvents = [];
            var $calendar = $('#calendar');
            
            $.each(response.appointments, function(index, appointment){
                var event = {
                    'id': appointment['id'],
                    'title': appointment['service']['name'] + ' - ' 
                            + appointment['customer']['first_name'] + ' ' 
                            + appointment['customer']['last_name'],
                    'start': appointment['start_datetime'],
                    'end': appointment['end_datetime'],
                    'allDay': false,
                    'data': appointment // Store appointment data for later use.
                };
                
                //calendarEvents.push(event);
            });
            
            // :: ADD PROVIDER'S UNAVAILABLE TIME PERIODS
            var calendarView = $calendar.fullCalendar('getView').name;
            
            if (filterType === BackendCalendar.FILTER_TYPE_PROVIDER && calendarView !== 'month') {
                $.each(GlobalVariables.availableProviders, function(index, provider) {
                    if (provider['id'] == recordId) {

                    } 
                });
            }
        }, 'json');
    },
    */
