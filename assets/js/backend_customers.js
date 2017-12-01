/**
 * Backend Customers javasript namespace. Contains the main functionality 
 * of the backend customers page. If you need to use this namespace in a 
 * different page, do not bind the default event handlers during initialization.
 *
 * @namespace BackendCustomers
 */
var BackendCustomers = {
    /**
     * The page helper contains methods that implement each record type functionality 
     * (for now there is only the CustomersHelper).
     * 
     * @type {object{
     */
    helper: {},
            
	/**
	 * This method initializes the backend customers page. If you use this namespace
	 * in a different page do not use this method. 
	 * 
	 * @param {bool} defaultEventHandlers (OPTIONAL = false) Whether to bind the default 
	 * event handlers or not.  
	 */
	initialize: function(defaultEventHandlers) {
		if (defaultEventHandlers == undefined) defaultEventHandlers = false; 
		
        BackendCustomers.helper = new CustomersHelper();
		BackendCustomers.helper.resetForm();
		BackendCustomers.helper.filter('');
        
        $('#filter-customers .results').jScrollPane();
        $('#customer-appointments').jScrollPane();
        
		if (defaultEventHandlers) {
			BackendCustomers.bindEventHandlers();
		}
	},
    
    /**
     * Default event handlers declaration for backend customers page.
     */
	bindEventHandlers: function() {
        CustomersHelper.prototype.bindEventHandlers();
	}
};

/**
 * This class contains the methods that are used in the backend customers page.
 * 
 * @class CustomersHelper
 */
var CustomersHelper = function() {
    this.filterResults = {};
};

/**
 * Binds the default event handlers of the backend customers page.
 */
CustomersHelper.prototype.bindEventHandlers = function() {
    /**
     * Event: Filter Customers Form "Submit"
     */
    $('#filter-customers form').submit(function(event) {
        var key = $('#filter-customers .key').val();
        $('#filter-customers .selected-row').removeClass('selected-row');
        BackendCustomers.helper.resetForm();
        BackendCustomers.helper.filter(key);
        return false;
    });
    
    /**
     * Event: Filter Customers Clear Button "Click"
     */
    $('#filter-customers .clear').click(function() {
        $('#filter-customers .key').val('');
        BackendCustomers.helper.filter('');
    });
    
    /**
     * Event: Customer Row "Click"
     * 
     * Display the customer data of the selected row.
     */
    $(document).on('click', '.customer-row', function() {
        if ($('#filter-customers .filter').prop('disabled')) {
            return; // Do nothing when user edits a customer record.
        }
        
        var customerId = $(this).attr('data-id');
        var customer = {};
        $.each(BackendCustomers.helper.filterResults, function(index, item) {
            if (item.id == customerId) {
                customer = item;
                return false;
            }
        });
        
        BackendCustomers.helper.display(customer);
        $('#filter-customers .selected-row').removeClass('selected-row');
        $(this).addClass('selected-row');
        $('#edit-customer, #delete-customer').prop('disabled', false);
    });

    /**
     * Event: Appointment Row "Click"
     * 
     * Display appointment data of the selected row.
     */
    $(document).on('click', '.appointment-row', function() {
        $('#customer-appointments .selected-row').removeClass('selected-row');
        $(this).addClass('selected-row');

        var customerId = $('#filter-customers .selected-row').attr('data-id');
        var appointmentId = $(this).attr('data-id');
        var appointment = {};

        $.each(BackendCustomers.helper.filterResults, function(index, c) {
            if (c.id === customerId) {
                $.each(c.appointments, function(index, a) {
                    if (a.id == appointmentId) {
                        appointment = a;
                        return false;
                    }
                });
                return false;
            }
        });

        BackendCustomers.helper.displayAppointment(appointment);
    });
    
    /**
     * Event: Appointment Row "Click"
     * 
     * Display appointment data of the selected row.
     */
    $(document).on('click', '.appointment-row-noshow', function () {
        $('#customer-appointments .selected-row').removeClass('selected-row');
        $(this).addClass('selected-row');

        var customerId = $('#filter-customers .selected-row').attr('data-id');
        var appointmentId = $(this).attr('data-id');
        var appointment = {};

        $.each(BackendCustomers.helper.filterResults, function (index, c) {
            if (c.id === customerId) {
                $.each(c.appointments, function (index, a) {
                    if (a.id == appointmentId) {
                        appointment = a;
                        return false;
                    }
                });
                return false;
            }
        });

        BackendCustomers.helper.displayAppointment(appointment);
    });
    /**
     * Event: Add Customer Button "Click"
     */
    $('#add-customer').click(function() {
        BackendCustomers.helper.resetForm();
        $('#add-edit-delete-group').hide();
        $('#save-cancel-group').show();
        $('.details').find('input, textarea').prop('readonly', false);

        $('#filter-customers button').prop('disabled', true);
        $('#filter-customers .results').css('color', '#AAA');
    });

    /**
     * Event: Edit Customer Button "Click"
     */
    $('#edit-customer').click(function() {
        $('.details').find('input, textarea').prop('readonly', false);
        $('#add-edit-delete-group').hide();
        $('#save-cancel-group').show();

        $('#filter-customers button').prop('disabled', true);
        $('#filter-customers .results').css('color', '#AAA');
    });

    /**
     * Event: Cancel Customer Add/Edit Operation Button "Click"
     */
    $('#cancel-customer').click(function() {
        var id = $('#customer-id').val();
        BackendCustomers.helper.resetForm();
        if (id != '') {
            BackendCustomers.helper.select(id, true);
        }
    });

    /**
     * Event: Save Add/Edit Customer Operation "Click"
     Left is database value, right is the form label
     */
    $('#save-customer').click(function() {
        var referrer = {
            'name' : $('#referrer').val(),
            'agency': $('#referring-agency').val()
        };

        /////////////////////
        // console.log('Referrer to be added: ', referrer);
        ////////////////////

        // Validate referrer
        var customer = {
            'first_name': $('#first-name').val(),
            'last_name': $('#last-name').val(),
            'num_of_children': $('#num-of-children').val(),
			'dob': $('#date-of-birth').val(),
            'notes': $('#notes').val()
        };

        if ($('#customer-id').val() != '') {
            customer.id = $('#customer-id').val();
        }

        if ($('#referrer-id').val() != '') {
            customer.id_referrer = $('#referrer-id').val();
        }

        if (!BackendCustomers.helper.validate(customer)) return;
        
        BackendCustomers.helper.validateReferrer(customer, referrer);

        //BackendCustomers.helper.save(customer);
    });

    /**
     * Event: Delete Customer Button "Click"
     */
    $('#delete-customer').click(function() {
        var customerId = $('#customer-id').val();
        
        var messageBtns = {};
        messageBtns[EALang['delete']] = function() {        
            BackendCustomers.helper.delete(customerId);
            $('#message_box').dialog('close');
        };
        messageBtns[EALang['cancel']] = function() {
            $('#message_box').dialog('close');
        };

        GeneralFunctions.displayMessageBox(EALang['delete_customer'], 
                EALang['delete_record_prompt'], messageBtns);
    });
};

