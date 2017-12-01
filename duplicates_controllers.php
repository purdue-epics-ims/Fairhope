<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

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
	
 //public function exists($customer) {
        // Validate necessary fields.
        //if (!isset($customer['first_name']) || !isset($customer['last_name']) || !isset($customer['dob'])) {
            //throw new Exception('Please fill in the required particulars: first name, last name and date of birth.');
        //}

        // Search for customer in DB
        //$num_rows = $this->db
                //->select('*')
                //->from('ea_users')
                //->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
                //->where('ea_users.last_name', $customer['last_name'])
                //->where('ea_users.first_name', $customer['first_name'])
                //->where('ea_users.dob', $customer['dob'])
                //->where('ea_roles.slug', DB_SLUG_CUSTOMER)
                //->get()->num_rows();

        //return ($num_rows > 0) ? TRUE : FALSE;
    //}
	// same function as in views
	
public function merge($customer) {
// Merges the data of the two or more duplicate clients
	if (!isset($customer['first_name']) && !isset($customer['last_name']) && !isset($customer['dob'])) {
            throw new Exception('The two clients must be merged before continuing.');
        }
  // Search for customer in DB
        $num_rows = $this->db
                ->select('*')
                ->from('ea_users')
                ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
                ->where('ea_users.last_name', $customer['last_name']) !('ea_users.last_name', $customer['last_name'])
                ->where('ea_users.first_name', $customer['first_name'])
                ->where('ea_users.dob', $customer['dob'])
                ->where('ea_roles.slug', DB_SLUG_CUSTOMER)
                ->get()->num_rows();

        return ($num_rows > 0);
/* End of file user.php */
/* Location: ./application/controllers/user.php */