script cyberrealm.ash;

void main()
{
   if (get_property("_variables_initialized") != true)
   {
      cli_execute("interjector initialize");
   }

   int cr_advs = get_property("_cr_advs").to_int();
   boolean cr_finished = get_property("_cr_finished").to_boolean();

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

      cli_execute("mcd 0");
      // TODO: create mood in script using maximizer??
      cli_execute("mood soothingpresence");
      cli_execute("mood execute");


      // hat: cybervisor
      // shirt: zero-trust tanktop
      // back: cryptocloak
      // weapon: brute force hammer, encrypted shuriken, geofencing rapier
      // off-hand: visual packet sniffer, geofencing shield, malware injector, trojan horseshoe
      // pants: digibritches, wired underwear
      // accessory: pocket GPU, retro floppy disk
      // familiar: familiar-in-the-middle wrapper

      // TODO: improve and generalize outfit selection
      outfit("Cyberrealm");
      equip($slot[familiar], $item[familiar-in-the-middle wrapper]);
      print("Adventuring in the Cyberrealm", "green");
      
      string combat_script = "";
      // Combat against hackers
      combat_script += "[$phylum[dude]]; attack with weapon; skill saucegeyser; repeat;";

      // Combat against the rest
      combat_script += "while !pastround 24; skill Brute Force Hammer; skill throw cyber rock; repeat; endwhile;";
      
      // If we run into trouble
      combat_script += "if hppercentbelow 50; skill launch logic grenade; endif; if pastround 24; skill launch logic grenade; endif;"

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
               adv1($location[Cyberzone 3], -1, combat_script);
            } else if (get_property("_cyberZone2Turns").to_int() < 20)
            {
               adv1($location[Cyberzone 2],-1, combat_script);
            } else if (get_property("_cyberZone1Turns").to_int() < 20)
            {
               adv1($location[Cyberzone 1],-1, combat_script);
            }
         }
      }
   }
}
