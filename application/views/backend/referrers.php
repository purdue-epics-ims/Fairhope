<!-- 
Let's start developing the referrers page! 
I understand that these comments are unnecessary but I really need to entertain myself.
Just remember to delete them!-->

<!--Step 1. Define links and script types -->
<link href="assets/js/libs/jquery/jquery.ui.css" rel="stylesheet" type="text/css" />

<!-- I am assuming these three scripts are libs that are already available. -->
<script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/libs/jquery/jquery-ui-timepicker-addon.js"></script>

<script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/libs/jquery/jquery.js"></script>

<script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/libs/jquery/jquery.ui.js"></script>

<!-- Here, we are defining where javascript file needed for this page is found. -->
<!-- TODO: As of now, we have not written the .js file for referrers. -->
<script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/backend_referrers.js"></script>
        
<script type="text/javascript">    
    var GlobalVariables = {
        'availableProviders': <?php echo json_encode($available_providers); ?>,
        'availableServices': <?php echo json_encode($available_services); ?>,
        'baseUrl': <?php echo '"' . $base_url . '"'; ?>,
        'customers': <?php echo json_encode($customers); ?>,
        'user'                  : {
            'id'        : <?php echo $user_id; ?>,
            'email'     : <?php echo '"' . $user_email . '"'; ?>,
            'role_slug' : <?php echo '"' . $role_slug . '"'; ?>,
            'privileges': <?php echo json_encode($privileges); ?>
        }
    };
    
    // COMMENCE PAGE LOADING
     $(document).ready(function() {
        BackendReferrers.initialize(true);
    });

</script>

<!-- Note: The <div> tag is nothing more than a container unit that encapsulates other page elements and divides
	the HTML doc into sections. This allows us to customize the sections using CSS in a modular manner! -->
<!-- Note: div class vs id: IDs are UNIQUE, classes are NOT UNIQUE -->
<!-- Note: fluid rows are adjusted accordingly based on percentages, rather than pixels. -->

<!-- Change id to referrers-page. I assume the class has been written by CodeIgniter or EA. -->
<div id="referrers-page" class="row-fluid">

	<!--                       PART A [Search Box]                          
	-->
	<!-- Change id to filter-referrers. I assume the class has been written by CodeIgniter or EA. -->
	<div id="filter-referrers" class="filter-records column span4">
		<!-- Also assume this has been written by CI or EA -->
		<!-- Note: HTML forms are used to collect user input.
				   The form elements include: input elements (text boxes), submit buttons, etc. -->
		<form class="input-append">
			<!-- This is the input element (aka the text box) -->
			<input class="key span12" id="search" type="text" />
			<!-- This is the search button -->
            <button class="filter btn" type="submit" title="<?php echo $this->lang->line('filter'); ?>">
                    <i class="icon-search"></i>
                </button>
                <!-- This is the refresh button -->
                <button class="clear btn" type="button" title="<?php echo $this->lang->line('clear'); ?>">
                    <i class="icon-repeat"></i>
                </button>
		</form>
		<!-- This is in the application\language\translations_lang.php file. -->
        <h2><?php echo $this->lang->line('referrers'); ?></h2>

        <!--			   PART B [List of Entries from DB]
        TODO:: Implement this results table [shows list of referrers] -->
        <div class="results"></div>
	</div>

	<!--                   PART C [Add/edit Buttons]
	-->
	<!-- TODO:: Remember to update privileges once I've figured out how to work it. -->
	<div class="details span7 row-fluid">
        <div class="btn-toolbar">
            <div id="add-edit-delete-group" class="btn-group">
                <?php if ($privileges[PRIV_CUSTOMERS]['add'] == TRUE) { ?>
                <button id="add-referrer" class="btn btn-primary">
                    <i class="icon-plus icon-white"></i>
                    <?php echo $this->lang->line('add'); ?>
                </button>
                <?php } ?>
                
                <?php if ($privileges[PRIV_CUSTOMERS]['edit'] == TRUE) { ?>
                <button id="edit-referrer" class="btn" disabled="disabled">
                    <i class="icon-pencil"></i>
                    <?php echo $this->lang->line('edit'); ?>
                </button>
                <?php }?>
                
                <?php if ($privileges[PRIV_CUSTOMERS]['delete'] == TRUE) { ?>
                <button id="delete-referrer" class="btn" disabled="disabled">
                    <i class="icon-remove"></i>
                    <?php echo $this->lang->line('delete'); ?>
                </button>
                <?php } ?>
            </div>
            
            <div id="save-cancel-group" class="btn-group" style="display:none;">
                <button id="save-referrer" class="btn btn-primary">
                    <i class="icon-ok icon-white"></i>
                    <?php echo $this->lang->line('save'); ?>
                </button>
                <button id="cancel-referrer" class="btn">
                    <i class="icon-ban-circle"></i>
                    <?php echo $this->lang->line('cancel'); ?>
                </button>
            </div>
        </div>

        <!-- Note: A hidden field is not visible to a user. It can store value changed by JS -->
	    <input id="referrer-id" type="hidden" />

	    <!--                      PART D [Details Form]
		-->
		<div class="span6" style="margin-left: 0;">
            <h2><?php echo $this->lang->line('details'); ?></h2>
            <div id="form-message" class="alert" style="display:none;"></div>
            
            <label for="name"><?php echo $this->lang->line('name'); ?> *</label>
            <input type="text" id="name" class="span11 required" />

            <label for="agency"><?php echo $this->lang->line('referring_agency'); ?> *</label>
            <input type="text" id="agency" class="span11 required" />

            <label for="email"><?php echo $this->lang->line('email'); ?> </label>
            <input type="text" id="email" class="span11" />

            <label for="phone-number"><?php echo $this->lang->line('phone_number'); ?> </label>
            <input type="text" id="phone-number" class="span11" />

            <label for="notes"><?php echo $this->lang->line('notes'); ?></label>
            <textarea id="notes" rows="4" class="span11"></textarea>
            
            <br/><br/>
            <center><em id="form-message" class="text-error">
                <?php echo $this->lang->line('fields_are_required'); ?></em></center>
        </div> 

        <!--				PART E [List of Clients Referred]
    	-->
    	<!-- TODO:: GOTTA IMPLEMENT THIS ENTIRE FEATURE!! -->
        <div class="span5">
            <h2><?php echo $this->lang->line('clients_referred'); ?></h2>
            <!-- the box -->
            <div id="clients-referred"></div>
            <!-- the details in the box -->
            <div id="client-details"></div>
        </div>
	</div>
</div>
