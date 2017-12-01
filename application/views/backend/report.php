<?php
date_default_timezone_set('America/Chicago');
?>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<link rel="stylesheet" 
        src="<?php echo $base_url; ?>assets/css/datepicker.css"></script>

<script type="text/javascript"
        src="<?php echo $base_url; ?>assets/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
        src="<?php echo $base_url; ?>assets/js/backend_report.js"></script>

<script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/libs/jquery/fullcalendar.min.js"></script>

        <script type="text/javascript" 
        src="<?php echo $base_url; ?>assets/js/libs/jquery/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript">    
    var GlobalVariables = {
        'availableProviders'    : <?php echo json_encode($available_providers); ?>,
        'availableServices'     : <?php echo json_encode($available_services); ?>,
        'baseUrl'               : <?php echo '"' . $base_url . '"'; ?>,
        'appointments'           : <?php echo json_encode($appointments); ?>,
        'customers'             : <?php echo json_encode($customers); ?>,
        'secretaryProviders'    : <?php echo json_encode($secretary_providers); ?>,
        'user'                  : {
            'id'        : <?php echo $user_id; ?>,
            'email'     : <?php echo '"' . $user_email . '"'; ?>,
            'role_slug' : <?php echo '"' . $role_slug . '"'; ?>,
            'privileges': <?php echo json_encode($privileges); ?>
        }
    };
    
    //$(document).ready(function() {
     //   BackendCalendar.initialize(true);
    //});
