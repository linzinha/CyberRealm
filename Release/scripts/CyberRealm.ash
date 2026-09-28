script cyberrealm.ash;

void main()
{
   if (get_property("_variables_initialized") != true)
   {
      cli_execute("interjector initialize");
   }
   if (cr_finished == true) 
   {
      print("The cyberrealm has already been completed today", "green");
   } 
   else 
   {
      if (cr_advs < 1) 
      {
         set_property("_cr_advs", my_adventures());
         cr_advs = get_property("_cr_advs").to_int();
      }

      outfit("Cyberrealm");
      equip($slot[familiar], $item[familiar-in-the-middle wrapper]);
      print("Adventuring in the Cyberrealm", "green");
      cli_execute("mcd 0");
      cli_execute("mood soothingpresence");
      set_ccs("cyberrealm");

      while (get_property("_cr_finished") == false) 
      {
         if ((get_property("_cyberZone1Turns").to_int() == 20) && 
            (get_property("_cyberZone3Turns").to_int() == 20) && 
            (get_property("_cyberZone2Turns").to_int() == 20)) 
         {
            print("The cyberrealm has been completed", "green");
            set_property("_cr_advs", cr_advs - my_adventures());
            set_property("_cr_finished", true);
            equip($slot[familiar], $item[tiny stillsuit]);
         }
         else 
         {
            //run adventures
            cli_execute("interjector full");
            if (get_property("_ccs_changed") == "true") 
            {
                print("we changed our CCS!");
                set_property("_ccs_changed", false);
                set_ccs("cyberrealm");
                // TODO create a function that handles monster level
                cli_execute("mcd 0");
               cli_execute("mood soothingpresence");
            } else 
            {
                print("we DID NOT change our CCS!");
            }
            if (get_property("_cyberZone3Turns").to_int() < 20) 
            {
               adv1($location[Cyberzone 3],-1,"");
            } else if (get_property("_cyberZone2Turns").to_int() < 20)
            {
               adv1($location[Cyberzone 2],-1,"");
            } else if (get_property("_cyberZone1Turns").to_int() < 20)
            {
               adv1($location[Cyberzone 1],-1,"");
            }
         }
      }
   }
}
