<?php
//search_model.php (Array of Objects)
class Search_model extends CI_Model{
  function get_search($q){
    $this->db->select('*');
    $this->db->like('first_name', $q);
    $this->db->like('last_name', $q);

    $query = $this->db->get('ea_users');
    if($query->num_rows > 0){
      foreach ($query->result_array() as $row){
        $new_row['value']=htmlentities(stripslashes($row['first_name']));
        $new_row['value']=htmlentities(stripslashes($row['last_name']));
        $row_set[] = $new_row; //build an array
      }
      echo json_encode($row_set); //format the array into json data
    }
  }
}