</script>
<!-- Start customizing code here -->
<div class="report-page">
    <div class="container">
        <div class="row">
             <h1 class="page-header">Reports</h1>

			
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h4 class="panel-default">
                                 Daily Report
                            </h4>
                        </div>

                            <div class="panel-body">This report generates the list of clients in a single business day.



                                <form class="form-horizontal">
                                <fieldset>

                                <!-- Multiple Radios -->
                                <div class="control-group" id="daily-report">
                                  <div class="controls">
                                    <label class="radio">
                                      <input type="radio" name="radios" id="daily-radio-today" value="Today" checked="checked">
                                      Today (<?php echo date("M jS, Y"); ?>)
                                    </label>
                                    <label class="radio">
                                      <input type="radio" name="radios" id="daily-radio-daypicker" value="Date:">
                                      Date: <input type="text" id="start-datetime" class="hasDatepicker">
                                    </label>
									
								  <select id="select-service">
                            <?php 
                                // Group services by category, only if there is at least one service 
                                // with a parent category.
                                foreach($available_services as $service) {
                                    if ($service['category_id'] != NULL) {
                                        $has_category = TRUE;
                                        break;
                                    }
                                }
                                
                                if ($has_category) {
                                    $grouped_services = array();

                                    foreach($available_services as $service) {
                                        if ($service['category_id'] != NULL) {
                                            if (!isset($grouped_services[$service['category_name']])) {
                                                $grouped_services[$service['category_name']] = array();
                                            }

                                            $grouped_services[$service['category_name']][] = $service;
                                        } 
                                    }

                                    // We need the uncategorized services at the end of the list so
                                    // we will use another iteration only for the uncategorized services.
                                    $grouped_services['uncategorized'] = array();
                                    foreach($available_services as $service) {
                                        if ($service['category_id'] == NULL) {
                                            $grouped_services['uncategorized'][] = $service;
                                        }
                                    }

                                    foreach($grouped_services as $key => $group) {
                                        $group_label = ($key != 'uncategorized')
                                                ? $group[0]['category_name'] : 'Uncategorized';
                                        
                                        if (count($group) > 0) {
                                            echo '<optgroup label="' . $group_label . '">';
                                            foreach($group as $service) {
                                                echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
                                            }
                                            echo '</optgroup>';
                                        }
                                    }
                                }  
								else {
										foreach($available_services as $service) {
                                        echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
										}
									}
									?>
								</select>
                                  </div>
                                </div>

                                <!-- Button -->
                                <div class="control-group">
                                  <div class="controls">
								  <input type="button" value="Generate" id="generate-daily" class="btn btn-primary">
                                  </div>
                                </div>

                                </fieldset>
                                </form>




                            </div>
                    </div>

                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                Monthly / Range Report
                            </h4>
                        </div>
                        <div class="panel-body">This report generates a tabulated view of appointments for a single
                         month, or a range of two dates. 
                        <form class="form-horizontal">
                            <fieldset>

                            <!-- Multiple Radios -->
                            <div class="control-group"  id="monthly-report">
                              <div class="controls">
                                <label class="radio">
                                  <input type="radio" name="radios" id="monthly-radio-single" value="Option one" checked="checked">Single Month
                                      <select id="selectbasic" name="selectbasic" class="input-xlarge">
                                  <option>January 2015</option>
                                  <option>February 2015</option>
                                  <option>March 2015</option>
                                  <option>April 2015</option>
                                </select>
                                </label>
                                <label class="radio">
                                  <input type="radio" name="radios" id="monthly-radio-ranged" value="Range">
                                  Date Range <input type="text" id="start-datetime" class="hasDatepicker"> to <input type="text" id="end-datetime" class="hasDatepicker">
                                </label>
								<select id="select-service">
                            <?php 
                                // Group services by category, only if there is at least one service 
                                // with a parent category.
                                foreach($available_services as $service) {
                                    if ($service['category_id'] != NULL) {
                                        $has_category = TRUE;
                                        break;
                                    }
                                }
                                
                                if ($has_category) {
                                    $grouped_services = array();

                                    foreach($available_services as $service) {
                                        if ($service['category_id'] != NULL) {
                                            if (!isset($grouped_services[$service['category_name']])) {
                                                $grouped_services[$service['category_name']] = array();
                                            }

                                            $grouped_services[$service['category_name']][] = $service;
                                        } 
                                    }

                                    // We need the uncategorized services at the end of the list so
                                    // we will use another iteration only for the uncategorized services.
                                    $grouped_services['uncategorized'] = array();
                                    foreach($available_services as $service) {
                                        if ($service['category_id'] == NULL) {
                                            $grouped_services['uncategorized'][] = $service;
                                        }
                                    }

                                    foreach($grouped_services as $key => $group) {
                                        $group_label = ($key != 'uncategorized')
                                                ? $group[0]['category_name'] : 'Uncategorized';
                                        
                                        if (count($group) > 0) {
                                            echo '<optgroup label="' . $group_label . '">';
                                            foreach($group as $service) {
                                                echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
                                            }
                                            echo '</optgroup>';
                                        }
                                    }
                                }  
								else {
										foreach($available_services as $service) {
                                        echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
										}
									}
									?>
								</select>
                              </div>
                            </div>


                            <!-- Button -->
                            <div class="control-group">
                                  <div class="controls">
								  <input type="button" value="Generate" id="generate-monthly" class="btn btn-warning">
                                  </div>
                                </div>

                            </fieldset>
                            </form>                                

                        </div>
                    </div>



                    <div class="panel panel-danger">
                        <div class="panel-heading">
                                <h4 class="panel-title">
                                    No-Show Report
                                </h4>
                        </div>
                            <div class="panel-body">This report generates a list of clients who have not shown up for an appointment, and have 
                                failed to reschedule</div>
                                    <form class="form-horizontal">
                                    <fieldset>

                                    <!-- Multiple Radios -->
                                    <div class="control-group" id="noshow-report">
                                      <!-- Multiple Radios <label class="control-label" for="radios">Multiple Radios</label>-->
                                      <div class="controls">
                                        <label class="radio">
                                          <input type="radio" name="radios" id="noshow-radio-active" value="Active Policy" checked="checked">
                                          Active Policy
                                        </label>
                                        <label class="radio">
                                          <input type="radio" name="radios" id="noshow-radio-select" value="Other">
                                              
                                              Date Range <input type="text" id="start-datetime" class="hasDatepicker"> to <input type="text" id="end-datetime" class="hasDatepicker">
                                        </label>
										
										<select id="select-service">
                            <?php 
                                // Group services by category, only if there is at least one service 
                                // with a parent category.
                                foreach($available_services as $service) {
                                    if ($service['category_id'] != NULL) {
                                        $has_category = TRUE;
                                        break;
                                    }
                                }
                                
                                if ($has_category) {
                                    $grouped_services = array();

                                    foreach($available_services as $service) {
                                        if ($service['category_id'] != NULL) {
                                            if (!isset($grouped_services[$service['category_name']])) {
                                                $grouped_services[$service['category_name']] = array();
                                            }

                                            $grouped_services[$service['category_name']][] = $service;
                                        } 
                                    }

                                    // We need the uncategorized services at the end of the list so
                                    // we will use another iteration only for the uncategorized services.
                                    $grouped_services['uncategorized'] = array();
                                    foreach($available_services as $service) {
                                        if ($service['category_id'] == NULL) {
                                            $grouped_services['uncategorized'][] = $service;
                                        }
                                    }

                                    foreach($grouped_services as $key => $group) {
                                        $group_label = ($key != 'uncategorized')
                                                ? $group[0]['category_name'] : 'Uncategorized';
                                        
                                        if (count($group) > 0) {
                                            echo '<optgroup label="' . $group_label . '">';
                                            foreach($group as $service) {
                                                echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
                                            }
                                            echo '</optgroup>';
                                        }
                                    }
                                }  
								else {
										foreach($available_services as $service) {
                                        echo '<option value="' . $service['id'] . '">' 
                                                    . $service['name'] . '</option>';
										}
									}
									?>
								</select>
                                      </div>
                                    </div>

                                    <!-- Button -->
									
                                  <div class="control-group">
                                    <div class="controls">
								    <input type="button" value="Generate" id="generate-noshow" class="btn btn-danger">
                                    </div>
                                  </div>

                                    </fieldset>
                                    </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>