//  Copyright © 2020  Hethsron Jedaël BOUEYA

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

/**
    @file               Contacts.swift
    @details         Describe specific characteristic of contact
    
    @author         Hethsron Jedaël BOUEYA (hethsron-jedael.boueya@uha.fr)
    @author         Pranamika SOLANKI  (pranamika.solanki@uha.fr)
 
    @version        0.0.1
    @date            November 10th, 2020
 
    @copyright     GPL3+ : GNU GPL version 3 or later, Licencied Material - Property of Hethsron
*/
import Foundation

/**
    @cstruct          Contact
    @brief              Describe specific characteristic of contact
 */
struct Contact {
    var lastname : String;
    var firstname : String;
    var address : String;
    var phone : String;
    var email : String;
}
