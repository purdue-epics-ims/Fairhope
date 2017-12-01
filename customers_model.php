<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Customers_Model extends CI_Model {
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
    public function add($customer) {
        // Validate the customer data before doing anything.
        $this->validate($customer);

        // :: CHECK IF CUSTOMER ALREADY EXIST (FROM NAME & DOB).	
        if ( $this->exists($customer) && !isset($customer['id'])) {
            throw new Exception('Duplicate client: A client with similar first name, last name, and DOB exists in the database.');
        	// Find the customer id from the database.
        	// $customer['id'] = $this->find_record_id($customer);
        }

        // :: INSERT OR UPDATE CUSTOMER RECORD
        if (!isset($customer['id'])) {
            $customer['id'] = $this->insert($customer);
        } else {
            $this->update($customer);
        }

        return $customer['id'];
    }
    
    /**
     * Check if a particular customer record already exists.
     * 
     * This method checks wether the given customer already exists in 
     * the database. It doesn't search with the id, but with the following
     * fields: "first_name", "last_name" and "dob"
     * 
     * @param array $customer Associative array with the customer's 
     * data. Each key has the same name with the database fields.
     * @return bool Returns wether the record exists or not.
     */

    public function exists($customer) {
        // Validate necessary fields.
        if (!isset($customer['first_name']) || !isset($customer['last_name']) || !isset($customer['dob'])) {
            throw new Exception('Please fill in the required particulars: first name, last name and date of birth.');
        }

        // Search for customer in DB
        $num_rows = $this->db
                ->select('*')
                ->from('ea_users')
                ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
                ->where('ea_users.last_name', $customer['last_name'])
                ->where('ea_users.first_name', $customer['first_name'])
                ->where('ea_users.dob', $customer['dob'])
                ->where('ea_roles.slug', DB_SLUG_CUSTOMER)
                ->get()->num_rows();

        return ($num_rows > 0) ? TRUE : FALSE;
    }
    
    /**
     * Insert a new customer record to the database.
     * 
     * @param array $customer Associative array with the customer's
     * data. Each key has the same name with the database fields.
     * @return int Returns the id of the new record.
     */
    private function insert($customer) {
        // Before inserting the customer we need to get the customer's role id
        // from the database and assign it to the new record as a foreign key.
        $customer_role_id = $this->db
                ->select('id')
                ->from('ea_roles')
                ->where('slug', DB_SLUG_CUSTOMER)
                ->get()->row()->id;
        
        $customer['id_roles'] = $customer_role_id;
        
        if (!$this->db->insert('ea_users', $customer)) {
            throw new Exception('Could not insert customer to the database.');
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
    private function update($customer) {        
        // Do not update empty string values.
        foreach ($customer as $key => $value) {
            if ($value === '') 
                unset($customer[$key]);
        }
        
        $this->db->where('id', $customer['id']);
        if (!$this->db->update('ea_users', $customer)) {
            throw new Exception('Could not update customer to the database.');
        }
        
        return intval($customer['id']);
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
    public function find_record_id($customer) {
        // Get customer's role id
        $result = $this->db
                ->select('ea_users.id')
                ->from('ea_users')
                ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
                ->where('ea_users.email', $customer['email'])
                ->where('ea_roles.slug', DB_SLUG_CUSTOMER)
                ->get();
        
        if ($result->num_rows() == 0) {
            throw new Exception('Could not find customer record id.');
        }
        
        return $result->row()->id;
    }
    
    /**
     * Validate customer data before the insert or update operation is executed.
     * 
     * @param array $customer Contains the customer data.
     * @return bool Returns the validation result.
     */
    public function validate($customer) {
        $this->load->helper('data_validation');
        
        // If a customer id is provided, check whether the record
        // exist in the database.
        if (isset($customer['id'])) {
            $num_rows = $this->db->get_where('ea_users', 
                    array('id' => $customer['id']))->num_rows();
            if ($num_rows == 0) {
                throw new Exception('Provided customer id does not ' 
                        . 'exist in the database.');
            }
        }
        // Validate required fields
        if (!isset($customer['last_name']) || !isset($customer['first_name']) || !isset($customer['dob'])) { 
            throw new Exception('Not all required fields are provided : ' 
                    . print_r($customer, TRUE));
        }
        
        /////////////////////////// NOT REQUIRED; EMAIL ADDRESS BELONGS TO REFERRER! ///////////////////////////////
        // When inserting a record the email address must be unique./
        /*$customer_id = (isset($customer['id'])) ? $customer['id'] : '';
        
        $num_rows = $this->db
                ->select('*')
                ->from('ea_users')
                ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
                ->where('ea_roles.slug', DB_SLUG_CUSTOMER)
                ->where('ea_users.email', $customer['email'])
                ->where('ea_users.id <>', $customer_id)
                ->get()
                ->num_rows();
        
        if ($num_rows > 0) {
            throw new Exception('Given email address belongs to another customer record. ' 
                    . 'Please use a different email.');
        }*/
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // Validate dob using regex
        $myDOBregex = '~^\d{2}/\d{2}/\d{4}$~';
        if (!preg_match($myDOBregex, $customer['dob'])) {
            throw new Exception('Invalid DOB format! Please follow the following format:
                mm\dd\yyyy');
        }
        
        return TRUE;
    }
    
    /**
     * Delete an existing customer record from the database.
     * 
     * @param numeric $customer_id The record id to be deleted.
     * @return bool Returns the delete operation result.
     */
    public function delete($customer_id) {
        if (!is_numeric($customer_id)) {
            throw new Exception('Invalid argument type $customer_id : ' . $customer_id);
        }
        
        $num_rows = $this->db->get_where('ea_users', array('id' => $customer_id))->num_rows();
        if ($num_rows == 0) {
            return FALSE;
        }
        
        return $this->db->delete('ea_users', array('id' => $customer_id));
    }
    
    /**
     * Get a specific row from the appointments table.
     * 
     * @param numeric $customer_id The record's id to be returned.
     * @return array Returns an associative array with the selected
     * record's data. Each key has the same name as the database 
     * field names.
     */
    public function get_row($customer_id) {
        if (!is_numeric($customer_id)) {
            throw new Exception('Invalid argument provided as $customer_id : ' . $customer_id);
        }
        return $this->db->get_where('ea_users', array('id' => $customer_id))->row_array();
    }
    
    /**
     * Get a specific field value from the database.
     * 
     * @param string $field_name The field name of the value to be
     * returned.
     * @param int $customer_id The selected record's id.
     * @return string Returns the records value from the database.
     */
    public function get_value($field_name, $customer_id) {
        if (!is_numeric($customer_id)) {
            throw new Exception('Invalid argument provided as $customer_id : ' 
                    . $customer_id);
        }
        
        if (!is_string($field_name)) {
            throw new Exception('$field_name argument is not a string : ' 
                    . $field_name);
        }
        
        if ($this->db->get_where('ea_users', array('id' => $customer_id))->num_rows() == 0) {
            throw new Exception('The record with the $customer_id argument ' 
                    . 'does not exist in the database : ' . $customer_id);
        }
        
        $row_data = $this->db->get_where('ea_users', array('id' => $customer_id)
                )->row_array();
        if (!isset($row_data[$field_name])) {
            throw new Exception('The given $field_name argument does not'
                    . 'exist in the database : ' . $field_name);
        }
        
        $customer = $this->db->get_where('ea_users', array('id' => $customer_id))->row_array();
        
        return $customer[$field_name];
    }
    
	/**
     * Set a specific field value from the database.
     * 
     * @param string $field_name The field name of the value to be
     * returned.
     * @param int $customer_id The selected record's id.
     * @param $value is the value to be set
     */
    public function set_value($field_name, $customer_id, $value) {
        if (!is_numeric($customer_id)) {
            throw new Exception('Invalid argument provided as $customer_id : ' 
                    . $customer_id);
        }
        
        if (!is_string($field_name)) {
            throw new Exception('$field_name argument is not a string : ' 
                    . $field_name);
        }
        
        if ($this->db->get_where('ea_users', array('id' => $customer_id))->num_rows() == 0) {
            throw new Exception('The record with the $customer_id argument ' 
                    . 'does not exist in the database : ' . $customer_id);
        }
        
        $row_data = $this->db->get_where('ea_users', array('id' => $customer_id)
                )->row_array();
        if (!isset($row_data[$field_name])) {
            throw new Exception('The given $field_name argument does not'
                    . 'exist in the database : ' . $field_name);
        } 
        $customer = $this->db->update('ea_users', array($field_name => $value));
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
        $customers_role_id = $this->get_customers_role_id();
        
        if ($where_clause != '') {
            $this->db->where($where_clause);
        }
        
        $this->db->where('id_roles', $customers_role_id);
        /*
	 $query=$this->db->query("select *, count(ea_users.num_noshow) as total from ea_users where ea_users.num_noshow=1)
	 */
        return $this->db
	//	->select('*','count(ea_users.num_noshow) where ea_users.num_noshow=1 as total')
		->select('*')
	//	->select('count(ea_users.num_noshow) where ea_users.num_noshow=1 as total')	
    	//	->count_all
			->from('ea_users')
		    ->join('fairhope_referrers','ea_users.id_referrer=fairhope_referrers.id_referrer')
		    ->order_by('last_name')
		    ->order_by('first_name')
		    
/*		    union all 
		    ->select('count(num_noshow) where num_noshow=1 as total')
		    ->from('ea_users')
		    ->where('num_noshow',1)
 	             
 */
                    ->get()->result_array();
    }
    
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
