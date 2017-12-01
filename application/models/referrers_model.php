<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Referrers_Model extends CI_Model {
    /**
     * Class Constructor
     */
    public function __construct() {
        parent::__construct();
    }
    
    /**
     * Add a customer record to the database.
     * 
     * This method adds a customer to the database. If the customer
     * doesn't exists it is going to be inserted, otherwise the 
     * record is going to be updated.
     *  
     * @param array $customer Associative array with the customer's 
     * data. Each key has the same name with the database fields.
     * @return int Returns the customer id.
     */
    public function add($referrer) {
        // Validate the customer data before doing anything.
        $this->validate($referrer);

        // :: CHECK IF CUSTOMER ALREADY EXIST (FROM NAME & DOB).	
        if ( $this->exists($referrer) && !isset($referrer['id_referrer'])) {
            throw new Exception('Duplicate referrer: A referrer with similar name and agency exists in the database.');
        	// Find the customer id from the database.
        	// $referrer['id_referrer'] = $this->find_record_id($referrer);
        }

        // :: INSERT OR UPDATE CUSTOMER RECORD
        if (!isset($referrer['id_referrer'])) {
            $referrer['id_referrer'] = $this->insert($referrer);
        } else {
            $this->update($referrer);
        }

        return $referrer['id_referrer'];
    }
    
    /**
     * Check if a particular referrer record already exists.
     * 
     * This method checks wether the given referrer already exists in 
     * the database. It doesn't search with the id, but with the following
     * fields: "first_name", "last_name" and "dob"
     * 
     * @param array $referrer Associative array with the referrer's 
     * data. Each key has the same name with the database fields.
     * @return bool Returns wether the record exists or not.
     */

    public function exists($referrer) {
        //////////////////////////////////////////INPUT REQUIRED/////////////////////////////////////////////////
        if (!isset($referrer['name']) || !isset($referrer['agency'])) {
            throw new Exception('Please fill in the required particulars: referrer name, agency');
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////VALIDATION//////////////////////////////////////////////
        /////////////////////////////TODO: WORK ON THE SLUG THINGY///////////////////////////////////////////////
        $num_rows = $this->db
                ->select('*')
                ->from('fairhope_referrers')
                ->where('fairhope_referrers.name', $referrer['name'])
                ->where('fairhope_referrers.agency', $referrer['agency'])
                ->get()->num_rows();

        return ($num_rows > 0) ? TRUE : FALSE;
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    }
    
    /**
     * Insert a new referrer record to the database.
     * 
     * @param array $referrer Associative array with the referrer's
     * data. Each key has the same name with the database fields.
     * @return int Returns the id of the new record.
     */
    private function insert($referrer) {
        
        ///////////////////////////////NOT SURE WHAT TO DO WITH THIS FOR NOW///////////////////////////////////////
        // Before inserting the customer we need to get the customer's role id
        // from the database and assign it to the new record as a foreign key.
        /*$customer_role_id = $this->db
                ->select('id')
                ->from('ea_roles')
                ->where('slug', DB_SLUG_CUSTOMER)
                ->get()->row()->id;
        
        $customer['id_roles'] = $customer_role_id;
        */

        if (!$this->db->insert('fairhope_referrers', $referrer)) {
            throw new Exception('Could not insert referrer to the database.');
        }
        
        return intval($this->db->insert_id());
    }
    
    /**
     * Update an existing customer record in the database.
     * 
     * The customer data argument should already include the record
     * id in order to process the update operation.
     * 
     * @param array $customer Associative array with the customer's
     * data. Each key has the same name with the database fields.
     * @return int Returns the updated record id.
     */
    private function update($referrer) {        
        // Do not update empty string values.
        foreach ($referrer as $key => $value) {
            if ($value === '') 
                unset($referrer[$key]);
        }
        
        $this->db->where('id_referrer', $referrer['id_referrer']);
        if (!$this->db->update('fairhope_referrers', $referrer)) {
            throw new Exception('Could not update referrer to the database.');
        }
        
        return intval($referrer['id_referrer']);
    }
    
    /**
     * Find the database id of a customer record. 
     * 
     * The customer data should include the following fields in order to 
     * get the unique id from the database: "email"
     * 
     * <strong>IMPORTANT!</strong> The record must already exists in the 
     * database, otherwise an exception is raised.
     * 
     * @param array $customer Array with the customer data. The 
     * keys of the array should have the same names as the db fields.
     * @return int Returns the id.
     */
    public function find_record_id($referrer) {
        if (!isset($referrer['name']) || !isset($referrer['agency'])) {
            throw new Exception('Please fill in the required particulars: referrer name, agency: ' 
                    . print_r($referrer, TRUE));
        }

        ///////////////////////////////
        error_log("what's the matter");
        
        // Get customer's role id
        //////////////////////////////////TODO::SLUG AGAIN///////////////////////////////////
        $result = $this->db
                ->select('fairhope_referrers.id_referrer')
                ->from('fairhope_referrers')
                ->where('fairhope_referrers.name', $referrer['name'])
                ->where('fairhope_referrers.agency', $referrer['agency'])
                ->get();

        ////////////////////////////////
        error_log("database access success");

        if ($result->num_rows() == 0) {
            throw new Exception('Could not find customer record id.');
        }
        
        return $result->row()->id_referrer;
    }
    
    /**
     * Validate customer data before the insert or update operation is executed.
     * 
     * @param array $customer Contains the customer data.
     * @return bool Returns the validation result.
     */
    public function validate($referrer) {
        $this->load->helper('data_validation');
        
        // If a customer id is provided, check whether the record
        // exist in the database.
        if (isset($referrer['id_referrer'])) {
            $num_rows = $this->db->get_where('fairhope_referrers', 
                    array('id_referrer' => $referrer['id_referrer']))->num_rows();
            if ($num_rows == 0) {
                throw new Exception('Provided referrer id does not ' 
                        . 'exist in the database.');
            }
        }
        // Validate required fields
        if (!isset($referrer['name'])
                || !isset($referrer['agency'])) { 
            throw new Exception('Not all required fields are provided : ' 
                    . print_r($referrer, TRUE));
        }
        
        return TRUE;
    }
    
    /**
     * Delete an existing customer record from the database.
     * 
     * @param numeric $customer_id The record id to be deleted.
     * @return bool Returns the delete operation result.
     */
    public function delete($id_referrer) {
        if (!is_numeric($id_referrer)) {
            throw new Exception('Invalid argument type $id_referrer : ' . $id_referrer);
        }
        
        // Check if id exists for referrer
        $num_rows = $this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer))->num_rows();
        if ($num_rows == 0) {
            return FALSE;
        }

        // Check if there exists a customer record under this referrer. Do not allow deletion if there is one.
        $num_rows = $this->db->get_where('ea_users', array('id_referrer' => $id_referrer))->num_rows();
        if ($num_rows != 0) {
            throw new Exception("Error: Cannot delete referrer. \nThere exists a customer record under this referrer. " .
                'An attempt to delete this referrer will result in the loss of customer data. Please delete '. 
                'customer data manually before deleting this referrer.');
        }
 
        return $this->db->delete('fairhope_referrers', array('id_referrer' => $id_referrer));
    }
    
    /**
     * Get a specific row from the appointments table.
     * 
     * @param numeric $customer_id The record's id to be returned.
     * @return array Returns an associative array with the selected
     * record's data. Each key has the same name as the database 
     * field names.
     */
    public function get_row($id_referrer) {
        if (!is_numeric($id_referrer)) {
            throw new Exception('Invalid argument provided as $id_referrer: ' . $id_referrer);
        }
        return $this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer))->row_array();
    }
    
    /**
     * Get a specific field value from the database.
     * 
     * @param string $field_name The field name of the value to be
     * returned.
     * @param int $customer_id The selected record's id.
     * @return string Returns the records value from the database.
     */
    public function get_value($field_name, $id_referrer) {
        if (!is_numeric($id_referrer)) {
            throw new Exception('Invalid argument provided as $id_referrer : ' 
                    . $customer_id);
        }
        
        if (!is_string($field_name)) {
            throw new Exception('$field_name argument is not a string : ' 
                    . $field_name);
        }
        
        if ($this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer))->num_rows() == 0) {
            throw new Exception('The record with the $id_referrer argument ' 
                    . 'does not exist in the database : ' . $id_referrer);
        }
        
        $row_data = $this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer)
                )->row_array();
        if (!isset($row_data[$field_name])) {
            throw new Exception('The given $field_name argument does not'
                    . 'exist in the database : ' . $field_name);
        }
        
        $referrer = $this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer))->row_array();
        
        return $referrer[$field_name];
    }
    
	/**
     * Set a specific field value from the database.
     * 
     * @param string $field_name The field name of the value to be
     * returned.
     * @param int $customer_id The selected record's id.
     * @param $value is the value to be set
     */
    public function set_value($field_name, $id_referrer, $value) {
        if (!is_numeric($id_referrer)) {
            throw new Exception('Invalid argument provided as $id_referrer : ' 
                    . $id_referrer);
        }
        
        if (!is_string($field_name)) {
            throw new Exception('$field_name argument is not a string : ' 
                    . $field_name);
        }
        
        if ($this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer))->num_rows() == 0) {
            throw new Exception('The record with the $id_referrer argument ' 
                    . 'does not exist in the database : ' . $id_referrer);
        }
        
        $row_data = $this->db->get_where('fairhope_referrers', array('id_referrer' => $id_referrer)
                )->row_array();
        if (!isset($row_data[$field_name])) {
            throw new Exception('The given $field_name argument does not'
                    . 'exist in the database : ' . $field_name);
        } 
        $referrer = $this->db->update('fairhope_referrers', array($field_name => $value));
    }

    /**
     * Get all, or specific records from appointment's table.
     * 
     * @example $this->Model->getBatch('id = ' . $recordId);
     * 
     * @param string $whereClause (OPTIONAL) The WHERE clause of  
     * the query to be executed. DO NOT INCLUDE 'WHERE' KEYWORD.
     * @return array Returns the rows from the database.
     */
    public function get_batch($where_clause = '') {
        /**************************************************NOT SURE**************************************************/
        //$customers_role_id = $this->get_customers_role_id();
        
        if ($where_clause != '') {
            $this->db->where($where_clause);
        }
        
        //$this->db->where('id_roles', $customers_role_id);
        
        ///////////////////////////////////////////////////////
        // console.log('DEBUGGING YO', $this->db->get('fairhope_referrers')->result_array());
        ///////////////////////////////////////////////////////

        return $this->db
                    ->select('*')
                    ->from('fairhope_referrers')
                    ->order_by('agency')
                    ->order_by('name')
                    ->get()->result_array();
    }
    

    /************************LEAVING THIS OUT FOR NOW. WILL BE BACK ONCE I SETTLE ON SLUG****************************/
    /**
     * Get the customers role id from the database.
     * 
     * @return int Returns the role id for the customer records.
     */
    public function get_customers_role_id() {
        return $this->db->get_where('ea_roles', array('slug' => DB_SLUG_CUSTOMER))->row()->id;
    }
}

/* End of file customers_model.php */
/* Location: ./application/models/customers_model.php */