/**
 * Save a customer record to the database (via ajax post).
 * 
 * @param {object} customer Contains the customer data.
 */
CustomersHelper.prototype.save = function(customer) {
    var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_save_customer';
    var postData = { 'customer': JSON.stringify(customer) };

    //////////////////////////////////////////////
    console.log('In prototype.save.......');
    /////////////////////////////////////////////
    
    $.post(postUrl, postData, function(response) {
        ///////////////////////////////////////////////////////////
        console.log('Save Customer Response:', response);
        ///////////////////////////////////////////////////////////
        
        if (!GeneralFunctions.handleAjaxExceptions(response)) return;
        
        Backend.displayNotification(EALang['customer_saved']);
        BackendCustomers.helper.resetForm();
        $('#filter-customers .key').val('');
        BackendCustomers.helper.filter('', response.id, true);
    }, 'json');
};

/**
 * Validate if referrer exists.
 *
 * @param {object} referrer Contains referrer data.
 */
 CustomersHelper.prototype.validateReferrer = function(customer, referrer) {
    var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_validate_referrer';
    var postData = { 'referrer' : JSON.stringify(referrer) };

    $.post(postUrl, postData, function(response) {
        ///////////////////////////////////////////////////////////
        console.log('Validate Referrer Response:', response);
        ///////////////////////////////////////////////////////////
        
        if (!GeneralFunctions.handleAjaxExceptions(response)) return;

        if (response.id == -1) {
            ///////////////////////////////////////////////////////
            console.log('Referrer does not exist. Adding referrer...');
            ///////////////////////////////////////////////////////

            //alert('Referrer record not found. Do you want to create a new Referrer?');
            BackendCustomers.helper.addReferrer(customer, referrer); 
        } else {
            $('#referrer-id').val(response.id);
            customer.id_referrer = response.id;
            //////////////////////////////////////////////////////
            console.log('Referrer exists. Saving customer...');
            //////////////////////////////////////////////////////
            BackendCustomers.helper.save(customer);
        }

        ///////////////////////////////////////////////////////////
        console.log("id_referrer: " , response.id);
        ///////////////////////////////////////////////////////////
    }, 'json');
 }

 /**
 * Add referrer if referrer does not exist.
 *
 * @param {object} referrer Contains referrer data.
 */
 CustomersHelper.prototype.addReferrer = function(customer, referrer) {
    var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_save_referrer';
    var postData = { 'referrer' : JSON.stringify(referrer) };
    var id_referrer;

    $.post(postUrl, postData, function(response) {
        ///////////////////////////////////////////////////////////
        console.log('Save Referrer Response:', response);
        ///////////////////////////////////////////////////////////
        
        if (!GeneralFunctions.handleAjaxExceptions(response)) return;
            
        $('#referrer-id').val(response.id);
        customer.id_referrer = response.id;
        BackendCustomers.helper.save(customer);

    }, 'json');
 }

/**
 * Delete a customer record from database.
 * 
 * @param {numeric} id Record id to be deleted. 
 */
CustomersHelper.prototype.delete = function(id) {
    var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_delete_customer';
    var postData = { 'customer_id': id };
    
    $.post(postUrl, postData, function(response) {
        ////////////////////////////////////////////////////
        console.log('Delete customer response:', response);
        ////////////////////////////////////////////////////
        
        if (!GeneralFunctions.handleAjaxExceptions(response)) return;
        
        Backend.displayNotification(EALang['customer_deleted']);
        BackendCustomers.helper.resetForm();
        BackendCustomers.helper.filter($('#filter-customers .key').val());
    }, 'json');
};

/**
 * Validate customer data before save (insert or update).
 * 
 * @param {object} customer Contains the customer data.
 */
CustomersHelper.prototype.validate = function(customer) {
    $('#form-message').hide();
    $('.required').css('border', '');
    
    try {
        // Validate required fields.
        var missingRequired = false;
        $('.required').each(function() {
            if ($(this).val() == '') {
                $(this).css('border', '2px solid red');
                missingRequired = true;
            }
        });
        if (missingRequired) {
            throw EALang['fields_are_required'];
        }
        return true;

    } catch(exc) {
        $('#form-message').text(exc).show();
        return false;
    }
};

/**
 * Bring the customer form back to its initial state.
 */
CustomersHelper.prototype.resetForm = function() {
    $('.details').find('input, textarea').val(''); 
    $('.details').find('input, textarea').prop('readonly', true); 
    
    $('#customer-appointments').html('');
    $('#appointment-details').html('');
    $('#edit-customer, #delete-customer').prop('disabled', true);
    $('#add-edit-delete-group').show();
    $('#save-cancel-group').hide();
    
    $('.details .required').css('border', '');
    $('.details #form-message').hide();
    
    $('#filter-customers button').prop('disabled', false);
    $('#filter-customers .selected-row').removeClass('selected-row');
    $('#filter-customers .results').css('color', '');
};

/**
 * Display a customer record into the form.
 * 
 * @param {object} customer Contains the customer record data.
 */
CustomersHelper.prototype.display = function(customer) {
    $('#customer-id').val(customer.id);
    $('#referrer-id').val(customer.id_referrer);
    $('#first-name').val(customer.first_name);
    $('#last-name').val(customer.last_name);
    $('#num-of-children').val(customer.num_of_children);
	$('#date-of-birth').val(customer.dob);
    $('#notes').val(customer.notes);
    $('#referrer').val(customer.referrer.name);
    $('#referring-agency').val(customer.referrer.agency);
    $('#customer-appointments').data('jsp').destroy();
    $('#customer-appointments').empty();

    if (customer.id_referrer == null) {
        $('#referrer').val('');
        $('#referring-agency').val('');
        return;
    }

    /* Display customer appt. details */
    $.each(customer.appointments, function(index, appointment) {
        var start = Date.parse(appointment.start_datetime).toString('MM/dd/yyyy HH:mm');
        var end = Date.parse(appointment.end_datetime).toString('MM/dd/yyyy HH:mm');
        if (appointment.no_show_flag == 1) {
            var html =
                '<div class="appointment-row-noshow" data-id="' + appointment.id + '">' +
                    '<b>' + start + ' - ' + end + '</b>' + '<br>' +
                    $('#referring-agency').val() + ', ' + $('#referrer').val() + '<br>' +
                    appointment.service.name +
                '</div>';
        }
        else {
            var html =
                '<div class="appointment-row" data-id="' + appointment.id + '">' +
                    '<b>' + start + ' - ' + end + '</b>' + '<br>' +
                    $('#referring-agency').val() + ', ' + $('#referrer').val() + '<br>' +
                    appointment.service.name +
                '</div>';
        }
        $('#customer-appointments').append(html);
    });
    $('#customer-appointments').jScrollPane({ mouseWheelSpeed: 70 });
    $('#appointment-details').empty();    
}

/**
 * Filter customer records.
 * 
 * @param {string} key This key string is used to filter the customer records.
 * @param {numeric} selectId (OPTIONAL = undefined) If set then after the filter 
 * operation the record with the given id will be selected (but not displayed).
 * @param {bool} display (OPTIONAL = false) If true then the selected record will
 * be displayed on the form.
 */
CustomersHelper.prototype.filter = function(key, selectId, display) {
    if (display == undefined) display = false;
    
    var postUrl = GlobalVariables.baseUrl + 'backend_api/ajax_filter_customers';
    var postData = { 'key': key };
    
    $.post(postUrl, postData, function(response) {
        ///////////////////////////////////////////////////////
        console.log('Filter Customers Response:', response);
        ///////////////////////////////////////////////////////
        
        if (!GeneralFunctions.handleAjaxExceptions(response)) return;
        
        BackendCustomers.helper.filterResults = response;
        
        $('#filter-customers .results').data('jsp').destroy(); 
        $('#filter-customers .results').html('');
        $.each(response, function(index, customer) {
           var html = BackendCustomers.helper.getFilterHtml(customer);
           $('#filter-customers .results').append(html);
        });
        $('#filter-customers .results').jScrollPane({ mouseWheelSpeed: 70 });
        
        if (response.length == 0) {
            $('#filter-customers .results').html('<em>' + EALang['no_records_found'] + '</em>');
        }
        
        if (selectId != undefined) {
            BackendCustomers.helper.select(selectId, display);
        }
        
    }, 'json');
};

/**
 * Get the filter results row html code.
 * 
 * @param {object} customer Contains the customer data.
 * @return {string} Returns the record html code.
 */
CustomersHelper.prototype.getFilterHtml = function(customer) {
    var name = customer.last_name + '<br>' + customer.first_name;
    var info = customer.dob; 
    
    var html = 
            '<div class="customer-row" data-id="' + customer.id + '">' +
                '<strong>' + 
                    name + 
                '</strong><br>' + 
                info +
            '</div><hr>';
    
    return html;
};
 
/**
 * Select a specific record from the current filter results. If the customer id does not exist 
 * in the list then no record will be selected. 
 * 
 * @param {numeric} id The record id to be selected from the filter results.
 * @param {bool} display (OPTIONAL = false) If true then the method will display the record
 * on the form.
 */
CustomersHelper.prototype.select = function(id, display) {
    if (display == undefined) display = false;
    
    $('#filter-customers .selected-row').removeClass('selected-row');
    
    $('#filter-customers .customer-row').each(function() {
        if ($(this).attr('data-id') == id) {
            $(this).addClass('selected-row');
            return false;
        }
    });
    
    if (display) { 
        $.each(BackendCustomers.helper.filterResults, function(index, customer) {
            if (customer.id == id) {
                BackendCustomers.helper.display(customer);
                $('#edit-customer, #delete-customer').prop('disabled', false);
                return false;
            }
        });
    }
}; 
 
/**
 * Display appointment details on customers backend page.
 * 
 * @param {object} appointment Appointment data
 */
CustomersHelper.prototype.displayAppointment = function(appointment) {
    var start = Date.parse(appointment.start_datetime).toString('MM/dd/yyyy HH:mm');
    var end = Date.parse(appointment.end_datetime).toString('MM/dd/yyyy HH:mm');

    var notes;
    if (appointment.notes != '') {
        notes = appointment.notes + '<br>';
    } else {
        notes = '';
    }

    var layette_b = 'Layette (B): ';
    var layette_g = 'Layette (G): ';
    var pnp = 'PNP: ';
    var backpack = 'Backpack: ';

    var html = 
            '<div>' + 
                '<strong>' + appointment.service.name + '</strong><br>' + 
                layette_b + appointment.layette_boy + '<br>' +
                layette_g + appointment.layette_girl + '<br>' +
                pnp + appointment.pnp_qty + '<br>' +
                backpack + appointment.backpack_qty + '<br>' +
                notes + 
                start + ' - ' + end + '<br>' +
            '</div>';

    $('#appointment-details').html(html);
};





